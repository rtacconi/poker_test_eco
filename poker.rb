require 'rspec'

# 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A
# C, D, H, S

class Poker
  attr_accessor :players
end

class Player
  attr_accessor :cards

  def initialize(cards = [])
    @cards = cards
  end
end

class Card
  attr_accessor :suit, :value

  def initialize(suit, value)
    @suite = suit
    @value = value
  end
end

describe Poker do
  describe "Straight flush" do
    it "has 5 cards of the same suit with consecutive values. Ranked by the highest card in the hand" do
      # Straight flush
      player1 = Player.new([
        Card.new('C', 7),
        Card.new('C', 6),
        Card.new('C', 5),
        Card.new('C', 4),
        Card.new('C', 3)
      ])
      # Four of a kind
      player2 = Player.new([
        Card.new('C', 6),
        Card.new('C', 5),
        Card.new('C', 4),
        Card.new('C', 3),
        Card.new('H', 6)
      ])
      poker = Poker.new
      poker.players = [player1, player2]
    end
  end
end