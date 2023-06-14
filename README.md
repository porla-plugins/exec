# A Porla plugin to run executables

This plugin provides a simple, config first approach to running executables
on various events in Porla - for example when a torrent is added, finished or
removed.

Multiple rules can run for the same event.

## Configuration

```toml
[[exec.rules]]
on   = "added"
file = "/my/awesome/script.sh"
args = ["--name", "%N"]
```

### Events (on)

 * `added`
 * `finished`
 * `paused`
 * `removed`

### Tokens

Each invocation can use these tokens to pass torrent specific data to the
executable.

 * `%D` - the save path.
 * `%N` - the name of the torrent.
 * `%T` - the current tracker (if any).
