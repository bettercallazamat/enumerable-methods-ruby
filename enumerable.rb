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

  def my_each_with_index
    self.length.times do |i|
      if block_given?
        yield(self[i], i)
      else
        break
      end
    end
  end

end