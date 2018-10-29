require 'benchmark'

def array_sub(arr1, arr2)
  arr1 - arr2
end

require 'set'
def set_sub(set1, set2)
  set1 - set2
end

def set_conversion_sub(arr1, arr2)
  set1 = Set.new arr1
  set2 = Set.new arr2
  set1 - set2
end

# ----- Benchmark Preparations

puts 'Preparing benchmark...'

# Creates required arrays of 3 million elements
arr1 = (0..2_999_999).to_a
arr2 = (0..2_999_999).to_a

# Creates required sets with same elements
set1 = Set.new arr1
set2 = Set.new arr2

# --- Benchmark three methods
Benchmark.bmbm(11) do |x|
  x.report('Array Subtraction:') { array_sub(arr1, arr2) }
  x.report('Direct Set Subtraction:') { set_sub(set1, set2) }
  x.report('Convert to Set and Subtract:') { set_conversion_sub(arr1, arr2) }
end
