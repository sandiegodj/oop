#maybe put a check to make sure player does not input the same letter twice
#and an AI if I find the time
class Game


  def initialize
    @@code = []  
    @guess = []
    controller
  end


  def controller
    puts "Please choose which game option you would like to play:"
    sleep(1)
    puts "Enter 1 to be the guesser; 2 to be the creator"

    input = gets.chomp

    if input == "1"
      ai_generate_code
      display_instructions
      gameplay
    else
      user_generate_code
      @ai = true
      gameplay
    end
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


  def user_generate_code
    pass = false
    invalid = false
    puts "Enter a pattern of 4 unique letters ranging from A to F"
    until pass == true
      if invalid == true
        puts "That pattern is invalid!"
      end
      print "Pattern:"
      @@code = gets.chomp.upcase.split("")
      @@code.each_with_index do |letter, i|
        if letter == "A" or letter == "B" or letter == "C" or letter == "D" or letter == "E" or letter == "F" && i <= 4
          pass = true
        else
          pass = false
          invalid = true
        end
      end
    end
  end


  def ai_generate_code
    color = %w(A B C D E F).shuffle!
    4.times do |i|
      @@code << color[i]
    end
    puts @@code
  end


  def gameplay
    @turns = 1
    @win = false
    until @win
      if @turns == 12
      puts "GAME OVER!  Better luck next time!"
      end
      if @ai 
        ai_guess
      else
        print "Guess:"
        @guess = gets.chomp.upcase.split('').to_a
      end
        placement
        correct_color
    end
  end


  def ai_guess
    @prev_guess = []
    @guess.each {|guess| @prev_guess << guess}
    @guess = []

    color = %w(A B C D E F).shuffle!
    4.times do
      @guess << color.pop
    end

    if @feedback != nil
      @guess.map!.with_index do |letter, i|
        if @feedback[i] == "Z"
          letter = @prev_guess[i]          
        else
          letter = letter
        end
      end
    end
  end


  def placement
    if @guess.count > 4
      puts "You entered too many letters! Try again chump"
    end
    @feedback = %w(No No No No)
    correct = 0
    @temp = []
    n = 0    
    @guess.each_with_index do |guess, n|
      @temp << guess
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
    @temp.each_with_index do |guess, n| 
      if @@code.include? guess
        @feedback[n] = "X"
      end
    end
    print @feedback
    puts ""
    @turns += 1
  end
end

game = Game.new
