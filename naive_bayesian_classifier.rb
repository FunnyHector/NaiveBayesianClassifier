class NaiveBayesianClassifier
  def initialize(instances)
    @instances = instances

    preprocess
  end

  def preprocess
    @table ||= {
      spam:   {
        attr_0:  { true => 0, false => 0 },
        attr_1:  { true => 0, false => 0 },
        attr_2:  { true => 0, false => 0 },
        attr_3:  { true => 0, false => 0 },
        attr_4:  { true => 0, false => 0 },
        attr_5:  { true => 0, false => 0 },
        attr_6:  { true => 0, false => 0 },
        attr_7:  { true => 0, false => 0 },
        attr_8:  { true => 0, false => 0 },
        attr_9:  { true => 0, false => 0 },
        attr_10: { true => 0, false => 0 },
        attr_11: { true => 0, false => 0 },
        count:   0
      },
      normal: {
        attr_0:  { true => 0, false => 0 },
        attr_1:  { true => 0, false => 0 },
        attr_2:  { true => 0, false => 0 },
        attr_3:  { true => 0, false => 0 },
        attr_4:  { true => 0, false => 0 },
        attr_5:  { true => 0, false => 0 },
        attr_6:  { true => 0, false => 0 },
        attr_7:  { true => 0, false => 0 },
        attr_8:  { true => 0, false => 0 },
        attr_9:  { true => 0, false => 0 },
        attr_10: { true => 0, false => 0 },
        attr_11: { true => 0, false => 0 },
        count:   0
      }
    }

    @instances.each do |instance|
      (0..11).each do |index|
        label  = instance.spam? ? :spam : :normal
        key    = "attr_#{index}"
        method = key + "?"

        @table[label][key.to_sym][instance.send(method.to_sym)] += 1
      end
    end
  end

  def test
    puts @instances.size
    puts @table
  end

  # TODO: do I need to initialise 0 probabilities?
  result = {
    :spam   => {
      :attr_0  => { true => 34, false => 17 },
      :attr_1  => { true => 30, false => 21 },
      :attr_2  => { true => 23, false => 28 },
      :attr_3  => { true => 31, false => 20 },
      :attr_4  => { true => 25, false => 26 },
      :attr_5  => { true => 18, false => 33 },
      :attr_6  => { true => 40, false => 11 },
      :attr_7  => { true => 39, false => 12 },
      :attr_8  => { true => 17, false => 34 },
      :attr_9  => { true => 34, false => 17 },
      :attr_10 => { true => 34, false => 17 },
      :attr_11 => { true => 40, false => 11 },
      :count   => 0
    },
    :normal => {
      :attr_0  => { true => 53, false => 96 },
      :attr_1  => { true => 86, false => 63 },
      :attr_2  => { true => 51, false => 98 },
      :attr_3  => { true => 59, false => 90 },
      :attr_4  => { true => 50, false => 99 },
      :attr_5  => { true => 70, false => 79 },
      :attr_6  => { true => 75, false => 74 },
      :attr_7  => { true => 52, false => 97 },
      :attr_8  => { true => 36, false => 113 },
      :attr_9  => { true => 43, false => 106 },
      :attr_10 => { true => 87, false => 62 },
      :attr_11 => { true => 50, false => 99 },
      :count   => 0
    }
  }


end
