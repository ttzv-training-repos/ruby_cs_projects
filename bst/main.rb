require_relative 'tree'
require 'pry'

tree = Tree.new([2,3,1,5,8,3])

#tree = Tree.new([2,4,1])

puts tree.root

tree.level_order {|el| puts el.data}

#binding.pry

