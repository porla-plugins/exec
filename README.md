# A Porla plugin to run executables

This plugin provides a simple, config first approach to running executables
on various events in Porla - for example when a torrent is added, finished or
removed.

Multiple rules can run for the same event.

## Configuration

This plugin is configured with Lua. Use the following snippet as a guide.

```lua
return {
    {
        on = "torrent_added",
        file = "/my/awesome/script.sh"
        args = {"%N"}
    },
    {
        on = "torrent_paused",
        file = "/my/awesome/script2.sh"
        args = {"%D", "%N"}
    }
}
```

### Events (on)

These are the events you can listen for.

 * `torrent_added`
 * `torrent_finished`
 * `torrent_paused`
 * `torrent_removed`

### Tokens

Each invocation can use these tokens to pass torrent specific data to the
executable.

 * `%D` - the save path.
 * `%N` - the name of the torrent.
 * `%T` - the current tracker (if any).
