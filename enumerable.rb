module Enumerable
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  # rubocop:disable Lint/ToEnumArguments
  ## method to check incoming data type
  def check_data_type(data_type)
    arr = data_type if data_type.instance_of?(Array)
    arr = to_a if data_type.instance_of?(Range)
    arr = to_a if data_type.instance_of?(Hash)
    arr
  end

  ## my_each method
  def my_each
    return to_enum(:my_each) unless block_given?

    for i in check_data_type(self)
      yield(i)
    end
    self
  end

  ## my_each_index method
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    until i >= check_data_type(self).length
      yield(check_data_type(self)[i], i)
      i += 1
    end
    self
  end

  ## my_select method
  def my_select
    return to_enum(:my_select) unless block_given?

    arr = []
    my_each { |i| arr << i if yield(i) }
    arr
  end

  ## my_any method
  def my_any?(arg = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
      false
    elsif arg.nil?
      my_each { |i| return true if i }
    elsif !arg.nil? && (arg.instance_of? Class)
      my_each { |i| return true if [i.class, i.class.superclass].include?(arg) }
    elsif !arg.nil? && arg.instance_of?(Regexp)
      my_each { |i| return true if arg.match(i) }
    else
      my_each { |i| return true if i == arg }
    end
    false
  end

  ## my_all method
  def my_all?(arg = nil)
    if block_given?
      my_each { |i| return false if yield(i) == false }
      true
    elsif arg.nil?
      my_each { |i| return false if i.nil? || i == false }
    elsif !arg.nil? && (arg.instance_of? Class)
      my_each { |i| return false unless [i.class, i.class.superclass].include?(arg) }
    elsif !arg.nil? && arg.instance_of?(Regexp)
      my_each { |i| return false unless arg.match(i) }
    else
      my_each { |i| return false if i != arg }
    end
    true
  end

  ## my_none method
  def my_none?(arg = nil)
    if block_given?
      !my_any?(&Proc.new)
    else
      !my_any?(arg)
    end
    true
  end

  ## my_count method
  def my_count(arg = nil)
    counter = 0
    unless block_given?
      if arg
        self.my_each {|i| counter += 1 if counter == arg}
      else
        self.my_each {|i| counter += 1}
        return counter
      end
    else
      self.my_each {|i| counter += 1 if yield(i)}
    end
    return counter
  end

  ## my_map method
  def my_map(factor = nil)
    return to_enum(:my_map) unless block_given? || !factor.nil?

    new_arr = []
    if factor.nil?
      my_each { |i| new_arr << yield(i) }
    else
      my_each { |i| new_arr << factor.call(i) }
    end
    new_arr
  end

  def my_inject(value_one = nil, value_two = nil)
    if (!value_one.nil? && value_two.nil?) && (value_one.is_a?(Symbol) || value_one.is_a?(String))
      value_two = value_one
      value_one = nil
    end
    if !block_given? && !value_two.nil?
      my_each { |i| value_one = value_one.nil? ? i : value_one.send(value_two, i) }
    else
      my_each { |i| value_one = value_one.nil? ? i : yield(value_one, i) }
    end
    value_one
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Lint/ToEnumArguments
end

## multiply_els method
def multiply_els(arr)
  arr.my_inject(1, '*')
end

# # my_each_index
puts '---- my_each_index ----'
# [2, 5, 6, 7].my_each_with_index { |x, i| puts "#{i} : #{x}" }
# %w[Victor Igor Microverse Program].my_each_with_index { |x, i| puts x if (i % 2).zero?} 
{'name'=>'vikita', 'age'=>12, 'address'=>'nairobi'}.my_each_with_index { |x, i| puts "#{i} : #{x}" } 

# my_none
# puts '---- my_none ----'
# string_arr = ['world', 'hello', 'help']
# puts string_arr.my_none? { |word| word.length == 3 }
# puts string_arr.my_none? { |word| word.length >= 4 }
# puts string_arr.my_none?(/o/)
# puts [1, 's', 3.14].my_none?(Integer)
# puts [1, 'the', 3.14].my_none?(Numeric)
# puts [].my_none?
# puts [0, false].my_none?

# # my_count method
# puts '---- my_count ----'
# puts((1..3).my_count(1))
# puts([1,2,3,4].my_count(1))


# #my_inject method
# puts '---- my_inject ----'
# puts([5, 6, 7, 8, 9, 10].my_inject(:+))
# puts(%w[asd asdaf asdasdas].my_inject)
# puts((5..10).my_inject(0) { |product, n| product + n })
# puts((5..10).my_inject(1) { |product, n| product * n })

# # multiply method
# puts '-----multiply------'
# puts(multiply_els([2, 4, 5]))
