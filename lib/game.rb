class Game
    def initialize(player1, player2)
      @player1 = player1
      @player2 = player2
    end
  
    @@secret_code = ""
    @@winner = ""
    @@guess = ""
    @@codebreaker = ""
  
    def create_code
      if @player1.role == "codemaker"
  
        puts "Enter a digit between 1 and 4 to create your code sequence:"
        while @digit = gets.chomp.to_i
          if @digit < 1 or @digit > 4
            puts "Try again."
          else
            @@secret_code += @digit.to_s
            if @@secret_code.length == 4
              puts "Your secret code is #{@@secret_code}. Let's see if #{@player2.name} can crack it."
              break
            end
          end
        end
      else
        4.times do
          @@secret_code += rand(1..4).to_s
        end
      end
    end
  
    def guess
      if @player1.role == "codebreaker"
        @@codebreaker = @player1.name
        puts "Make your guess:"
        while @@guess = gets.chomp
          if @@guess.length == 4
            break
          else
            puts "Your guess must be 4 digits long."
          end
        end
        @player1.guesses += 1
      else
        @@codebreaker = @player2.name
        4.times do
          @@guess =+ rand(1..4)
        end
        @player2.guesses += 1
      end
    end
  
    def check_match
      @exact = 0
      @partial = 0
  
      @guess_array = @@guess.to_s.split('')
      @code_array = @@secret_code.split('')
      @index = 0
  
      for guess in @guess_array
        if @code_array.include?(guess)
          @partial += 1
        end
        if @code_array[@index] == guess
          @partial -= 1
          @exact += 1
        end
        @index += 1
      end
      puts "Exact mathes: #{@exact}"
      puts "Partial matches: #{@partial}"  
    end
  
  end