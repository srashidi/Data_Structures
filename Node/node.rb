class Node

  attr_reader :value
  attr_accessor :parent, :right_child, :left_child

  def initialize(value)
    @value = value
  end

  def child_assign(child)
    if child.value < @value
      if @left_child.nil?
        @left_child = child
        @left_child.parent = self   #questionable
      else
        @left_child.child_assign(child)
      end
    else
      if @right_child.nil?
        @right_child = child
        @right_child.parent = self   #questionable
      else
        @right_child.child_assign(child)
      end
    end
  end

  def go_to_parent
    unless @parent.nil?
      @parent
    else
      puts "Error: No parent for this node!"
    end
  end

  def go_to_child(direction)
    direction = direction.strip.downcase
    if direction == "left"
      unless @left_child.nil?
        @left_child
      else
        puts "Error: No left child for this node!"
      end
    elsif direction == "right"
      unless @right_child.nil?
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
  parent = Node.new(array[n/2])
  array.delete_at(n/2)
  until array.size == 0
    n = array.size
    child = Node.new(array[n/2])
    array.delete_at(n/2)
    parent.child_assign(child)
  end
  parent
end

puts build_tree([1,4,6,7,2,4,9,11]).inspect