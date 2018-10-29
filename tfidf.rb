# Require dependencies
require 'benchmark'
require 'tf-idf-similarity'
require 'csv'

# --- Standard ruby matrix
# Creates document-term matrix with tf-idf method with standard ruby matrix
# https://en.wikipedia.org/wiki/Tf%E2%80%93idf
def std_tfidf_document_term_matrix(documents, debug = false)
  # Creates model
  printf("\rCreating similarity model...") if debug
  model = TfIdfSimilarity::TfIdfModel.new(documents)
  printf("\rCreating similarity model... Done!\n") if debug
  # Creates similarity matrix
  printf("\rCreating similarity matrix...") if debug
  model.similarity_matrix
  printf("\rCreating similarity matrix... Done!\n") if debug
end

# Creates document-term matrix with tf-idf method with standard ruby matrix
# https://en.wikipedia.org/wiki/Okapi_BM25
def std_okapi_bm25_document_term_matrix(documents, debug = false)
  # Creates model
  printf("\rCreating similarity model...") if debug
  model = TfIdfSimilarity::BM25Model.new(documents)
  printf("\rCreating similarity model... Done!\n") if debug
  # Creates similarity matrix
  printf("\rCreating similarity matrix...") if debug
  model.similarity_matrix
  printf("\rCreating similarity matrix... Done!\n") if debug
end

# --- NArray ruby gem
# Creates document-term matrix with tf-idf method with NArray gem
# https://en.wikipedia.org/wiki/Tf%E2%80%93idf
def na_tfidf_document_term_matrix(documents, debug = false)
  # Creates model
  printf("\rCreating similarity model...") if debug
  model = TfIdfSimilarity::TfIdfModel.new(documents, library: :narray)
  printf("\rCreating similarity model... Done!\n") if debug
  # Creates similarity matrix
  printf("\rCreating similarity matrix...") if debug
  model.similarity_matrix
  printf("\rCreating similarity matrix... Done!\n") if debug
end

# Creates document-term matrix with tf-idf method with NArray gem
# https://en.wikipedia.org/wiki/Okapi_BM25
def na_okapi_bm25_document_term_matrix(documents, debug = false)
  # Creates model
  printf("\rCreating similarity model...") if debug
  model = TfIdfSimilarity::BM25Model.new(documents, library: :narray)
  printf("\rCreating similarity model... Done!\n") if debug
  # Creates similarity matrix
  printf("\rCreating similarity matrix...") if debug
  model.similarity_matrix
  printf("\rCreating similarity matrix... Done!\n") if debug
end

# --- NMatrix ruby gem
# Creates document-term matrix with tf-idf method with NMatrix gem
# https://en.wikipedia.org/wiki/Tf%E2%80%93idf
def nm_std_tfidf_document_term_matrix(documents, debug = false)
  # Creates model
  printf("\rCreating similarity model...") if debug
  model = TfIdfSimilarity::TfIdfModel.new(documents, library: :nmatrix)
  printf("\rCreating similarity model... Done!\n") if debug
  # Creates similarity matrix
  printf("\rCreating similarity matrix...") if debug
  model.similarity_matrix
  printf("\rCreating similarity matrix... Done!\n") if debug
end

# Creates document-term matrix with tf-idf method with NMatrix gem
# https://en.wikipedia.org/wiki/Okapi_BM25
def nm_okapi_bm25_document_term_matrix(documents, debug = false)
  # Creates model
  printf("\rCreating similarity model...") if debug
  model = TfIdfSimilarity::BM25Model.new(documents, library: :nmatrix)
  printf("\rCreating similarity model... Done!\n") if debug
  # Creates similarity matrix
  printf("\rCreating similarity matrix...") if debug
  model.similarity_matrix
  printf("\rCreating similarity matrix... Done!\n") if debug
end

# ----- Benchmark Preparations

puts 'Preparing benchmark...'

# Reads dataset
articles = CSV.read('datasets/articles.csv')
articles = articles[1..(articles.length - 1)]
# Puts dataset size
puts 'Dataset Size: ' + articles.length.to_s

# Converts each article to bag of words
documents = []
count = 0
articles.each do |article|
  printf("\rProcessed articles %d/%d...", count, articles.length)
  text = article[4..5].join(' ').encode('UTF-8')
  documents << TfIdfSimilarity::Document.new(text)
  count += 1
end
printf("\rProcessed articles %d/%d. Done!\n", count, articles.length)

# --- Benchmark two models
Benchmark.bmbm(11) do |x|
  # -- Standard
  require 'Matrix'
  x.report('Standard TF-IDF:') { std_tfidf_document_term_matrix(documents) }
  x.report('Standard Okapi-BM25:') do
    std_okapi_bm25_document_term_matrix(documents)
  end
  # -- NArray
  require 'narray'
  x.report('NArray TF-IDF:') { na_tfidf_document_term_matrix(documents) }
  x.report('NArray Okapi-BM25:') do
    na_okapi_bm25_document_term_matrix(documents)
  end
  # # -- NMatrix
  # require 'nmatrix'
  # x.report('NMatrix TF-IDF:') { na_tfidf_document_term_matrix(documents) }
  # x.report('NMatrix Okapi-BM25:') do
  #   na_okapi_bm25_document_term_matrix(documents)
  # end
end

# ruby tfidf.rb
# Preparing benchmark...
# Dataset Size: 337
# Processed articles 337/337. Done!
# Rehearsal --------------------------------------------------------
# Standard TF-IDF:     633.281000   0.391000 633.672000 (646.125836)
# Standard Okapi-BM25: 609.094000   0.218000 609.312000 (609.554999)
# NArray TF-IDF:        23.515000   0.157000  23.672000 ( 23.670171)
# NArray Okapi-BM25:    13.813000   0.172000  13.985000 ( 13.980016)
# -------------------------------------------- total: 1280.641000sec

#                            user     system      total        real
# Standard TF-IDF:     569.671000   0.157000 569.828000 (569.895037)
# Standard Okapi-BM25: 559.375000   0.157000 559.532000 (559.752091)
# NArray TF-IDF:        23.609000   0.047000  23.656000 ( 23.656216)
# NArray Okapi-BM25:    14.016000   0.125000  14.141000 ( 14.143514)