class Instance
  # The initialiser will define 13 instance variables (@attr_0 .. @attr_12, and @spam), and 13 method (#attr_1? .. #attr_11, and #spam?)
  def initialize(data_string)
    values = data_string.split.map { |value| value == "1" }

    values[0..-1].each_with_index do |value, index|
      instance_variable_set("@attr_#{index}", value)
    end

    instance_variable_set("@spam", values[-1])

    instance_variables.each do |variable|
      method_name = variable.to_s[1..-1] + ("?")
      define_singleton_method(method_name) { instance_variable_get(variable) }
    end
  end
end
