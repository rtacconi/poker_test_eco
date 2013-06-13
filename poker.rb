require 'rspec'

# 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A
# C, D, H, S

class Player
  attr_accessor :cards

  def initialize(cards = [])
    @cards = cards
  end

  def values
    result = []

    @cards.each do |card|
      result << card.value
    end

    result.sort.reverse
  end
end

class Card
  attr_accessor :suit, :value

  def initialize(suit, value)
    @suite = suit
    @value = value
  end
end

class Poker
  attr_accessor :players, :winner

  def play
    @players.each do |player|
      winner = player if consecutive_values(player) == 5 && same_suit(player)
    end
  end

  def consecutive_values(player)
    values = player.values
    find_sequences(values).first.size
  end

  def find_sequences(a)
    prev = a[0]
    a.slice_before { |cur|
      prev, prev2 = cur, prev  # one step further
      prev2 - 1 != prev        # two ago != one ago ? --> new slice
    }.to_a
  end

  def same_suit(player)
    player.uniq.length == 1
  end
end

describe Poker do
  describe "Straight flush" do
    it "has 5 cards of the same suit with consecutive values. Ranked by the highest card in the hand" do
      pending

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
      poker.play
      # poker.winner.should be player1
    end
  end

  describe Player do
    it "returns values of the cards" do
      player1 = Player.new([
        Card.new('C', 7),
        Card.new('C', 6),
        Card.new('C', 5),
        Card.new('C', 4),
        Card.new('C', 3)
      ])
      values = player1.values
      values.first.should == 7
      values.last.should == 3
    end

    it "finds the number of consecutive values" do
      player1 = Player.new([
        Card.new('C', 7),
        Card.new('C', 6),
        Card.new('C', 5),
        Card.new('C', 4),
        Card.new('C', 3)
      ])
      poker = Poker.new
      poker.players = [player1]
      poker.consecutive_values(player1).should == 5
    end
  end
end