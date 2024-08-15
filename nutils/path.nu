# example:
#   ("/home/user" | list_pardirs) == ["/", "/home", "/home/user"]
export def list_pardirs []: string -> list<string> {
  let parts = ($in | path split)
  0..(($parts | length) - 1)
  | each {|i| $parts | range 0..($i) | path join}
}
