class Node

  attr_reader :value
  attr_accessor :parent, :right_child, :left_child

  def initialize(value)
    @value = value
    @parent = parent
  end

  def child_assign(child)
    if child.value < @value
      if @left_child.empty?
        @left_child = child
        child.parent = @parent
      else
        @left_child.child_assign(child)
      end
    else
      if @right_child.empty?
        @right_child = child
        child.parent = @parent
      else
        @right_child.child_assign(child)
      end
    end
  end

  def go_to_parent
    unless @parent.empty?
      @parent
    else
      puts "Error: No parent for this node!"
    end
  end

  def go_to_child(direction)
    direction = direction.strip.downcase
    if direction == "left"
      unless @left_child.empty?
        @left_child
      else
        puts "Error: No left child for this node!"
      end
    elsif direction == "right"
      unless @right_child.empty?
        @right_child
      else
        puts "Error: No right child for this node!"
      end
    else
      puts "Error: Invalid direction input!"
    end
  end

end

def build_tree(array)
  n = array.size
  parent = Node.new(array.first)
  array.delete_at(0)
  until n == 0
    child = Node.new(array.first)
    array.delete_at(0)
    parent.child_assign(child)
  end
  parent
  #if child == parent.right_child && parent.left_child.empty?
  #  if array.first <= parent.value
  #    child = Node.new(array.first)
  #    array.delete_at(0)
  #    parent.child_assign(child)
  #  else
  #    parent = child
  #    child = Node.new(array.first)
  #    array.delete_at(0)
  #    parent.child_assign(child)
  #  end
  #  child = Node.new(array.first)
  #  array.delete_at(0)
  #  parent.child_assign(child)
  #elsif child == parent.left_child && parent.right_child.empty?
  #  if array.first >= parent.value
  #    child = Node.new(array.first)
  #    array.delete_at(0)
  #    parent.child_assign(child)
  #  else
  #    parent = child
  #    child = Node.new(array.first)
  #    array.delete_at(0)
  #    parent.child_assign(child)
  #  end
  #end      
end