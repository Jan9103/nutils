# Progress Bar with Count
# returns string, does not print
# Note: with tiny widths it might be bigger than speified
export def bar_with_count [
  done: int  # At which value are we?
  total: int  # At which value will it be completed (100%)?
  width?: int  # How wide should it be in total (with decorations) (defaults to terminal width)
  ansi?: list<string> = ["reset" "cyan" "reset" "green" "cyan"]  # Arguments for "ansi" for [decoration, bar, empty, done, total] or [] for no ansi
]: nothing -> string {
  let width = ((if $width != null { $width } else { term size | get columns }) - ($"[][]($done)/($total)" | str length))
  let fillcount = (($done * ($width / $total)) | math round)
  let left = ("" | fill -c "#" -w $fillcount)
  let right = ("" | fill -c " " -w ($width - $fillcount))
  if $ansi == [] {
    $"[($left)($right)]\(($done)/($total)\)"
  } else {
    $"(ansi $ansi.0)[(ansi $ansi.1)($left)(ansi $ansi.2)($right)(ansi $ansi.0)]\((ansi $ansi.3)($done)(ansi $ansi.0)/(ansi $ansi.4)($total)(ansi $ansi.0)\)(ansi reset)"
  }
}

# `each`, but with a added progress bar after each handled entry
export def bar_each [
  cmd: closure  # normal "each" argument. example: "{|i| echo $i}"
  width?: int  # How wide should it be in total (with decorations) (defaults to terminal width)
  ansi?: list<string> = ["reset" "cyan" "reset" "green" "cyan"]  # Arguments for "ansi" for [decoration, bar, empty, done, total] or [] for no ansi
]: list -> list {
  let items = ($in)
  let total = ($items | length)
  let result = ($items | enumerate | each {|i|
    print (bar_with_count $i.index $total $width $ansi)
    do $cmd $i.item
  })
  print (bar_with_count $total $total $width $ansi)
  $result
}
