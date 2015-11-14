class Knight

  attr_accessor :position

  def initialize(starting_position)
    @position = starting_position
  end

  def self.game_board
    game_board_array = []
    x,y = 0,0
    while x < 8
      while y < 8
        game_board_array << [x,y]
        y += 1
      end
      x += 1
      y = 0
    end
    game_board_array
  end

end