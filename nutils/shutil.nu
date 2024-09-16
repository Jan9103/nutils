# convert a codeblock to `nu -c "CODE"`
export def nu_c [code: any]: nothing -> string {
  let code = (
    view source $code
    | to json  # escape quotes, etc
    | str substring 2..-2  # remove "{ and }"
  )
  $'nu -c "($code)"'
}


# rerun a closure until it no longer fails (or --max-retries is reached)
# supports stdin and stdout
#
# example:
#   run_with_retry {|| http get http://localhost/api/foo.json } | save response.json
export def run_with_retry [
  code: any
  --max-retries(-r): int = 10
  --sleep-between-retries(-s): duration = 30sec
]: any -> any {
  let stdin = ($in)
  mut success = false
  mut result = null
  for unused_variable in 1..($max_retries) {
    try {
      $result = ($stdin | do $code)
      $success = true
      break
    }
    sleep $sleep_between_retries
  }
  if $success == false {
    error make { msg: $"reached max-retries for (nu_c $code)" }
  }
  $result
}
