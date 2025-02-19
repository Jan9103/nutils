# NUshell UTILS

Utility functions for nushell, which im to lazy to reimplement for every single script i write.

Things might get added to nushell or the official stdlib at some point (or get easier), but
for backward-compatability reasons ill keep them in here for a while.

[numng](https://github.com/Jan9103/numng) package name: `jan9103/nutils`

## Functions

Everything is split into modules, which allows more efficient loading.  
If performance is no concern just `use nutils` and access everything via `nutils [MODULE] [COMMAND]`.  
However, its more efficient to `use nutils/list.nu` (-\> `list [COMMAND]`) or `use nutils/list.nu index_of inject` (-\> `index_of`, `inject`).

Module     | Command                         | Description / Example
---------- | ------------------------------- | ---------------------
`compat`   | `is_installed <command-name>`   | check if a program is in the `$env.PATH`
`compat`   | `sudo <command> <...args>`      | choose between `sudo`, `doas`, etc based on what is installed
`html`     | `escape`                        | basic html escape to prevent code injection (does NOT format utf-8 to ampersand syntax)
`list`     | `index_of <value>`              | here in a list is a item (returns either the first instance or `null`)
`list`     | `indexes_of <value>`            | where in a list is a item (returns a list of indexes)
`list`     | `inject <index> <item>`         | `[0, 1, 2] | inject 1 hi` -\> `[0, hi, 1, 2]`
`list`     | `kt_to_record <key_column_name> <value_column_name>` | the inverse of `transpose` (`[{key: a, value: b}] \| kt_to_record key value` -\> `{a: b}`)
`list`     | `to_record`                     | `[[a, b], [c, d]]` -\> `{a: b, c: d}`
`parsed`   | `rg <regex> <files>`            | get `rg` (aka `ripgrep`) results as a nu table
`path`     | `find_in_parents <name>`        | find out where (or `null`) something is in the path above (for example: find git-project root)
`path`     | `list_pardirs`                  | list parent directories (`"/home/bob"` -\> `["/", "/home", "/home/bob"]`)
`path`     | `with_tmpfile <code>`           | provide a piece of code with a tmpfile and ensure its deletion
`progress` | `bar_each <cmd> (width) (ansi)` | `each`, but with a progress bar
`progress` | `bar_with_count <done> <total> (width) (ansi)` | generate a progress bar ascii/ansi-art
`record`   | `field_to_int <cell-path>`      | convert a fields value to a int (`{a: "1"} \| field_to_int a` -\> `{a: 1}`)
`shutil`   | `nu_c`                          | convert a code-block to `nu -c "CODE"` syntax
`shutil`   | `run_with_retry <closure>`      | re-run a closure until it no longer fails (useful for web-requests, etc)

A more complete syntax can be found at `[COMMAND] --help`


## Sibling projects (topic specific extensions)

* [nagoya](https://github.com/Jan9103/nagoya): multithreading helper library.
* [potash](https://github.com/Jan9103/potash): (WIP) terminal-user-interface library.
* [webserver.nu](https://github.com/Jan9103/webserver.nu): framework for building a webserver.
