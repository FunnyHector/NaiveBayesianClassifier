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
training_file  = ARGV[0].nil? ? DEFAULT_TRAINING_FILE : ARGV[0]
test_file      = ARGV[1].nil? ? DEFAULT_TEST_FILE : ARGV[1]

output_txt = ""

# display the parameters
if ARGV.empty?
  output_txt << "No arguments found.\nTo provide arguments, run: ruby main.rb [training_file] [test_file]\n\nRunning with default parameters:\n"
else
  output_txt << "Arguments found. Running with parameters:\n"
end

output_txt << " - Training file: \"./#{training_file}\""
output_txt << "  # default" if training_file == DEFAULT_TRAINING_FILE
output_txt << "\n"

output_txt << " - Test image file: \"./#{test_file}\""
output_txt << "  # default" if test_file == DEFAULT_TEST_FILE
output_txt << "\n"

classifier = NaiveBayesianClassifier.new(read_file(training_file))

classifier.test
