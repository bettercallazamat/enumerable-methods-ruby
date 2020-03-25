module Enumerable

def my_each
  self.lenght.times do |i|
    yield(self[i])
  end
end

end


test_array1 = [11, 2, 3, 56]
test_array2 = %w[a b c d]
​
# my_each
p 'my_each'
test_array1.my_each { |x| p x }
test_array2.my_each { |x| p x }
p test_array2.my_each
