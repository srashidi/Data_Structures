class Node

  attr_reader :value
  attr_accessor :parent, :right_child, :left_child

  # Initializes an instance of Node with a given value
  def initialize(value)
    @value = value
  end

  # Assigns a given child Node to an instance of Node
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

  # Allows to navigate to the parent of an instance of Node
  def go_to_parent
    unless @parent.nil?
      @parent
    else
      puts "Error: No parent for this node!"
    end
  end

  # Allows to navigate to the child of an instance of Node given the direction
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

  # Allows for a breadth-first search of a given value in a binary Node tree
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

  # Allows for a depth-first search of a given value in a binary Node tree
  def depth_first_search(target_value)
    search_stack = []
    tested = []
    parent = self
    search_stack << parent
    return parent if parent.value == target_value
    tested << parent
    until search_stack.empty?
      while search_stack[-1].left_child && tested.include?(search_stack[-1].left_child) == false
        search_stack << search_stack[-1].left_child
        return search_stack[-1] if search_stack[-1].value == target_value
        tested << search_stack[-1]
      end
      unless search_stack[-1].right_child
        until (search_stack.empty? || (search_stack[-1].right_child && tested.include?(search_stack[-1].right_child) == false))
          search_stack.pop
        end
      end
      if search_stack.empty?
        nil
      elsif search_stack[-1].right_child && tested.include?(search_stack[-1].right_child) == false
        search_stack << search_stack[-1].right_child
        return search_stack[-1] if search_stack[-1].value == target_value
        tested << search_stack[-1]
      end
    end
  end

end

# Builds a tree of interrelated Node objects given an array of values
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

# A recursive method that performs a depth-first search for a given value
# in a given tree
def dfs_rec(node,target_value)
  return node if node.value == target_value
  dfs_rec(node.left_child,target_value) if node.left_child
  dfs_rec(node.right_child,target_value) if node.right_child
end

# Displays a given tree
def display_tree(tree_parent) # Need to work on this
end

# Build a tree from an array of values
tree = build_tree([1,4,6,7,2,4,9,11])
puts tree.inspect
puts "\n"
# Test breadth_first_search (should yield a result)
puts tree.breadth_first_search(11)
puts "\n"
# Test breadth_first_search (should yield nil)
puts tree.breadth_first_search(12).inspect
puts "\n"
# Test depth_first_search (should yield a result)
puts tree.depth_first_search(11)
puts "\n"
# Test depth_first_search (should yield nil)
puts tree.depth_first_search(12).inspect
puts "\n"
# Test recursive depth_first_search (should yield a result)
puts dfs_rec(tree,11)
puts "\n"
# Test recursive depth_first_search (should yield nil)
puts dfs_rec(tree,12).inspect
puts "\n"