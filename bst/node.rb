class Node
  include Comparable

  attr_accessor :data, :left_child, :right_child

  def initialize(data, left_child=nil, right_child=nil)
    @data = data
  end

  def <=>(other)
    self.data <=> other.data
  end

  def to_s
    "#{left_child}<-#{data}->#{right_child}"
  end

  def replace(other)
    if other.nil?
      self.data = nil
      self.left_child = nil
      self.right_child = nil
    else
      self.data = other.data
      self.left_child = other.left_child
      self.right_child = other.right_child
    end
  end

  def swap(other)
    self.data = other.data
  end

  def has_no_children?
    self.left_child.nil? and self.right_child.nil?
  end

  def has_only_right_child?
    self.left_child.nil? and not self.right_child.nil?
  end

  def has_only_left_child?
    not self.left_child.nil? and self.right_child.nil?
  end

  def has_two_children?
    not self.left_child.nil? and not self.right_child.nil?
  end

  def clear_ref_if_child(node)
    self.left_child = nil if self.left_child == node
    self.right_child = nil if self.right_child == node        
  end

end