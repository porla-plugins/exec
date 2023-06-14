# A Porla plugin to run executables

This plugin provides a simple, config first approach to running executables
on various events in Porla - for example when a torrent is added, finished or
removed.

Multiple rules can run for the same event.

## Configuration

```toml
[[exec.rules]]
on   = "torrent_added"
file = "/my/awesome/script.sh"
args = ["--name", "$TorrentName"]
```

### Events (on)

 * `torrent_added`
 * `torrent_finished`
 * `torrent_paused`
 * `torrent_removed`

### Tokens

Each invocation can use these tokens to pass torrent specific data to the
executable.

 * `TorrentName`
