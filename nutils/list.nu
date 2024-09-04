# get all indexes of a item
# > [a b c a] | indexes-of a
# [0 3]
# > [a b c a] | indexes-of d
# []
export def indexes_of [thing_to_index: any]: list -> list<int> {
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
export def to_record []: list<list> -> record {
  $in | reduce -f {} {|it,acc| $acc | upsert $it.0 $it.1?}
}

# > [{key: a, value: 1}, {key: b, value: 2}] | nutils list kv_to_record "key" "value"
# {a: 1, b: 2}
export def kv_to_record [key_column: string, value_column: string]: list<record> -> record {
  $in | reduce -f {} {|it,acc| $acc | upsert ($it | get $key_column) ($it | get -i $value_column)}
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

# inject a item into a list at index
# example:
#  ([0 1 2] | inject 0 hi) == [hi 0 1 2]
#  ([0 1 2] | inject 1 hi) == [0 hi 1 2]
export def inject [index: int, item: any]: list -> list {
  let input_list = ($in)
  return [
    ...($input_list | first $index)
    $item
    ...($input_list | last (($input_list | length) - $index))
  ]
}
