# convert a codeblock to `nu -c "CODE"`
export def nu_c [code: block]: nothing -> string {
  let code = (
    view source $code
    | to json  # escape quotes, etc
    | str substring 2..-2  # remove "{ and }"
  )
  $'nu -c "($source_code)"'
}
