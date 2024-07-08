# frozen_string_literal: true

class Player
  attr_accessor :name, :role, :guesses

  def initialize(name, role, guesses)
    @name = name
    @role = role
    @guesses = guesses
  end
end
