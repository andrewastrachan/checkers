require_relative 'piece'
require_relative 'board'
require_relative 'human'
require_relative 'error'

class Game
  attr_reader :board
  
  def initialize
    @board   = Board.new
    @player_1 = Human.new("white", @board)
    @player_2 = Human.new("black", @board)
  end
  
  def play
    coord = [7, 0]
    @board.display(coord)
    until @board.win?("white") || @board.win?("black")
      @player_1.make_move(coord)
      @player_2.make_move(coord)
    end
    
    puts @board.win?("white") ? "White Wins!" : "Black Wins!"
  end
  
end

Game.new.play
