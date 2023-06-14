local config   = require "config"
local log      = require "log"
local process  = require "process"
local torrents = require "torrents"

local signal_refs = {}

local replacements = {}
replacements["%%N"] = function(torrent)
    return torrent.name
end

replacements["%%D"] = function(torrent)
    return torrent.save_path
end

replacements["%%T"] = function(torrent)
    return torrent.current_tracker
end

local function build_args(args, torrent)
    if args == nil or #args == 0 then
        return nil
    end

    local new_args = {}

    for _, arg in pairs(args) do
        local replaced = arg

        for key, func in pairs(replacements) do
            replaced = string.gsub(replaced, key, func(torrent))
        end

        table.insert(new_args, replaced)
    end

    return new_args
end

local function run(rule, torrent)
    print("launching "..rule.file)
    process.launch({
        file = rule.file,
        args = build_args(rule.args, torrent),
        done = function(exit_code)
            if exit_code ~= 0 then
                log.error(string.format("%s failed with exit code %d", rule.file, exit_code))
            end
        end
    })
end

function porla.init()
    if config.exec == nil or config.exec.rules == nil or #config.exec.rules == 0 then
        log.warning "No exec rules found"
        return
    end

    log.info(string.format("Setting up %d exec rule(s)", #config.exec.rules))

    for _, rule in pairs(config.exec.rules) do
        if rule.on == nil then
            log.warning "Rule is missing 'on' field"
            goto next_rule
        end

        if rule.file == nil then
            log.warning "Rule is missing 'file' field"
            goto next_rule
        end

        table.insert(
            signal_refs,
            torrents.on(rule.on, function(torrent)
                run(rule, torrent)
            end))

        ::next_rule::
    end
end
