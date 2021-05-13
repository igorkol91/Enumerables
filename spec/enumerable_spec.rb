# spec/enumerable_spec.rb

require_relative '../enumerable'

describe Enumerable do
  let(:int_array) { [1, 2, 3, 4] }
  let(:str_array) { %w[igor cat fancy] }
  let(:mix_array) { [nil, true, 1] }
  let(:empty_array) { [] }
  # my_each#
  describe '#my_each' do
    it 'checks my_each' do
      expect(int_array.my_each { |x| x * 4 }).to eql([1, 2, 3, 4])
      expect(str_array.my_each do |x|
               "#{x}_extra_string"
             end).to eql(%w[igor cat fancy])
    end
  end

  # my_each_with_index#
  describe '#my_each_with_index' do
    it 'checks my_each_with_index' do
      expect(int_array.my_each_with_index { |item, index| item if index.even? }).to eql([1, 2, 3, 4])
      expect(str_array.my_each_with_index do |item, _index|
               "#{item}_extra_string"
             end).to eql(%w[igor cat fancy])
    end
  end

  # my_select#
  describe '#my_select' do
    it 'checks my_select' do
      expect(int_array.my_select(&:even?)).to eql([2, 4])
      expect(str_array.my_select { |item| item.length > 1 }).to eql(%w[igor cat fancy])
      expect(mix_array.my_select { |item| !item.nil? }).to eql([true, 1])
    end
  end

  # my_any?#
  describe '#my_any?' do
    it 'checks my_any? for int array' do
      expect(int_array.my_any?).to eql(true)
      expect(int_array.my_any?(1)).to eql(true)
      expect(int_array.my_any? { |x| x > 1 }).to eql(true)
      expect(int_array.my_any?(10)).to eql(false)
      expect(int_array.my_any? { |x| x > 4 }).to eql(false)
    end
    it 'checks my_any? for string array' do
      expect(str_array.my_any?).to eql(true)
      expect(str_array.my_any?('igor')).to eql(true)
      expect(str_array.my_any? { |x| x.length > 1 }).to eql(true)
      expect(str_array.my_any?('fat')).to eql(false)
      expect(str_array.my_any?(/d/)).to eql(false)
      expect(str_array.my_any? { |x| x.length > 8 }).to eql(false)
    end
    it 'checks my_any? for mix array' do
      expect(mix_array.my_any?).to eql(true)
      expect(mix_array.my_any?(Integer)).to eql(true)
      expect(mix_array.my_any?('Integer')).to eql(false)
    end
    it 'checks empty array' do
      expect(empty_array.my_any?).to eql(false)
    end
  end
  # my_all#
  describe '#my_all?' do
    it 'checks my_all? for int array' do
      expect(int_array.my_all?).to eql(true)
      expect(int_array.my_all?(1)).to eql(false)
      expect(int_array.my_all? { |x| x >= 1 }).to eql(true)
      expect(int_array.my_all?(10)).to eql(false)
      expect(int_array.my_all? { |x| x > 4 }).to eql(false)
    end
    it 'checks my_all? for string array' do
      expect(str_array.my_all?).to eql(true)
      expect(str_array.my_all?('igor')).to eql(false)
      expect(str_array.my_all? { |x| x.length > 1 }).to eql(true)
      expect(str_array.my_all?('cold')).to eql(false)
      expect(str_array.my_all?(/d/)).to eql(false)
      expect(str_array.my_all? { |x| x.length > 6 }).to eql(false)
      expect(str_array.my_all? { |x| x.length > 2 }).to eql(true)
    end
    it 'checks my_all? for mix array' do
      expect(mix_array.my_all?).to eql(false)
      expect(mix_array.my_all?(Integer)).to eql(false)
      expect(mix_array.my_all?('Integer')).to eql(false)
    end
    it 'checks empty array' do
      expect(empty_array.my_all?).to eql(true)
    end
  end

  # my_none#
  describe '#my_none?' do
    it 'checks my_none? for int array' do
      expect(int_array.my_none?).to eql(false)
      expect(int_array.my_none?(1)).to eql(false)
      expect(int_array.my_none? { |x| x > 1 }).to eql(false)
      expect(int_array.my_none?(10)).to eql(true)
      expect(int_array.my_none? { |x| x > 4 }).to eql(true)
    end
    it 'checks my_none? for string array' do
      expect(str_array.my_none?).to eql(false)
      expect(str_array.my_none?('igor')).to eql(false)
      expect(str_array.my_none? { |x| x.length > 1 }).to eql(false)
      expect(str_array.my_none?('cold')).to eql(true)
      expect(str_array.my_none?(/d/)).to eql(true)
      expect(str_array.my_none? { |x| x.length > 8 }).to eql(true)
    end
    it 'checks my_none? for mix array' do
      expect(mix_array.my_none?).to eql(false)
      expect(mix_array.my_none?(Integer)).to eql(false)
      expect(mix_array.my_none?('Integer')).to eql(true)
    end
    it 'checks empty array' do
      expect(empty_array.my_none?).to eql(true)
    end
  end
  # my_count#
  describe '#my_count' do
    it 'checks my_count' do
      expect(int_array.my_count).to eql(4)
      expect(int_array.my_count { |item| item > 1 }).to eql(3)
      expect(str_array.my_count { |item| item == 'igor' }).to eql(1)
    end
  end

  # my_map#
  describe '#my_map' do
    it 'checks my_map' do
      expect(int_array.my_map { |item| item**2 }).to eql([1, 4, 9, 16])
    end
  end
end
