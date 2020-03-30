# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/ModuleLength

module Enumerable
  def my_each
    obj = self
    obj.length.times { |i| yield(obj[i]) if block_given? }
    to_enum unless block_given?
  end

  def my_each_with_index(start = 0)
    obj = self
    i = start
    i = 0 if start.zero?
    while i < obj.length
      yield(obj[i], i) if block_given?

      i += 1
    end
    to_enum unless block_given?
  end

  def my_select
    obj = self
    array = []
    obj.length.times { |i| array.push(obj[i]) if block_given? && yield(obj[i]) }
    return to_enum unless block_given?

    array
  end

  def my_all?(arg = nil)
    obj = self
    if block_given?
      obj.length.times { |i| return false unless yield(obj[i]) }
    elsif arg.is_a?(Regexp)
      obj.length.times { |i| return false unless obj[i].match arg }
    elsif arg.is_a?(Class)
      obj.length.times { |i| return false unless obj[i].is_a?(arg) }
    elsif arg.is_a?(Numeric) || arg.is_a?(String)
      obj.length.times { |i| return false if obj[i] != arg }
    else
      obj.length.times { |i| return false unless obj[i] }
    end
    true
  end

  def my_any?(arg = nil)
    obj = self
    if block_given?
      obj.length.times { |i| return true if yield(obj[i]) }
    elsif arg.is_a?(Regexp)
      obj.length.times { |i| return true if obj[i].match arg }
    elsif arg.is_a?(Class)
      obj.length.times { |i| return true if obj[i].is_a?(arg) }
    elsif arg.is_a?(Numeric) || arg.is_a?(String)
      obj.length.times { |i| return true if obj[i] == arg }
    else
      obj.length.times { |i| return true if obj[i] }
    end
    false
  end

  def my_none?(arg = nil)
    obj = self
    if block_given?
      obj.length.times { |i| return false if yield(obj[i]) }
    elsif arg.is_a?(Regexp)
      obj.length.times { |i| return false if obj[i].match arg }
    elsif arg.is_a?(Class)
      obj.length.times { |i| return false if obj[i].is_a?(arg) }
    elsif arg.is_a?(Numeric) || arg.is_a?(String)
      obj.length.times { |i| return false if obj[i] == arg }
    else
      obj.length.times { |i| return false if obj[i] }
    end
    true
  end

  def my_count(arg = nil)
    obj = self
    counter = 0
    if block_given?
      obj.length.times { |i| counter += 1 if yield(obj[i]) }
    elsif arg.nil?
      counter = obj.length
    elsif !arg.nil?
      obj.length.times { |i| counter += 1 if obj[i] == arg }
    end
    counter
  end

  def my_map(proc = nil)
    obj = self
    obj = obj.to_a unless obj.is_a?(Array)
    array = []
    if proc.nil? && block_given?
      obj.length.times { |i| array.push(yield(obj[i])) }
    elsif !proc.nil? || (!proc.nil? && block_given)
      obj.length.times { |i| array.push(proc.call(obj[i])) }
    else
      return to_enum
    end
    array
  end

  def my_inject(arg1 = nil, arg2 = nil)
    obj = self
    obj = obj.to_a unless obj.is_a?(Array)
    result = 0
    result = arg1 if arg1.is_a?(Numeric)
    result = '' if obj[0].is_a?(String)
    if block_given?
      obj.length.times { |i| result = yield(result, obj[i]) }
    elsif arg1.is_a?(Symbol)
      obj.length.times { |i| result = result.send(arg1, obj[i]) }
    else
      obj.length.times { |i| result = result.send(arg2, obj[i]) }
    end
    result
  end

  def multiply_els(array)
    array.my_inject { |a, b| a * b }
  end
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength
