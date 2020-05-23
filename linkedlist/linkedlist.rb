require_relative 'node.rb'

class LinkedList
  attr_reader :length, :head, :tail

  def initialize
    @length = 0
    @head = nil
    @tail = nil
  end

  public
  def append(value)
    node = Node.new(value)
    if @length == 0
      @head = node
      @tail = node 
    else
      @tail.next_node = node
      @tail = node
    end
    @length += 1
  end

  def prepend(value)
    node = Node.new(value, @head)
    @head = node
    @length += 1
  end

  def [] (index)
    at(index)
  end

  def at(index)
    node = node_at(index)
    return nil if node.nil?
    return node.value
  end

  def pop
    oldtail = node_at(@length-1)
    @tail = node_at(@length-2)
    @tail.next_node = nil
    oldtail.value = nil
    oldtail.next_node = nil
    @length -= 1
  end

  def contains?(value)
    current_node = @head
    while not current_node.nil?
      return true if current_node.value == value
      current_node = current_node.next_node
    end
    return false
  end

  def find(value)
    index = 0
    current_node = @head
    while not current_node.nil?
      return index if current_node.value == value
      current_node = current_node.next_node
      index += 1
    end
    return nil
  end

  def to_s
    string = ""
    current_node = @head
    while not current_node.nil?
      string += vis(current_node.value)
      current_node = current_node.next_node
    end
    string += "nil"
    string
  end

  def insert_at(value, index)
    prev_node = node_at(index-1)
    old_node = prev_node.next_node
    new_node = Node.new(value, old_node)
    prev_node.next_node = new_node
  end

  def remove_at(index)
    prev_node = node_at(index-1)
    return nil if prev_node.nil? 
    following_node = prev_node.next_node.next_node
    prev_node.next_node = following_node
  end

  private

  def vis(value)
    "( #{value} ) -> "    
  end

  def node_at(index)
    return @head if index == 0 
    node = self.node_at(index-1)
    return nil if node.nil?
    node = node.next_node
  end
  
end

