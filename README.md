# NUshell UTILS

Utility functions for nushell, which im to lazy to reimplement for
every single script i write.

## Functions

### List

* `nutils list index_of <value>`-codes
* `nutils list indexes_of <value>`-codes
* `nutils list to_record`-codes

### Record

* `nutils record field_to_int <cell-path>` converts a fields value to integer

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
