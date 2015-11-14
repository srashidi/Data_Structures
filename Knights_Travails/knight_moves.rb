class Knight

  attr_accessor :position

  # Creates a knight instance on a gameboard with a given
  # starting position
  def initialize(starting_position)
    @gameboard = GameBoard.new
    if position_check(starting_position)
      @position = starting_position
    else
      puts "Error: Invalid starting position!"
    end
  end

  # Determines all next possible moves from current position
  def next_possible_moves
    positions_array = []
    x = @position[0]
    y = @position[1]
    next_position = [x+1,y+2]
    positions_array << next_position if position_check(next_position)
    next_position = [x+1,y-2]
    positions_array << next_position if position_check(next_position)
    next_position = [x-1,y+2]
    positions_array << next_position if position_check(next_position)
    next_position = [x-1,y-2]
    positions_array << next_position if position_check(next_position)
    next_position = [x+2,y+1]
    positions_array << next_position if position_check(next_position)
    next_position = [x+2,y-1]
    positions_array << next_position if position_check(next_position)
    next_position = [x-2,y+1]
    positions_array << next_position if position_check(next_position)
    next_position = [x-2,y-1]
    positions_array << next_position if position_check(next_position)
    positions_array
  end

  # Checks a position to make sure it is on the gameboard
  def position_check(position)
    @gameboard.array.include?(position)
  end

end

class GameBoard

  attr_reader :array

  # Creates a new 8x8 gameboard, starting at [0,0],
  # [0,1], [0,2]... all the way up to ...[7,5],
  # [7,6], [7,7]
  def initialize
    @array = []
    x,y = 0,0
    while x < 8
      while y < 8
        @array << [x,y]
        y += 1
      end
      x += 1
      y = 0
    end
    @array
  end

end

def knight_moves(starting_position,ending_position)
  return "You didn't need to move at all!" if starting_position == ending_position
  search_queue = []
  moves_array = [starting_position]
  knight = Knight.new(starting_position)
  possible_moves = knight.next_possible_moves
  if possible_moves.include?(ending_position)
    moves_array << ending_position
    number_of_moves = moves_array.size - 1
  else
    possible_moves.each do |position|
      search_queue << [position]
    end
  end
  until moves_array[-1] == ending_position
    next_moves = search_queue.shift
    knight.position = next_moves[-1]
    possible_moves = knight.next_possible_moves
    if possible_moves.include?(ending_position)
      next_moves.each { |move| moves_array << move }
      moves_array << ending_position
      number_of_moves = moves_array.size - 1
    else
      possible_moves.each do |position|
        next_moves << position
        search_queue << next_moves
        next_moves.pop
      end
    end
  end
  if number_of_moves == 1
    puts "You made it in #{number_of_moves} move! Here's your path:"
  else
    puts "You made it in #{number_of_moves} moves! Here's your path:"
  end
  moves_array.each { |position| puts position.inspect }
end

knight_moves([0,0],[5,4])