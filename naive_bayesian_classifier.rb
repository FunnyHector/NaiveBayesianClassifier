class NaiveBayesianClassifier
  INITIAL_COUNT = 1

  attr_reader :results

  # The constructor will initialise @table as:
  # @table = {
  #   normal: {
  #     count:   1,
  #     attr_0:  { true => 1, false => 1 },
  #     attr_1:  { true => 1, false => 1 },
  #     attr_2:  { true => 1, false => 1 },
  #     attr_3:  { true => 1, false => 1 },
  #     attr_4:  { true => 1, false => 1 },
  #     attr_5:  { true => 1, false => 1 },
  #     attr_6:  { true => 1, false => 1 },
  #     attr_7:  { true => 1, false => 1 },
  #     attr_8:  { true => 1, false => 1 },
  #     attr_9:  { true => 1, false => 1 },
  #     attr_10: { true => 1, false => 1 },
  #     attr_11: { true => 1, false => 1 }
  #   },
  #   spam:   {
  #     count:   1,
  #     attr_0:  { true => 1, false => 1 },
  #     attr_1:  { true => 1, false => 1 },
  #     attr_2:  { true => 1, false => 1 },
  #     attr_3:  { true => 1, false => 1 },
  #     attr_4:  { true => 1, false => 1 },
  #     attr_5:  { true => 1, false => 1 },
  #     attr_6:  { true => 1, false => 1 },
  #     attr_7:  { true => 1, false => 1 },
  #     attr_8:  { true => 1, false => 1 },
  #     attr_9:  { true => 1, false => 1 },
  #     attr_10: { true => 1, false => 1 },
  #     attr_11: { true => 1, false => 1 }
  #   }
  # }
  def initialize(instances)
    @instances = instances
    @results   = []
    @table     = {}

    [:normal, :spam].each do |label|
      @table[label] = {}
      @table[label][:count] = INITIAL_COUNT

      (0..11).each do |index|
        key = "attr_#{index}".to_sym
        @table[label][key] = {}

        [true, false].each { |boolean| @table[label][key][boolean] = INITIAL_COUNT }
      end
    end

    preprocess
  end

  def classify!(test_instances)
    test_instances.each { |instance| classify_instance!(instance) }
  end

  private

  def preprocess
    @instances.each do |instance|
      label = instance.spam ? :spam : :normal

      @table[label][:count] += 1

      (0..11).each do |index|
        key = "attr_#{index}".to_sym

        @table[label][key][instance.send(key)] += 1
      end
    end
  end

  def classify_instance!(instance)
    raise "Already classified!" unless instance.spam.nil?

    total = @table[:spam][:count] + @table[:normal][:count]

    p_spam   = @table[:spam][:count].to_f / total
    p_normal = @table[:normal][:count].to_f / total

    (0..11).each do |index|
      key = "attr_#{index}".to_sym

      denominator_spam   = @table[:spam][key][true] + @table[:spam][key][false]
      denominator_normal = @table[:normal][key][true] + @table[:normal][key][false]

      p_spam   *= @table[:spam][key][instance.send(key)].to_f / denominator_spam
      p_normal *= @table[:normal][key][instance.send(key)].to_f / denominator_normal
    end

    instance.spam = p_spam > p_normal

    @results << [instance.spam, p_spam, p_normal]
  end
end
