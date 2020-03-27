module Enumerable
  def my_each
    self.length.times do |i| 
      if block_given?
        yield(self[i])
      else
        break
      end
    end
  end

  def my_each_with_index(start=0)
    if start == 0
      i = 0
    else
      i = 0 + start
    end
    while i < self.length
      if block_given?
        yield(self[i], i)
      else
        break
      end
      i += 1
    end
  end

  def my_select
    array = []
    self.length.times do |i| 
      if block_given?
        if yield(self[i])
          array.push(self[i])
        end
      else
        return nil
      end
    end
    array
  end

  def my_all?(arg = false)
    result = true
    if block_given?
      self.length.times do |i|
        if !yield(self[i])
          result = false
        end
      end
    elsif arg.is_a?(Regexp)
      self.length.times do |i|
        if !self[i].match arg
          result = false
        end
      end
    elsif arg == Numeric || arg == String
      self.length.times do |i|
        if !self[i].is_a?(arg)
          result = false
        end
      end
    elsif arg.is_a?(Numeric) || arg.is_a?(String)
      self.length.times do |i|
        if self[i] != arg
          result = false
        end
      end
    elsif arg == false
      self.length.times do |i|
        if !self[i]
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

  def my_count(arg=false)
    counter = 0
    if arg == false
      self.my_each do |i|
        counter += 1
      end
    elsif arg == true
      self.my_each {|i| counter += 1 if self[i] == arg}
    elsif block_given?
      if yield(self[i])
        counter += 1
      end
    end
    counter
  end


end