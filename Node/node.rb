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
        @left_child.parent = self
      else
        @left_child.child_assign(child)
      end
    else
      if @right_child.nil?
        @right_child = child
        @right_child.parent = self
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
        nil
      end
    elsif direction == "right"
      unless @right_child.nil?
        @right_child
      else
        puts "Error: No right child for this node!"
        nil
      end
    else
      puts "Error: Invalid direction input!"
    end
  end

  def breadth_first_search(target_value)
    search_queue = []
    parent = self
    return parent if parent.value == target_value
    if parent.left_child
      if parent.left_child == target_value
        return parent.left_child
      else
        search_queue << parent.left_child
      end
    end
    if parent.right_child
      if parent.right_child == target_value
        return parent.right_child
      else
        search_queue << parent.right_child
      end
    end
    until search_queue.size == 0
      parent = search_queue.shift
      return parent if parent.value == target_value
      if parent.left_child
        if parent.left_child == target_value
          return parent.left_child
        else
          search_queue << parent.left_child
        end
      end
      if parent.right_child
        if parent.right_child == target_value
          return parent.right_child
        else
          search_queue << parent.right_child
        end
      end
    end
    nil
  end

  def depth_first_search(target_value)
    search_stack = []
    tested = []
    parent = self
    search_stack << parent
    return parent if parent.value == target_value
    tested << parent
    until search_stack.empty?
      begin
        if search_stack[-1].left_child && tested.include?(search_stack[-1].left_child) == false
          search_stack << search_stack[-1].left_child
          return search_stack[-1] if search_stack[-1].value == target_value
          tested << search_stack[-1]
        end
      end while search_stack[-1].left_child && tested.include?(search_stack[-1].left_child) == false
      unless search_stack[-1].right_child
        until (search_stack.empty? || (search_stack[-1].right_child && tested.include?(search_stack[-1].left_child) == false))
          search_stack.pop
        end
      end
      if search_stack.empty?
        nil
      elsif search_stack[-1].right_child && tested.include?(search_stack[-1].left_child) == false
        search_stack << search_stack[-1].right_child
        return search_stack[-1] if search_stack[-1].value == target_value
        tested << search_stack[-1]
      end
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

def display_tree(tree_parent) # Need to work on this
end

tree = build_tree([1,4,6,7,2,4,9,11])
puts tree.inspect
puts "\n"
puts tree.breadth_first_search(11)
puts "\n"
puts tree.breadth_first_search(12).inspect
puts "\n"
puts tree.depth_first_search(7).inspect
puts "\n"
puts tree.depth_first_search(12).inspect