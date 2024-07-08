# frozen_string_literal: true

class Game
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  @@secret_code = ''
  @@winner = ''
  @@guess = ''
  @@codebreaker = ''

  def print_colours(string)
    @array = string.split('')
    @hashes_array = []
    @index = 0
    @array.each do |n|
      @number = n
      case @number
      when '1'
        @colour = :red
      when '2'
        @colour = :green
      when '3'
        @colour = :blue
      when '4'
        @colour = :yellow
      end
      @hashes_array[@index] = { @number => @colour }
      @index += 1
    end

    @hashes_array.each do |hash|
      hash.each { |k, v| print k.to_s.colorize(v) }
    end
  end

  def create_code
    if @player1.role == 'codemaker'

      while @@secret_code.length != 4
        puts "Chose the colours to create your secret code sequence by typing the corresponding number:\n#{'1, '.colorize(:red)}#{'2, '.colorize(:green)}#{'3  '.colorize(:blue)}or #{'4'.colorize(:yellow)}"
        @number = gets.chomp.to_i
        if (@number < 1) || (@number > 4)
          puts 'Try again'
        else
          @@secret_code += @number.to_s
        end
      end
      puts "\nGreat! Your code is: "
      print_colours(@@secret_code)
      puts "\nLet's see if #{@player2.name} will be able to crack it."
    else
      4.times do
        @@secret_code += rand(1..4).to_s
      end
      puts 'Computer code: '
      print_colours(@@secret_code)
    end
  end

  def guess
    if @player1.role == 'codebreaker'
      @@codebreaker = @player1.name
      puts "\nMake your guess:"
      while (@@guess = gets.chomp)
        break if @@guess.length == 4

        puts 'Your guess must be 4 digits long.'

      end
      @player1.guesses += 1
    else
      @@codebreaker = @player2.name
      4.times do
        @@guess += rand(1..4).to_s
      end
      @player2.guesses += 1
    end
  end

  def check_match
    @@exact = 0
    @partial = 0

    @guess_array = @@guess.to_s.split('')
    @code_array = @@secret_code.split('')
    @index = 0

    @guess_array.each do |guess|
      @partial += 1 if @code_array.include?(guess)
      if @code_array[@index] == guess
        @partial -= 1
        @@exact += 1
      end
      @index += 1
    end
    puts "\nGuess: "
    print_colours(@@guess)
    puts "\nExact match: #{@@exact}"
    puts "Partial match: #{@partial}"

    @@guess = ''
  end

  def check_win
    return unless @@exact == 4

    true
  end

  def out_of_guesses(player1, player2)
    if player1.guesses == GUESS_LIMIT
      puts "\nYOU LOST. You're out of guesses."
      true
    elsif player2.guesses == GUESS_LIMIT
      puts "\nYOU WIN! #{player2.name} didn't manage to crack your code."
      true
    end
  end
end
