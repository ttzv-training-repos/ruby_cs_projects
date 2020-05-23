require 'pry'
require_relative 'linkedlist'

list = LinkedList.new

list.append(5)
list.append(4)
list.append(3)
list.append(2)


puts "At: "
p list.at(0)
p list.at(1)
p list.at(2)
p list.at(3)


puts "Length: "
p list.length

puts "String: "
puts list

puts "Tail equals last node:"
puts list.tail.value == list.at(list.length-1)

puts "Pops 2 times"
puts list
list.pop
list.pop
puts list
puts "returns by square bracket: "
puts list[0]

puts "Prepends"
list.prepend(10)
puts list
list.prepend(15)
puts list

puts "Returns true if contains element: "
puts list.contains?(15)
puts "And returns false if element does not exist"
puts list.contains?(-20)

puts "Finds index of element \"10\" and \"4\": "
puts list
puts list.find(10), list.find(4)
puts "Returns nil if value not exist"
p list.find(-21)



puts "Inserts 450 at index 2"
puts list
list.insert_at(450, 2)
puts list

puts "Removes element at index 1"
list.remove_at(1)
puts list


binding.pry