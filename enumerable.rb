module Enumerable
  def my_each
    obj = self
    obj.length.times do |i|
      yield(obj[i]) if block_given?
      break unless block_given?
    end
  end

  def my_each_with_index(start = 0)
    obj = self
    i = start
    i = 0 if start.zero?
    while i < obj.length
      yield(obj[i], i) if block_given?
      break unless block_given?

      i += 1
    end
  end

  def my_select
    obj = self
    array = []
    obj.length.times do |i|
      array.push(obj[i]) if block_given? && yield(obj[i])
      return nil unless block_given?
    end
    array
  end

  def my_all?(arg = false)
    obj = self
    result = true
    if block_given?
      obj.length.times do |i|
        if !yield(obj[i])
          result = false
        end
      end
    elsif arg.is_a?(Regexp)
      obj.length.times do |i|
        if !obj[i].match arg
          result = false
        end
      end
    elsif arg == Numeric || arg == String
      obj.length.times do |i|
        if !obj[i].is_a?(arg)
          result = false
        end
      end
    elsif arg.is_a?(Numeric) || arg.is_a?(String)
      obj.length.times do |i|
        if obj[i] != arg
          result = false
        end
      end
    elsif arg == false
      obj.length.times do |i|
        if !obj[i]
          result = false
        end
      end
    end
    result
  end

  def my_any?
    result = false
    self.my_each do |i|
      if yield(self[i])
        result = true
      end
      break if result == true
    end
    result
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
    array = []
    if proc.nil? && obj.is_a?(Array)
      obj.length.times { |i| array.push(yield(obj[i])) }
    elsif proc.nil? && obj.is_a?(Range)
      obj = obj.to_a
      obj.length.times { |i| array.push(yield(obj[i])) }
    elsif !proc.nil?
      obj.length.times { |i| array.push(proc.call(obj[i])) }
    end
    array
  end

  def my_inject(initial = 0, task = nil)
    obj = self
    initial, task = task, initial unless initial.is_a?(Numeric) || task.is_a?(Symbol)
    result = initial
    if block_given?
      obj = obj.to_a unless obj.is_a?(Array)
      obj.length.times { |i| result = yield(result, obj[i]) }
    else 
      # obj.length.times { |i| initial task obj[i] }
    end
    result
  end
end
