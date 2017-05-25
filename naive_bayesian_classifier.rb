class NaiveBayesianClassifier
  def initialize(instances)
    @table = {
      normal: {
        count:   1,
        attr_0:  { true => 1, false => 1 },
        attr_1:  { true => 1, false => 1 },
        attr_2:  { true => 1, false => 1 },
        attr_3:  { true => 1, false => 1 },
        attr_4:  { true => 1, false => 1 },
        attr_5:  { true => 1, false => 1 },
        attr_6:  { true => 1, false => 1 },
        attr_7:  { true => 1, false => 1 },
        attr_8:  { true => 1, false => 1 },
        attr_9:  { true => 1, false => 1 },
        attr_10: { true => 1, false => 1 },
        attr_11: { true => 1, false => 1 }
      },
      spam:   {
        count:   1,
        attr_0:  { true => 1, false => 1 },
        attr_1:  { true => 1, false => 1 },
        attr_2:  { true => 1, false => 1 },
        attr_3:  { true => 1, false => 1 },
        attr_4:  { true => 1, false => 1 },
        attr_5:  { true => 1, false => 1 },
        attr_6:  { true => 1, false => 1 },
        attr_7:  { true => 1, false => 1 },
        attr_8:  { true => 1, false => 1 },
        attr_9:  { true => 1, false => 1 },
        attr_10: { true => 1, false => 1 },
        attr_11: { true => 1, false => 1 }
      }
    }

    @instances = instances

    preprocess
  end

  def classify!(test_instances)
    test_instances.each { |instance| classify_instance!(instance) }
  end

  def test
    puts @instances.size
    puts @table
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

    # TODO:

    p_spam = 0


    p_normal = 0


  end

  ######################################################################
  result = {
    :spam   => {
      :count   => 52,
      :attr_0  => { true => 35, false => 18 },
      :attr_1  => { true => 31, false => 22 },
      :attr_2  => { true => 24, false => 29 },
      :attr_3  => { true => 32, false => 21 },
      :attr_4  => { true => 26, false => 27 },
      :attr_5  => { true => 19, false => 34 },
      :attr_6  => { true => 41, false => 12 },
      :attr_7  => { true => 40, false => 13 },
      :attr_8  => { true => 18, false => 35 },
      :attr_9  => { true => 35, false => 18 },
      :attr_10 => { true => 35, false => 18 },
      :attr_11 => { true => 41, false => 12 }
    },
    :normal => {
      :count   => 150,
      :attr_0  => { true => 54, false => 97 },
      :attr_1  => { true => 87, false => 64 },
      :attr_2  => { true => 52, false => 99 },
      :attr_3  => { true => 60, false => 91 },
      :attr_4  => { true => 51, false => 100 },
      :attr_5  => { true => 71, false => 80 },
      :attr_6  => { true => 76, false => 75 },
      :attr_7  => { true => 53, false => 98 },
      :attr_8  => { true => 37, false => 114 },
      :attr_9  => { true => 44, false => 107 },
      :attr_10 => { true => 88, false => 63 },
      :attr_11 => { true => 51, false => 100 }
    }
  }

end
