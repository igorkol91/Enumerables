module Enumerable
  ## method to check incoming data type
  def check_data_type(data_type)
    arr = data_type if data_type.instance_of?(Array)
    arr = to_a if data_type.instance_of?(Range)
    arr = data_type if data_type.instance_of?(Hash)
    arr
  end

  ## my_each method
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = check_data_type(self)
    for i in arr
      yield(i)
    end
    arr
  end

  ## my_each_index method
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    arr = check_data_type(self)
    i = 0
    until i >= arr.length
      yield(arr[i], i)
      i += 1
    end
    arr
  end

  ## my_select method
  def my_select
    return to_enum(:my_select) unless block_given?

    arr = []
    my_each { |i| arr << i if yield(i) }
    arr
  end

  ## my_any method
  def my_any?
    unless block_given?
      for i in self
        return true if i == true
      end
      for i in self
        return false if i == false
      end
      return to_enum(:my_any?)
    end
    bul = false
    arr = self
    arr.my_each { |x| bul = true if yield(x) }
    bul
  end

  ## my_all method
  def my_all?
    unless block_given?
      for i in self
        return false if i == false || i.nil?
      end
      for i in self
        return true if i == true
      end
      return to_enum(:my_all?)
    end
    bul = false
    arr = self
    arr.my_each { |x| bul = true if yield(x) }
    bul
  end

  ## my_none method
  def my_none?
    unless block_given?
      for i in self
        return false if i == true
      end
      for i in self
        return true if i == false
      end
      return to_enum(:my_none?)
    end
    bul = true
    arr = self
    arr.my_each { |x| bul = false if yield(x) }
    bul
  end

  ## my_count method
  def my_count(args = nil)
    counter = 0
    unless args.nil?
      for i in self
        counter += 1 if i == args
       end
      return counter
    end
    counter
  end

  ## my_map method
  def my_map(&factor)
    return to_enum(:my_map) unless block_given?

    arr = self
    new_arr = []
    if factor.nil?
      arr.my_each { |x| new_arr << x if factor.call(x) }
      arr
    else
      arr.my_each { |x| new_arr << x if yield(x) }
      new_arr
    end
  end

  def my_inject(*args)
    return min.length if args.length.zero? and self[0].is_a? String

    if args.length == 1
      if args.first.is_a?(Symbol)
        sum = args.first
      else
        result = args.first
      end
    end
    result = args.first, sum = args.last if args.length == 2
    result ||= 0

    my_each { |x| result = block_given? ? yield(result, x) : result.send(sum, x) }
    result
  end
end

## multiply_els method
def multiply_els(arr)
  arr.my_inject(1) { |multiply, num| multiply * num }
end

## my_each method
# puts '---- my_each ----'
# puts([2, 5, 6, 7].my_each { |x| x })
# puts([2, 5, 6, 7, nil].my_each { |x| x })
# puts([2, 5, 6, 7, nil, 'hello'].my_each { |x| x })
# puts((0..10).my_each { |x| x })
# { 'name' => 'John', 'age' => 21, 'adress' => 'USA' }.my_each { |x| p x }

## my_each_index
# puts '---- my_each_index ----'
# puts([2, 5, 6, 7].my_each_with_index { |x, i| puts "#{i} : #{x}" })

## my_select
# puts '---- my_select ----'
# puts([2, 5, 6, 7].my_select { |n| n })

# puts '---- my_any ----'
# puts([4, 5, 6].my_any? { |n| true if n >8 })

## my_all
# puts '---- my_all ----'
# puts [false,2].my_all?

## my_none
# puts '---- my_none ----'
# puts([4,5,6].my_none? { |n| true if n > 8 })

## my_count method
# puts '---- my_count ----'
# puts((1..3).my_count(3){|n| n})

## my_map method
# puts '---- my_map ----'
# puts([2, 5, 7, 4, 2].my_map { |x| x<3 })

# my_inject method
puts '---- my_inject ----'
puts([5, 6, 7, 8, 9, 10].my_inject(:+))
puts(%w[asd asdaf asdasdas].my_inject)
puts((5..10).my_inject(0) { |product, n| product + n })
puts((5..10).my_inject(1) { |product, n| product * n })
puts '-----multiply------'
puts(multiply_els([2, 4, 5]) { |product, n| product * n })
