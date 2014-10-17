# -*- coding: utf-8 -*-

require 'colorize'

class Board 
  attr_reader :grid
  
  def create_grid
    Array.new(8) { Array.new(8) }
  end
  
  def setup_grid
    black_pos = [ [0, 0], [0, 2], [0, 4], [0, 6], [1, 1], [1, 3],
                  [1, 5], [1, 7], [2, 0], [2, 2], [2, 4], [2, 6] ]
    white_pos = [ [7, 1], [7, 3], [7, 5], [7, 7], [6, 0], [6, 2], 
                  [6, 4], [6, 6], [5, 1], [5, 3], [5, 5], [5, 7] ]
    grid = create_grid
    white_pos.each { |r, c| grid[r][c] = Piece.new([r, c], self, "white") }
    black_pos.each { |r, c| grid[r][c] = Piece.new([r, c], self, "black") }
    grid
    
    end
  
  def initialize(grid = setup_grid)
    @grid = grid
  end
  
  def []=(pos, val)
    row, column = pos
    @grid[row][column] = val
  end
  
  def [](pos)
    row, column = pos
    @grid[row][column]
  end
  
  def on_board?(pos)
    pos.all? { |num| num.between?(0, 7) }
  end
  
  def dup 
    duped = Board.new(create_grid)
    @grid.each_with_index do |row, rowidx|
      row.each_with_index do |col, colidx|
        current_place = [rowidx, colidx].dup
        if col.is_a?(Piece)
          duped[current_place] = Piece.new(col.pos.dup, duped, col.color, col.king)
        end
      end
    end
    
    duped 
  end
  
  def display(coord, *selected)
    @grid.each_with_index do |line, line_index|
      new_line = line.map.with_index do |piece, piece_index|
        square = "   "
        unless piece.nil? 
          if piece.king == true
            square = (piece.color) == "white" ? " ♔ " : " ♚ "
          else
            square = (piece.color == "white" ? " ○ " : " • ")
          end
        end
        
        if selected.any? { |space| space == [line_index, piece_index] } 
          square.on_light_green
        elsif coord == [line_index, piece_index]
          square.on_light_blue
        elsif(line_index + piece_index).even?
          square.on_red
        else 
          square
        end
      end
      new_line.each { |square| print square }
      puts " "
    end
  end
  
  #win if no remaining enemy pieces
  def win?(color)
    @grid.find_all do |line| 
      line.any? { |piece| piece != nil && piece.color != color }
    end.empty?
  end
  
end

