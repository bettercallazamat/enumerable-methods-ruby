# spec :enumerable_spec.rb
require './enumerable.rb'

RSpec.describe Enumerable do
  array = [11, 2, 3, 56]

  describe '.my_each' do
    context 'when receive a block' do
      it 'push each value to the result array' do
        result = []
        array.my_each { |x| result.push(x) }
        expect(result).to(eq(array))
      end
    end

    context 'when no block is given' do
      it 'returns an enumerator' do
        expect(array.my_each).to be_an Enumerator
      end
    end
  end

  describe '.my_each_with_index' do
    context 'when receive a block' do
      it 'push each value to the result array with index' do
        result = []
        array.my_each_with_index { |x, y| result.push([x, y]) }
        expect(result[0][1]).to(eq(0))
      end
    end

    context 'when no block is given' do
      it 'returns an enumerator' do
        expect(array.my_each_with_index).to be_an Enumerator
      end
    end
  end

  describe '.my_select' do
    context 'when receive a block' do
      it 'returns selected values' do
        result = array.my_select { |x| x > 5 }
        expect(result).to eq([11, 56])
      end
    end

    context 'when no block is given' do
      it 'returns an enumerator' do
        result = array.my_select
        expect(result).to be_an Enumerator
      end
    end
  end

  describe '.my_all?' do
    context 'when receive a block' do
      it 'returns true if all values follow the logic in block' do
        expect(array.my_all? { |x| x > 0 }).to eq true
      end

      it 'returns false if one or more values do not follow the logic in block' do
        expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eq false
      end
    end

    context 'when no block is given' do
      it 'returns true if all values are truthy' do
        expect(array.my_all?).to eq true
      end

      it 'returns false if one or more values are falsy' do
        expect([nil, true, 99].my_all?).to eq false
      end
    end
  end

  describe '.my_any?' do
    context 'when receive a block' do
      it 'returns true if one or more values follow the logic in block' do
        expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eq true
      end

      it 'returns false if one or more values do not follow the logic in block' do
        expect(%w[ant bear cat].my_any?(/d/)).to eq false
      end
    end

    context 'when no block is given' do
      it 'returns true if one or more values are truthy' do
        expect([nil, true, 99].my_any?).to eq true
      end

      it 'returns false if one or more values are falsy' do
        expect([].my_any?).to eq false
      end
    end
  end

  describe '.my_none?' do
    context 'when receive a block' do
      it 'returns true if none of the values follow the logic in block' do
        expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eq true
      end

      it 'returns false if one or more values follow the logic in block' do
        expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to eq false
      end
    end

    context 'when no block is given' do
      it 'returns true if none of the values are truthy' do
        expect([nil, false].my_none?).to eq true
      end

      it 'returns false if one or more values are truthy' do
        expect([nil, false, true].my_none?).to eq false
      end
    end
  end

  describe '.my_count' do
    context 'when receive an argument' do
      it 'returns number of values that equals to the argument condition' do
        expect(array.my_count(&:even?)).to eq 2
      end
    end

    context 'when no argument is given' do
      it 'returns number of values' do
        expect(array.my_count).to eq 4
      end
    end
  end

  describe '.my_map' do
    context 'when receive a block' do
      it 'returns a new array with the results of running block once for every element in enumerator' do
        expect(array.my_map { |x| x * x }).to eq [121, 4, 9, 3136]
      end
    end

    context 'when no block given' do
      it 'returns an enumerator' do
        expect(array.my_map).to be_a Enumerator
      end
    end
  end

  describe '.my_map' do
    context 'when receive a block' do
      it 'returns a new array with the results of running block once for every element in enumerator' do
        expect(array.my_map { |x| x * x }).to eq [121, 4, 9, 3136]
      end
    end

    context 'when no block given' do
      it 'returns an enumerator' do
        expect(array.my_map).to be_a Enumerator
      end
    end
  end

  describe '.my_inject' do
    context 'when receive a block' do
      it 'combines all elements of enum by applying a binary operation, specified by a block' do
        expect(array.my_inject { |sum, n| sum + n }).to eq 72
      end
    end

    context 'when receive a symbol' do
      it 'combines all elements of enum by applying a binary operation, specified by a symbol' do
        expect(array.my_inject(1, :*)).to eq 3_696
      end
    end
  end

  describe '.multiply_els' do
    context 'when receive a array' do
      it 'multiplies all values' do
        expect(multiply_els(array)).to eq 3_696
      end
    end
  end
end
