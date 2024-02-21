# convert a field to an int
# example:
#   > {foo: {bar: {baz: "1"}}} | field_to_int foo.bar.baz
#   {foo: {bar: {baz: 1}}}
export def field_to_int [path: cell-path]: record -> record {
  $in
  | update $path {
    $in
    | get $path
    | into int
  } #
}
