class NaiveBayesianClassifier
  INITIAL_COUNT = 1

  attr_reader :results

  def initialize(instances)
    @instances = instances
    @results   = []
    @table     = {}

    # initialise the structure of the table, and fill it with INITIAL_COUNT
    ["normal", "spam"].each do |label|
      @table[label] = {}
      @table[label]["count"] = INITIAL_COUNT

      (0..11).each do |index|
        key = "attr_#{index}"
        @table[label][key] = {}

        [true, false].each { |boolean| @table[label][key][boolean] = INITIAL_COUNT }
      end
    end

    preprocess
  end

  def classify!(test_instances)
    test_instances.each { |instance| classify_instance!(instance) }
  end
  
  def probabilities
    {}.tap do |prob_table|
      ["normal", "spam"].each do |label|
        prob_table[label] = {}
        prob_table[label]["class"] = (@table[label]["count"].to_f / (@table["spam"]["count"] + @table["normal"]["count"])).round(4)

        (0..11).each do |index|
          key = "attr_#{index}"
          prob_table[label][key] = {}

          [true, false].each do |boolean|
            prob_table[label][key][boolean] = (@table[label][key][boolean].to_f / (@table[label][key][true] + @table[label][key][false])).round(4)
          end
        end
      end
    end
  end

  private

  def preprocess
    # count the occurrence of each attribute
    @instances.each do |instance|
      label = instance.spam ? "spam" : "normal"

      @table[label]["count"] += 1

      (0..11).each do |index|
        key = "attr_#{index}"

        @table[label][key][instance.send(key)] += 1
      end
    end
  end

  def classify_instance!(instance)
    raise "Already classified!" unless instance.spam.nil?

    total = @table["spam"]["count"] + @table["normal"]["count"]

    p_spam   = @table["spam"]["count"].to_f / total
    p_normal = @table["normal"]["count"].to_f / total

    (0..11).each do |index|
      key = "attr_#{index}"

      denominator_spam   = @table["spam"][key][true] + @table["spam"][key][false]
      denominator_normal = @table["normal"][key][true] + @table["normal"][key][false]

      p_spam   *= @table["spam"][key][instance.send(key)].to_f / denominator_spam
      p_normal *= @table["normal"][key][instance.send(key)].to_f / denominator_normal
    end

    instance.spam = p_spam > p_normal

    @results << [instance.spam, p_spam, p_normal]
  end
end
