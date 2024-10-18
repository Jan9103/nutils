export def is_installed [program: string]: nothing -> bool {
  (find_binary_in_path $program) != null
}

# returns the first instance of the binary it can find in $env.PATH or null
export def find_binary_in_path [name: string]: nothing -> string {
  which $name | where type == "external" | get -i 0.path
}

const sudo_options = [
  # sorted by priority
  "sudo --"
  "doas --"  # https://man.openbsd.org/doas
  "systemd-run --pty --same-dir --wait --collect --service-type=exec --quiet --"
  "pkexec"  # https://wiki.archlinux.org/title/Polkit (often installed without required daemon running) (does not support `--`)
  "please"  # https://gitlab.com/edneville/please (does not support `--`)
  "sup"  # https://oldgit.suckless.org/sup (does not support `--`)
]

# automatically use doas, sudo, or whatever else might be available
# only supports basic usages (`compat sudo pkill nginx`) and not
# any of the fancy arguments like `-e`
export def sudo [...args: string]: nothing -> any {
  use ./list.nu first_matching
  let option = ( $sudo_options | first_matching {|it| is_installed ($it | split row " " -n 2 | get 0) } )
  if $option == null {
    error make {
      "msg": "nutils: No supported sudo alternative found on this system",
      "help": ("install one of: " + ( $sudo_options | each {|i| $i | split row " " -n 2 | get 0} | str join ', ' ) + "; OR open a issue mentioning the one you use"),
    }
  }
  let tmp = ( $option | split row " " )
  let args = ($args | prepend ($tmp | skip 1 ))
  ^$tmp.0 ...$args
}
