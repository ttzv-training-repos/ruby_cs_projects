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
    node_at(index).value
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
    
  end

  def find(value)
    
  end

  def to_s
    i = @length - 1
    string = ""
    i.downto(0) do |j|
      string += vis(node_at(j).value)
    end
    string += "nil"
    string
  end

  def insert_at(value, index)
    
  end

  def remove_at(index)
    
  end

  private

  def vis(value)
    "( #{value} ) -> "    
  end

  def node_at(index)
    return @head if index == 0 
    node = self.node_at(index-1).next_node
  end
  
end

list = LinkedList.new

list.append(5)
p list.head.value, list.tail.value
list.append(4)
p list.head.value, list.tail.value
list.append(3)
p list.head.value, list.tail.value
list.append(2)
p list.head.value, list.tail.value

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