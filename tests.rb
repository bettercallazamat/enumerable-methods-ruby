require './enumerable.rb'
​
test_array1 = [11, 2, 3, 56]
test_array2 = %w[a b c d]
​
# my_each
p 'my_each'
test_array1.my_each { |x| p x }
test_array2.my_each { |x| p x }
p test_array2.my_each
​
# my_each_with_index
p 'my_each-with_index'
test_array1.my_each_with_index { |x, y| p "item: #{x}, index: #{y}" }
test_array2.my_each_with_index(2) { |x, y| p "item: #{x}, index: #{y}" }
p test_array2.my_each_with_index
​
# my_select
p 'my_select'
p test_array1.my_select(&:even?)
p test_array2.my_select { |x| x == 'c' }
p test_array2.my_select
