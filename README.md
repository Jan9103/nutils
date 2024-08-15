# NUshell UTILS

Utility functions for nushell, which im to lazy to reimplement for every single script i write.

Things might get added to nushell or the official stdlib at some point (or get easier), but
for backward-compatability reasons ill keep them in here for a while.

## Functions

### List

* `nutils list index_of <value>`
* `nutils list indexes_of <value>`
* `nutils list to_record`
* `nutils list kv_to_record <key_column_name> <value_column_name>`

### Record

* `nutils record field_to_int <cell-path>` converts a fields value to integer

### Path

* `nutils path list_pardirs` generates a list of all parent directories

### Compat

compatability layer for programs

* `nutils compat is_installed <command>`
* `nutils compat sudo <...command>` automatically uses `sudo`, `doas`, etc based on what `is_installed`

### Parsed

adds parsed versions of common commands

* `nutils parsed rg <regex> <files>`

### Shell Utility

* `nutils shutil nu_c` converts a code-block to `nu -c "CODE"` syntax

### HTML

* `nutils html escape` escapes characters with special meaning in html using `&`-codes

### Progress

* `nutils progress bar_each <cmd> (width) (ansi)` `each` with an added progress bar
* `nutils progress bar_with_count <done> <total> (width) (ansi)` generate a progress-bar
