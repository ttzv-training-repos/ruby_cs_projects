require_relative 'tree'
require 'pry'

tree = Tree.new([2,3,1,5,8,3])
tree1 = Tree.new([5,10,4,6,12,1,2])
#tree = Tree.new([2,4,1])

#puts tree.root

#tree.level_order {|el| puts el.data}

#tree.level_order_iterative {|el| puts el.data}

#tree.preorder
#tree.inorder
#tree.postorder

p tree.preorder
p tree.inorder
p tree.postorder
p tree.level_order

#binding.pry

