require "./instance.rb"
require "./naive_bayesian_classifier.rb"

DEFAULT_TRAINING_FILE = "spamLabelled.dat".freeze
DEFAULT_TEST_FILE     = "spamUnlabelled.dat".freeze

# define helper methods
def read_file(file)
  File.readlines(file).reject { |line| line.strip.empty? }.map do |line|
    Instance.new(line)
  end
rescue StandardError => e
  abort("Error occurred when reading \"#{file}\". Exception message: \"#{e.message}\".")
end

# ========== Here we go ===============

# set parameters
training_file = ARGV[0].nil? ? DEFAULT_TRAINING_FILE : ARGV[0]
test_file     = ARGV[1].nil? ? DEFAULT_TEST_FILE : ARGV[1]

# display the parameters
if ARGV.empty?
  puts "No arguments found.\nTo provide arguments, run: ruby main.rb [training_file] [test_file]\n\nRunning with default parameters:"
else
  puts "Arguments found. Running with parameters:"
end

print " - Training file: \"./#{training_file}\""
print "  # default" if training_file == DEFAULT_TRAINING_FILE
print "\n"
print " - Test file: \"./#{test_file}\""
print "  # default" if test_file == DEFAULT_TEST_FILE
print "\n\n"
print "===============================================\n\n"

# read in the training set, and construct the classifier
classifier = NaiveBayesianClassifier.new(read_file(training_file))

# run the magic
classifier.classify!(read_file(test_file))

# get the results
results = classifier.results

# output the results to console and sample_output_txt
output = "Results of classification:\n"

results.each_with_index do |result, index|
  output << "No.#{format("%02d", index + 1)}: Spam: #{result[0].to_s.rjust(5)}, Score(Spam): #{format("%1.4e", result[1])}, Score(Normal): #{format("%1.4e", result[2])}\n"
end

puts output
File.write("./sample_output.txt", output)
