require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    build_tree(array)
  end

  def insert(value, current_node=@root)
    value.instance_of?(Node) ? node = value : node = Node.new(value)
    if node < current_node
      if current_node.left_child.nil?
        current_node.left_child = node
      else
        insert(node, current_node.left_child)
      end
    else
      if current_node.right_child.nil?
        current_node.right_child = node
      else
        insert(node, current_node.right_child)
      end
    end
    #set root as current node
    #if current node is less than new node and left child empty set current node left child to new node
    #if left child not empty set current node to left child
    #if current node is greater or equal to new node and right child is empty set right child to new node 
    #if right child not empty set current node to right child
  end

  #deletion doesn't work as intended yet
  def delete(value, current_node=@root, parent_node=nil)
    value.instance_of?(Node) ? node = value : node = Node.new(value)
    if node > current_node
      delete(node, current_node.right_child, current_node)
    elsif node < current_node
      delete(node, current_node.left_child, current_node)
    else
      if current_node.has_no_children? 
        current_node.replace(nil)
        parent_node.clear_ref_if_child(current_node) #clears reference to children in parent
      elsif current_node.has_only_right_child? 
        current_node.replace(current_node.right_child) 
      elsif current_node.has_only_left_child? 
        current_node.replace(current_node.left_child) 
      elsif current_node.has_two_children?
        pre_or_suc_node = find_pre_or_suc_node(current_node)
        current_node.swap(pre_or_suc_node)
        delete(pre_or_suc_node, pre_or_suc_node, pre_or_suc_node)
      end
    end
    #set root as current node
    #if current node is more than node to delete search recursively to the left side of current node
    #if current node is less than node to delete search recursively to the right side of current node
    #if current node equals node to delete 
    # and no children set node to nil
    # else if one child (left or right) remove the node and replace with this child
    # else if two children choose one of the following:
    #   recursively find in-order precedessor (rightmost element in left subtree)
    #   copy data from found precedessor to node that is being deleted
    #   recursively find in-order succesor (leftmost element in right subtree)
  end

  def find(value, current_node=@root)
    value.instance_of?(Node) ? node = value : node = Node.new(value)
    if node > current_node
      find(node, current_node.right_child)
    elsif node < current_node
      find(node, current_node.left_child)
    else
      return current_node 
    end
  end

  def level_order(queue=[@root], array=[], &block)
    first_node = queue[0]
    block_given? ? yield(first_node) : array.push(first_node.data)
    return if queue.length == 1 and first_node.has_no_children?
    queue.push(first_node.left_child) if not first_node.left_child.nil?
    queue.push(first_node.right_child) if not first_node.right_child.nil?
    level_order(queue[1..-1], array, &block)
    array
  end

  def level_order_iterative
    queue=[@root]
    array=[]
    until queue.empty?
      first_node = queue[0]
      queue.push(first_node.left_child) if not first_node.left_child.nil?
      queue.push(first_node.right_child) if not first_node.right_child.nil?
      block_given? ? yield(first_node) : array.push(first_node)
      queue = queue[1..-1]
    end
    array
  end

  def _inorder(current_node=@root, array=[], &block)
    return if current_node.nil?
    block_given? ? yield(current_node.data) : array.push(current_node.data)
    _inorder(current_node.left_child, array, &block) 
    _inorder(current_node.right_child, array, &block)
    array
  end

  def _preorder(current_node=@root, array=[], &block)
    return if current_node.nil?
    _preorder(current_node.left_child, array, &block) 
    block_given? ? yield(current_node.data) : array.push(current_node.data)
    _preorder(current_node.right_child, array, &block)
    array
  end

  def _postorder(current_node=@root, array=[], &block)
    return if current_node.nil?
    _postorder(current_node.left_child, array, &block) 
    _postorder(current_node.right_child, array, &block)
    block_given? ? yield(current_node.data) : array.push(current_node.data)
    array
  end

  ["in", "pre", "post"].each do |method|
    define_method "#{method}order" do |current_node=@root, array=[], &block|
      return if current_node.nil?
      (block_given? ? yield(current_node.data) : array.push(current_node.data)) if method == "pre"
      send "#{method}order", current_node.left_child, array, &block
      (block_given? ? yield(current_node.data) : array.push(current_node.data)) if method == "in"
      send "#{method}order", current_node.right_child, array, &block
      (block_given? ? yield(current_node.data) : array.push(current_node.data)) if method == "post"
      array
    end
  end

  def depth(node=@root)
    return 0 if node.nil?
    left_depth = depth(node.left_child)
    right_depth = depth(node.right_child)
    if left_depth > right_depth
      left_depth + 1
    else
      right_depth + 1
    end
  end

  def balanced?(node=@root)
    return 0 if node.nil?
    left_depth = depth(node.left_child)
    right_depth = depth(node.right_child)
    depth_diff = (left_depth - right_depth).abs
    depth_diff > 1 ? false : true
  end

  def rebalance!
    if not balanced?
      build_tree(level_order)
    else
      puts "Tree is balanced, no need to rebalance"
    end
  end

  private
  def build_tree(array)
    @root = Node.new(array[0])
    array[1..-1].each { |el| insert(el) }
  end

  def find_pre_or_suc_node(node)
    (rand(2) % 2 == 0) ? find_in_order_precedessor(node.left_child) : find_in_order_successor(node.right_child)
  end

  def find_in_order_precedessor(node)
    return node if node.right_child.nil?
    find_in_order_precedessor(node.right_child, node)
  end

  def find_in_order_successor(node)
    return node if node.left_child.nil?
    find_in_order_precedessor(node.left_child, node)
  end  

end