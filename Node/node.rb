class Node

  attr_reader :value, :parent, :right_child, :left_child

  def initialize(value,parent=nil)
    @value = value
    @parent = parent
  end

  def parent_assign
    unless @parent.nil?
      if @parent.value >= @value
        @parent.left_child = self
      else
        @parent.right_child = self
      end
    end
  end

  def child_assign(child_value)

  end

end