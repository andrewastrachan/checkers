require_relative 'game'

# These tests used to validate double jumps, etc. 

g = Board.new
g.display
#
# to_move = g[[5, 1]]
# to_move.perform_moves([[4, 2]])
#
# to_move. perform_moves([[3, 3]])
#
#
# to_move = g[[6, 0]]
# to_move.perform_moves([[5, 1]])
#
# g.display
#
# to_move = g[[2, 4]]
# p to_move
#
# to_move.perform_moves([[4, 1]])
# g.display

# To use these tests, make perform actions public

# puts " perform slide to [1, 1] should be valid"
# b = Board.new
# p = Piece.new([0, 0], b, "black")
# b[[0, 0]] = p
# b.display
# puts " "
# p.perform_slide([1, 1])
# b.display
#
# puts " perform slide to [0, 1] should not"
#
# b = Board.new
# p = Piece.new([0, 0], b, "black")
# b[[0, 0]] = p
# b.display
# puts " "
# p.perform_slide([0, 1])
# b.display
#
# puts " perform jump over piece at [1, 1] should be valid when piece is white"
#
# w = Piece.new([1, 1], b, "white")
# b[[1, 1]] = w
# b.display
# puts " "
# p.perform_jump([2, 2])
# b.display
#
# puts " perform jump over black piece should not"
#
# b = Board.new
# p = Piece.new([0, 0], b, "black")
# b[[0, 0]] = p
# bl = Piece.new([1, 1], b, "black")
# b[[1, 1]] = bl
# b.display
# puts " "
# p.perform_jump([2, 2])
# b.display
#
# puts " black movement to last row should promote to king"
#
# b = Board.new
# p = Piece.new([6, 1], b, "black")
# b[[6, 1]] = p
# b.display
# puts " "
# p.perform_slide([7, 2])
# b.display
