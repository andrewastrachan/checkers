require 'io/console'

class Human
  
  def initialize(color, board)
    @color = color
    @board = board
  end
  
  def make_move(coord)
    begin
      from = get_coord(coord)[0]
      
      valid_select_space?(from)

      to = get_coord(coord)
      
      piece_to_move = @board[from]
      piece_to_move.perform_moves(to)
    
    rescue InvalidMoveError 
      puts "please try again"
      retry
    rescue NilSelectError 
      puts "please try again"
      retry
    end
  end
  
  private 
  
  def read_char
      STDIN.echo = false
      STDIN.raw!
      
      input = STDIN.getc.chr
      if input == "\e" then
          input << STDIN.read_nonblock(3) rescue nil
          input << STDIN.read_nonblock(2) rescue nil
      end
      ensure
      STDIN.echo = true
      STDIN.cooked!
      
      return input
  end
  
  def show_single_key
      c = read_char
      
      case c
          when " "
          :spc
          when "s"
          :sel
          when "\e[A"
          :up
          when "\e[B"
          :down
          when "\e[C"
          :right
          when "\e[D"
          :left
      end

  end
  
  #this is nasty 
  def get_coord(coord) 
    coord = coord
    move = []
    selecting = true
      while selecting 
        key = show_single_key
          if key == :down
            coord[0] += 1
          elsif key == :up
            coord[0] -= 1
          elsif key == :left
            coord[1] -= 1
          elsif key == :right
            coord[1] += 1
          elsif key == :spc
            move << coord.dup
          elsif key == :sel
            move << coord.dup unless move.include?(coord.dup)
            selecting = false
          end
        
        # if move.length > 1
          system "clear"
          @board.display(coord, move[0], move[1], move[2], move[3])  
          puts "  "
          print "#{@color == "white" ? 'White' : 'Black'} Turn".blue
          puts " "
          puts "select a space with s".green
          puts "select a string of jumps with the spacebar".green
        # end
      end
    
    move
  end
  
  def valid_select_space?(move)
    if @board[move].nil? || @board[move].color != @color 
      raise NilSelectError.new
    end
  end
   
end