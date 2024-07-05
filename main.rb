
require_relative("/home/sarav9/repos/ruby/odin-mastermind/lib/player.rb")
require_relative("/home/sarav9/repos/ruby/odin-mastermind/lib/game.rb")

GUESS_LIMIT = 3

p2_name = "Computer"
p2_role = ""

puts "Let's play Mastermind and crack some secret codes.\nWhat's your name?"
p1_name = gets.chomp.capitalize
puts "Hi #{p1_name}! Are you playing as the codemaker or the codebreaker?"
while p1_role = gets.chomp.downcase
  case p1_role
  when "codemaker"
    p1_role = "codemaker"
    p2_role = "codebreaker"
    puts "Great! Let's begin!"
    break
  when "codebreaker"
    p1_role = "codebreaker"
    p2_role = "codemaker"
    puts "Great! Let's begin your game against #{p2_name}."
    break
  else
    "Invalid input. Are you playing as the codemaker or the codebreaker?"
  end
end

player1 = Player.new(p1_name, p1_role, 0)
player2 = Player.new(p2_name, p2_role, 0)

game = Game.new(player1, player2)

game.create_code
until player1.guesses >= GUESS_LIMIT or player2.guesses >= GUESS_LIMIT
  game.guess
  game.check_match
  if @@winner != ""
    break
  end
end
