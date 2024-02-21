# get all indexes of a item
# > [a b c a] | indexes-of a
# [0 3]
# > [a b c a] | indexes-of d
# []
export def indexes_of [thing_to_index: any]: list -> list {
  $in
  | enumerate
  | where item == $thing_to_index
  | get index
}

# get the first index of an item (or null)
# > [a b c] | index-of a
# 0
# > [a b c] | index-of d
# null
export def index_of [thing_to_index: any]: list -> any {
  $in | indexes_of $thing_to_index | get 0?
}

# > [[a 1] [b 2]] | nutils list to_record
# {a: 1, b: 2}
export def to_record []: list -> record {
  let input = ($in)  # for some reason `for i in $in` dosn't work
  mut out = {}
  for i in $input {  # `| each` is not mut compatable
    $out = ($out | upsert $i.0 $i.1)
  }
  $out
}

# `where`, but only return the first match (potentially reducing redundant expensive checks)
# default: null
# example:
#  ["sudo" "doas"] | first_matching {|i| is_installed $i}
export def first_matching [predicate]: list -> any {
  for i in $in {
    if (do $predicate $i) {return $i}
  }
  return null
}
