class Piece
  
  attr_reader :pos, :color, :king
  
  #whites start at bottom

  def initialize(pos, grid, color, king = false)
    @pos   = pos
    @color = color
    @grid  = grid
    @king  = king
  end
  
  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else 
      raise InvalidMoveError.new "can't do that"
    end
  end  
  
  def valid_move_seq?(move_sequence)
    dup_grid = @grid.dup
    begin 
      dup_grid[self.pos.dup].perform_moves!(move_sequence)
    rescue InvalidMoveError
      false
    else
      true
    end
  end
  
  # how can i clean this up, get rid of need to check 
  # that the slide is valid twice?
  def perform_moves!(move_sequence)
    if move_sequence.count == 1
      if perform_slide?(move_sequence[0])
        perform_slide(move_sequence[0])
      else 
        perform_jump(move_sequence[0])
      end
    else
      move_sequence.each do |move|
        perform_jump(move)
      end
    end
  end
  
  private 

  
  def perform_slide(move_pos)
    if perform_slide?(move_pos)
      move_piece(@pos, move_pos)
      maybe_promote
    else 
      raise InvalidMoveError.new "this move action is not allowed"
    end
  end
  
  def perform_jump(move_pos)
    if perform_jump?(move_pos)
      take_piece(@pos, move_pos)
      move_piece(@pos, move_pos)
      maybe_promote
    else
      raise InvalidMoveError.new "this take action is not allowed"
    end
  end
  
  def maybe_promote
    if (@color == "white" && @pos[0] == 0) || (@color == "black"  && @pos[0] == 7)
      @king = true
    end
  end
  
  def move_piece(start, finish)
    @grid[start]    = nil
    @grid[finish]   = self
    @pos            = finish
  end
  
  def take_piece(start, finish)
    s_row, s_col = start
    f_row, f_col = finish
    taken = [(s_row + f_row) / 2, (s_col + f_col) / 2 ]
    @grid[taken] = nil
  end
  
  def valid_move?(move_pos)
    @grid.on_board?(move_pos) && @grid[move_pos].nil?
  end
  
  def perform_jump?(move_pos)
    valid_move?(move_pos) && possible_jumps.include?(move_pos)
  end
  
  def perform_slide?(move_pos)
    valid_move?(move_pos) && possible_slides.include?(move_pos)
  end
  
  #come back and refactor this... logic a little messy 
  def possible_jumps
    pos_jumps = [ ]
    row, col = @pos
    move_diffs.each do |row_change, col_change| 
      jumped_piece = [row + row_change, col + col_change]
      new_position = [row + (row_change * 2), (col + col_change * 2)]
      unless @grid[jumped_piece].nil? || @grid[jumped_piece].color == @color
        pos_jumps << new_position
      end
    end
    pos_jumps
  end
  
  def possible_slides
    slides = [ ]
    row, col = @pos
    move_diffs.each do |row_change, col_change| 
      slides << [row + row_change, col + col_change]
    end
    slides
  end
  
  def move_diffs
    up, down = -1, 1
    left, right = -1, 1
    moves = [[up, left], [up, right], [down, left], [down, right]]
    if @king == true 
      moves[0..3]
    else 
      @color == "white" ? moves[0..1] : moves[2..3]
    end
  end

end