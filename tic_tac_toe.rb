class Game

  private
  def initialize(p1, p2)

    @player_1 = Player.new(p1)
    @player_2 = Player.new(p2)

    @@winCases = [ [0, 4, 8], [3, 4, 5], [1, 4, 7], [2, 4, 6], 
                  [0, 1, 2], [0, 3, 6], [6, 7, 8], [2, 5, 8] ]
    @move_count = 1
    @grid = (1..9).to_a
    game_play
  end

  def game_play

    @win = false
    clear
    draw_board

    until @win
      move
      winning_combo?
      if winning_combo? == false and @stalemate == true
        stalemate
        @win = true
      end
    end
    play_again?
  end

  def draw_board
    @grid.each_with_index do |square, index|
      if (index+1) % 3 == 0
        print " #{square} \n"
        print "-----------\n" if index != 8
      else
        print " #{square} |"
      end
    end
  end

  def move

    if @move_count == 9
      @stalemate = true
    end

      @move_count % 2 == 0 ? @turn = @player_2 : @turn = @player_1
      puts "It's your move, #{@turn.name}"
      input = gets.chomp.to_i
    if valid_move?(input)  
      @turn == @player_1 ? @grid[input - 1] = 'X': @grid[input - 1] = 'O'

      @move_count += 1
      clear
      draw_board
    else
      return
    end
  end


  def valid_move?(input)
    if @grid[input - 1] == 'O' or @grid[input - 1] == 'X'
    clear 
    draw_board
    puts "Invalid move"
    return false  
    end
    return true
  end


  #not sure why this in printing the win twice
  def winning_combo?
    player = nil
    @@winCases.each do |a|
      player = @grid[a[0]]
      if (@grid[a[0]] == @grid[a[1]]) && (@grid[a[1]] == @grid[a[2]])
        puts "#{@turn.name} WON!"
        @win = true
        @stalemate = false
        return true
      end
    end
    return false
  end


  class Player
    attr_accessor :name
    def initialize(name)
      @name = name.downcase
    end
  end

  def clear
    system "clear"
  end

  def stalemate
    puts "Game ended in a stalemate."
  end

  def play_again?
    puts "Play again? y or n?"
    input = gets.chomp
    if input == 'y' 
      system "ruby tic_tac_toe.rb"
    end
  end
end


system "clear"
puts "Welcome to Tic Tac Toe"
sleep(2)
system "clear"
puts "Player 1 name:"
p1 = gets.chomp
system "clear"
puts "Player 2 name:"
p2 = gets.chomp
board = Game.new(p1, p2)