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
    return unless block_given?

    arr = check_data_type(self)

    for i in arr
      yield(i)
    end
    arr
  end
  ## my_each_index method
  def my_each_with_index
    return unless block_given?

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
    return unless block_given?

    arr = []
    my_each { |i| arr << i if yield(i) }
    arr
  end

  ## my_any method
  def my_any?
     unless block_given? 
      for i in self 
        if i == true
        return true
        end
        end
    for i in self 
       return false if i == false
    end
     return to_enum(:my_any?)
      end 
    bul = false
    arr = self
    arr.my_each { |i| bul = true if yield(i) }
    bul
  end

  ## my_all method
   def my_all?
    unless block_given? 
      for i in self 
        if i == false or i == nil
        return false 
        end
        end
    for i in self 
       return true if i == true 
    end
    return to_enum(:my_all?) 
      end 
    
bul = false
    arr = self
    arr.my_each { |i| bul = true if yield(i) }
    bul
  end


  ## my_none method
  def my_none
    !my_any?
  end

  ## my_count method
  def my_count
    return unless block_given?

    arr = self
    counter = 0
    arr.my_each { |i| counter += 1 if yield(i) }
    counter
  end

  ## my_map method
  def my_map(&factor)
    return unless block_given?

    arr = self
    new_arr = []
    arr.my_each { |x| new_arr << factor.call(x) }
    new_arr
  end

  ## my_inject method
  def my_inject(&factor)
    return unless block_given?

    arr = self
    arr.my_each { |x| factor.call(x) }
  end

  ## multiply_els method
  def multiply_els
    return unless block_given?

    arr = self
    result = 1
    arr.my_inject { |i| result = yield(result, i) }
    result
  end
end

## my_each method
puts '---- my_each ----'
puts([2, 5, 6, 7].my_each { |x| x })
puts([2, 5, 6, 7, nil].my_each { |x| x })
puts([2, 5, 6, 7, nil, 'hello'].my_each { |x| x })
puts((0..10).my_each { |x| x })
{ 'name' => 'John', 'age' => 21, 'adress' => 'USA' }.my_each { |x| p x }

## my_each_index
puts '---- my_each_index ----'
puts([2, 5, 6, 7].my_each_with_index { |x, i| puts "#{i} : #{x}" })

## my_select
puts '---- my_select ----'
puts([2, 5, 6, 7].my_select { |n| n })

## my_any
puts '---- my_any ----'
puts(['into', '5', '6'].my_any? { |n| true if /n/ =~ n })

## my_all
puts '---- my_all ----'
puts [false,2].my_all? 

## my_none
puts '---- my_none ----'
puts([4, 5, 6].my_none { |n| n > 5 })

## my_count method
puts '---- my_count ----'
puts([2, 5, 6, 7].my_count { |x| x })

## my_map method
puts '---- my_map ----'
puts([2, 5, 7, 4, 2].my_map { |i| i + 8 })

## my_inject method
puts '---- my_count ----'
puts([2, 5, 6, 7].my_count { |x| x })

## my_inject and multiply_els
puts '---- multiply_els ----'
puts([2, 4, 5].multiply_els { |x, y| x * y })

#return to_enum(:my_select) unless block_given?