class Instance
  # The initialiser will define 13 instance variables (@attr_0 .. @attr_11, and @spam), and 13 method (#attr_1? .. #attr_11, and #spam?)
  def initialize(data_string)
    values = data_string.split.map { |value| value == "1" }

    instance_variable_set("@spam", values[12])

    values[0..11].each_with_index { |value, index| instance_variable_set("@attr_#{index}", value) }

    instance_variables.each do |variable|
      define_singleton_method(variable.to_s[1..-1]) { instance_variable_get(variable) }
    end

    define_singleton_method("spam=") { |label| instance_variable_set("@spam", label) }
  end
end
