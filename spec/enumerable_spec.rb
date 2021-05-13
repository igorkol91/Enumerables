# spec/enumerable_spec.rb

require_relative '../enumerable'

describe Enumerable do
  let(:int_array) { [1, 2, 3, 4] }
  let(:str_array) { %w[igor cat fancy] }
  let(:mix_array) { [nil, true, 1] }
  let(:empty_array) { [] }
  # my_each#
  describe '#my_each' do
    it 'checks my_each and iterates through every element' do
      expect(int_array.my_each { |x| x * 4 }).to eql([1, 2, 3, 4])
      expect(str_array.my_each do |x|
               "#{x}_extra_string"
             end).to eql(%w[igor cat fancy])
    end
    it 'returns an enumerator if no block given' do
      expect(int_array.my_each).to be_a(Enumerator)
    end
  end

  # my_each_with_index#
  describe '#my_each_with_index' do
    it 'checks my_each_with_index and returns same array with indexes' do
      expect(int_array.my_each_with_index { |item, index| item if index.even? }).to eql([1, 2, 3, 4])
      expect(str_array.my_each_with_index do |item, _index|
               "#{item}_extra_string"
             end).to eql(%w[igor cat fancy])
    end
    it 'returns enumerator if no block given' do
      expect(int_array.my_each_with_index).to be_a(Enumerator)
    end
  end

  # my_select#
  describe '#my_select' do
    it 'checks my_select and returns new array with items that match the requirements' do
      expect(int_array.my_select(&:even?)).to eql([2, 4])
      expect(str_array.my_select { |item| item.length > 1 }).to eql(%w[igor cat fancy])
      expect(mix_array.my_select { |item| !item.nil? }).to eql([true, 1])
    end
    it 'returns enumerator if no block given' do
      expect(int_array.my_select).to be_a(Enumerator)
    end
  end

  # my_any?#
  describe '#my_any?' do
    it 'checks my_any? and returns true if any element matches the requirement in int array' do
      expect(int_array.my_any?).to eql(true)
      expect(int_array.my_any?(1)).to eql(true)
      expect(int_array.my_any? { |x| x > 1 }).to eql(true)
      expect(int_array.my_any?(10)).to eql(false)
      expect(int_array.my_any? { |x| x > 4 }).to eql(false)
      expect(int_array.my_any? { |x| x > 10 }).not_to be true
      expect(int_array.my_any?(30)).not_to be true
    end
    it 'checks my_any? and returns true if any element matches the requirement in string array' do
      expect(str_array.my_any?).to eql(true)
      expect(str_array.my_any?('igor')).to eql(true)
      expect(str_array.my_any? { |x| x.length > 1 }).to eql(true)
      expect(str_array.my_any?('fat')).to eql(false)
      expect(str_array.my_any?(/d/)).not_to be true
      expect(str_array.my_any? { |x| x.length > 8 }).not_to be true
    end
    it 'checks my_any? and returns true if any element matches the requirement in mix array' do
      expect(mix_array.my_any?).to eql(true)
      expect(mix_array.my_any?(Integer)).to eql(true)
      expect(mix_array.my_any?('Integer')).not_to be true
    end
    it 'checks empty array' do
      expect(empty_array.my_any?).to eql(false)
    end
  end
  # my_all#
  describe '#my_all?' do
    it 'checks my_all? and returns true if all elements matches the requirement in int array' do
      expect(int_array.my_all?).to eql(true)
      expect(int_array.my_all?(1)).to eql(false)
      expect(int_array.my_all? { |x| x >= 1 }).to eql(true)
      expect(int_array.my_all?(10)).not_to be true
      expect(int_array.my_all? { |x| x > 4 }).not_to be true
    end
    it 'checks my_all? and returns true if all elements matches the requirement in string array' do
      expect(str_array.my_all?).to eql(true)
      expect(str_array.my_all?('igor')).to eql(false)
      expect(str_array.my_all? { |x| x.length > 1 }).to eql(true)
      expect(str_array.my_all?('cold')).to eql(false)
      expect(str_array.my_all? { |x| x.length > 2 }).to eql(true)
      expect(str_array.my_all?(/d/)).not_to be true
      expect(str_array.my_all? { |x| x.length > 6 }).not_to be true
    end
    it 'checks my_all? and returns true if all elements matches the requirement in mix array' do
      expect(mix_array.my_all?).not_to be true
      expect(mix_array.my_all?(Integer)).not_to be true
      expect(mix_array.my_all?('Integer')).not_to be true
    end
    it 'checks empty array' do
      expect(empty_array.my_all?).to eql(true)
    end
  end

  # my_none#
  describe '#my_none?' do
    it 'checks my_none? and returns true if no element matches the requirement in int array' do
      expect(int_array.my_none?(10)).to eql(true)
      expect(int_array.my_none? { |x| x > 4 }).to eql(true)
      expect(int_array.my_none?).not_to be true
      expect(int_array.my_none?(1)).not_to be true
      expect(int_array.my_none? { |x| x > 1 }).not_to be true
    end
    it 'checks my_none? and returns true if no element matches the requirement in string array' do
      expect(str_array.my_none?('cold')).to eql(true)
      expect(str_array.my_none?(/d/)).to eql(true)
      expect(str_array.my_none? { |x| x.length > 8 }).to eql(true)
      expect(str_array.my_none?).not_to be true
      expect(str_array.my_none?('igor')).not_to be true
      expect(str_array.my_none? { |x| x.length > 1 }).not_to be true
    end
    it 'checks my_none? and returns true if no element matches the requirement in mixed array' do
      expect(mix_array.my_none?('Integer')).to eql(true)
      expect(mix_array.my_none?).not_to be true
      expect(mix_array.my_none?(Integer)).not_to be true
    end
    it 'checks empty array' do
      expect(empty_array.my_none?).to eql(true)
    end
  end
  # my_count#
  describe '#my_count' do
    it 'returns the number of elements in array or counts elements of specific value' do
      expect(int_array.my_count).to eql(4)
      expect(int_array.my_count { |item| item > 1 }).to eql(3)
      expect(str_array.my_count { |item| item == 'igor' }).to eql(1)
    end
  end

  # my_map#
  describe '#my_map' do
    it 'returns an enumerator if no block given' do
      expect(int_array.my_map).to be_a(Enumerator)
    end
    it 'returns new array after calling the block for each element' do
      expect(int_array.my_map { |item| item**2 }).to eql([1, 4, 9, 16])
    end
  end

  # my_injext#
  describe '#my_inject' do
    it 'raises LocalJumpError if no block or proc given or works with block or with 2 arguments' do
      expect { int_array.my_inject }.to raise_error(LocalJumpError)
      expect(int_array.my_inject { |acc, x| acc + x * 2 }).to eql(19)
      expect(int_array.my_inject(10) { |acc, x| acc + x * 2 }).to eql(30)
      expect(int_array.my_inject(:+)).to eql(10)
      expect(int_array.my_inject(20, :+)).to eql(30)
    end
  end

  # multiply_els#
  describe '#multiply_els' do
    it 'multiplies all values of the argument, and returns result' do
      expect(multiply_els([2, 4, 5])).to eql(40)
    end
  end
end
