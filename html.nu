# Escape characters with special menaings in html (simple and fast).
# NOTE: This does not convert UTF-8 to html (umlauts, etc are not escaped)!
#
# examples:
# ("<foo>" | nutils html escape) == "&lt;foo&gt;"
# (nutils html escape "<foo>") == "&lt;foo&gt;"
export def escape [text?: string] {
  (if $text == null {$in} else {$text})
  | str replace "&" "&amp;"
  | str replace "<" "&lt;"
  | str replace ">" "&gt;"
  | str replace '"' "&quot;"
}
