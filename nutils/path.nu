# example:
#   ("/home/user" | list_pardirs) == ["/", "/home", "/home/user"]
export def list_pardirs []: string -> list<string> {
  let parts = ($in | path split)
  0..(($parts | length) - 1)
  | each {|i| $parts | range 0..($i) | path join}
}

# example:
#   ($env.PWD | path expand | find_in_parents ".git") == "/home/user/projects/nutils"
# returns null if not found, string otherwise
export def find_in_pardirs [name: string]: string -> any {
  for parent in ($in | list_pardirs) {
    if ($parent | path join $name | path exists) {
      return $parent
    }
  }
  return null
}
