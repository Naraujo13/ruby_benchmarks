require 'benchmark'
require 'parallel'

def process_without_defining_the_number_of_workers(arr)
  Parallel.each_with_index(
    arr
  ) { |element, index| }
end

def process_with_n_workers(arr, n)
  Parallel.each_with_index(
    arr,
    in_processes: n
  ) { |element, index| }
end

# ----- Benchmark Preparations

puts 'Preparing benchmark...'

# Creates required arrays of 5 million elements
arr = (0..9_999_999).to_a

# --- Benchmark with different number of workers
Benchmark.bmbm(11) do |x|
  x.report('Processing without settting the number of workers:') do
    process_without_defining_the_number_of_workers(arr)
  end
  x.report('Processing with 1 worker:') { process_with_n_workers(arr, 1) }
  x.report('Processing with 2 worker:') { process_with_n_workers(arr, 2) }
  x.report('Processing with 4 worker:') { process_with_n_workers(arr, 4) }
  x.report('Processing with 8 worker:') { process_with_n_workers(arr, 8) }
  x.report('Processing with 16 worker:') { process_with_n_workers(arr, 16) }
  x.report('Processing with 32 worker:') { process_with_n_workers(arr, 32) }
  x.report('Processing with 64 worker:') { process_with_n_workers(arr, 64) }
  x.report('Processing with 128 worker:') { process_with_n_workers(arr, 128) }
  x.report('Processing with 256 worker:') { process_with_n_workers(arr, 256) }
end
