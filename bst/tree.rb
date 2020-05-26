require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = Node.new(array[0])
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

  def delete(value, current_node=@root, parent_node=nil)
    value.instance_of?(Node) ? node = value : node = Node.new(value)
    if node > current_node
      delete(node, current_node.right_child, current_node)
    elsif node < current_node
      delete(node, current_node.left_child, current_node)
    else
      if current_node.has_no_children? 
        current_node.replace(nil)
        parent_node.clear_ref_if_child(current_node)
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

  def level_order(queue=[@root], &block)
    first_node = queue[0]
    yield(first_node) if block_given?
    return if queue.length == 1 and first_node.has_no_children?
    queue.push(first_node.left_child) if not first_node.left_child.nil?
    queue.push(first_node.right_child) if not first_node.right_child.nil?
    level_order(queue[1..-1], &block)
  end

  def level_order_iterative
    queue=[@root]
    until queue.empty?
      first_node = queue[0]
      queue.push(first_node.left_child) if not first_node.left_child.nil?
      queue.push(first_node.right_child) if not first_node.right_child.nil?
      yield(first_node) if block_given?
      queue = queue[1..-1]
    end
  end

  def inorder(current_node=@root)
    return if current_node.nil?
    puts current_node.data
    preorder(current_node.left_child) 
    preorder(current_node.right_child)
  end

  def preorder(current_node=@root)
    return if current_node.nil?
    preorder(current_node.left_child) 
    puts current_node.data
    preorder(current_node.right_child)
  end

  def postorder(current_node=@root)
    return if current_node.nil?
    preorder(current_node.left_child) 
    preorder(current_node.right_child)
    puts current_node.data
  end

  private
  def build_tree(array)
    array[1..-1].each { |el| insert(el) }  #skips root, already inserted in initialize method
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