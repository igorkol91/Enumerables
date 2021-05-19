require './enumerable'

describe Enumerable do
  let(:integer_arr) { [3, 4, 7, 9, 10] }
  let(:string_arr) { %w[victor otieno cat] }
  let(:comb_arr) { [10, true, nil] }
  let(:empty_arr) { [] }

  # my_each
  describe '#my_each' do
    it 'iterates through every element' do
      expect(integer_arr.my_each { |x| x * 4 }).to eql([3, 4, 7, 9, 10])
    end

    it 'iterates through every element' do
      expect(string_arr.my_each do |x|
               "#{x}_extra_string"
             end).to eql(%w[victor otieno cat])
    end

    it 'returns an enumerator if no block given' do
      expect(integer_arr.my_each).to be_a(Enumerator)
    end
  end

  # my_each_with_index
  describe '#my_each_with_index' do
    it 'returns same array with indexes' do
      expect(integer_arr.my_each_with_index { |item, index| item if index.even? }).to eql([3, 4, 7, 9, 10])
    end

    it 'returns same array with indexes' do
      expect(string_arr.my_each_with_index do |item, _index|
               "#{item}_extra_string"
             end).to eql(%w[victor otieno cat])
    end

    it 'returns enumerator if no block given' do
      expect(integer_arr.my_each_with_index).to be_a(Enumerator)
    end
  end

  # my_select
  describe '#my_select' do
    it 'returns new array with items that match the requirements' do
      expect(integer_arr.my_select(&:even?)).to eql([4, 10])
    end
    it 'returns new array with items that match the requirements' do
      expect(string_arr.my_select { |item| item.length > 1 }).to eql(%w[victor otieno cat])
    end
    it 'returns new array with items that match the requirements' do
      expect(comb_arr.my_select { |item| !item.nil? }).to eql([10, true])
    end
    it 'returns enumerator if no block given' do
      expect(integer_arr.my_select).to be_a(Enumerator)
    end
  end

  # my_any?
  describe '#my_any?' do
    it 'returns true if any element matches the requirement in integer array' do
      expect(integer_arr.my_any?).to eql(true)
      expect(integer_arr.my_any?(10)).to eql(true)
      expect(integer_arr.my_any? { |x| x > 1 }).to eql(true)
      expect(integer_arr.my_any?(11)).to eql(false)
      expect(integer_arr.my_any? { |x| x > 20 }).to eql(false)
      expect(integer_arr.my_any? { |x| x > 10 }).not_to be true
      expect(integer_arr.my_any?(30)).not_to be true
    end

    it 'returns true if any element matches the requirement in string array' do
      expect(string_arr.my_any?).to eql(true)
      expect(string_arr.my_any?('victor')).to eql(true)
      expect(string_arr.my_any? { |x| x.length > 1 }).to eql(true)
      expect(string_arr.my_any?('fat')).to eql(false)
      expect(string_arr.my_any?(/d/)).not_to be true
      expect(string_arr.my_any? { |x| x.length > 8 }).not_to be true
      expect(comb_arr.my_any?).to eql(true)
      expect(comb_arr.my_any?(Integer)).to eql(true)
      expect(comb_arr.my_any?('Integer')).not_to be true
    end

    it 'checks empty array' do
      expect(empty_arr.my_any?).to eql(false)
    end
  end

  # my_all?
  describe '#my_all?' do
    it 'returns true if all elements matches the requirement in integer array' do
      expect(integer_arr.my_all?).to eql(true)
      expect(integer_arr.my_all?(1)).to eql(false)
      expect(integer_arr.my_all? { |x| x >= 1 }).to eql(true)
      expect(integer_arr.my_all?(10)).not_to be true
      expect(integer_arr.my_all? { |x| x > 4 }).not_to be true
    end

    it 'returns true if all elements matches the requirement in string array' do
      expect(string_arr.my_all?).to eql(true)
      expect(string_arr.my_all?('victor')).to eql(false)
      expect(string_arr.my_all? { |x| x.length > 1 }).to eql(true)
      expect(string_arr.my_all?('cold')).to eql(false)
      expect(string_arr.my_all? { |x| x.length > 2 }).to eql(true)
      expect(string_arr.my_all?(/d/)).not_to be true
      expect(string_arr.my_all? { |x| x.length > 6 }).not_to be true
    end

    it 'returns true if all elements matches the requirement in string array' do
      expect(comb_arr.my_all?).not_to be true
      expect(comb_arr.my_all?(Integer)).not_to be true
      expect(comb_arr.my_all?('Integer')).not_to be true
    end

    it 'checks empty array' do
      expect(empty_arr.my_all?).to eql(true)
    end
  end

  # my_none
  describe '#my_none?' do
    it 'returns true if no element matches the requirement in int array' do
      expect(integer_arr.my_none?(11)).to eql(integer_arr)
      expect(integer_arr.my_none? { |x| x > 5 }).to eql(integer_arr)
      expect(integer_arr.my_none?).not_to be true
      expect(integer_arr.my_none?(1)).not_to be true
      expect(integer_arr.my_none? { |x| x > 1 }).not_to be true
    end
    it 'returns true if no element matches the requirement in string array' do
      expect(string_arr.my_none?('dog')).to eql(string_arr)
      expect(string_arr.my_none?(/d/)).to eql(string_arr)
      expect(string_arr.my_none? { |x| x.length > 8 }).to eql(string_arr)
      expect(string_arr.my_none?).not_to be true
      expect(string_arr.my_none?('victor')).not_to be true
      expect(string_arr.my_none? { |x| x.length > 1 }).not_to be true
    end

    it 'returns true if no element matches the requirement in combined array' do
      expect(comb_arr.my_none?('Integer')).to eql(comb_arr)
      expect(comb_arr.my_none?).not_to be true
      expect(comb_arr.my_none?(Integer)).not_to be true
    end

    it 'checks empty array' do
      expect(empty_arr.my_none?).to eql(empty_arr)
    end
  end

  # my_count
  describe '#my_count' do
    it 'returns the number of elements in array or counts elements of specific value' do
      expect(integer_arr.my_count).to eql(5)
      expect(integer_arr.my_count { |item| item > 1 }).to eql(5)
      expect(string_arr.my_count { |item| item == 'victor' }).to eql(1)
    end
  end

  # my_map
  describe '#my_map' do
    it 'returns an enumerator if no block given' do
      expect(integer_arr.my_map).to be_a(Enumerator)
    end
    it 'returns new array after calling the block for each element' do
      expect(integer_arr.my_map { |item| item**2 }).to eql([9, 16, 49, 81, 100])
    end
  end

  # my_injext
  describe '#my_inject' do
    it 'raises LocalJumpError if no block or proc given or works with block or with 2 arguments' do
      expect { integer_arr.my_inject }.to raise_error(LocalJumpError)
      expect(integer_arr.my_inject { |acc, x| acc + x * 2 }).to eql(63)
      expect(integer_arr.my_inject(10) { |acc, x| acc + x * 2 }).to eql(76)
      expect(integer_arr.my_inject(:+)).to eql(33)
      expect(integer_arr.my_inject(20, :+)).to eql(53)
    end
  end

  # multiply_els
  describe '#multiply_els' do
    it 'multiplies all values of the argument, and returns result' do
      expect(multiply_els([2, 4, 5])).to eql(40)
    end
  end
end
