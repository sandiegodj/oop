class Game
#maybe put a check to make sure player does not input the same letter twice
#and an AI if I find the time

  def initialize
    @@code = []
    generate_code
    display_instructions
    gameplay
  end

  def generate_code
      color = %w(A B C D E F).shuffle!
      4.times do |i|
        @@code << color[i]
      end
      puts @@code
  end
  def display_instructions
    puts "'Mastermind' The Game"
    sleep(2)
    puts "The computer will create a secret pattern of 4 unique letters ranging from A to F."
    sleep(3)
    puts "You have twelve chances to guess the correct pattern."
    sleep(3)
    puts "After each guess, you will recieve feedback:"
    sleep(2)
    puts "A 'Z' will represent a correct letter in the correct spot,"
    sleep(2)
    puts "and a 'X' will represent a correct color in a wrong spot."
    sleep(2)
    puts "Good luck!"
    sleep(1)
    puts "\n\n\n"
  end

  def gameplay

    @turns = 1
    @win = false
    until @win
      if @turns == 12
      #game_over method
      end
      print "Guess:"
      @guess = gets.chomp.upcase.split('').to_a
      placement
      correct_color
    end
  end

  def placement
    if @guess.count > 4
      puts "You entered too many letters! Try again chump"
    end
    @feedback = %w(No No No No)
    correct = 0
    @temp = @guess
    n = 0    
    @guess.each_with_index do |guess, n|
      if guess == @@code[n]
        @feedback[n] = "Z"
        correct += 1
        @temp[n] = " "
      end
    
    end

    if correct == 4
      @win = true
    end

  end

  def correct_color

    correct = 0
    @temp.each_with_index do |guess, n| 
      if @@code.include? guess
        correct += 1
        @feedback[n] = "X"
      end
    end
    print @feedback
    puts ""
    @turns += 1
  end
end

game = Game.new
