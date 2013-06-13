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

  def suits
    result = []

    @cards.each do |card|
      result << card.suit
    end

    result
  end
end

class Card
  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end
end

class Poker
  attr_accessor :players, :winner

  def play
    @players.each do |player|
      @winner = player if consecutive_values(player) == 5 && same_suit(player)
    end
  end

  def consecutive_values(player)
    values = player.values
    find_sequences(values).first.size
  end

  def find_sequences(a)
    prev = a[0]

    a.slice_before { |cur|
      prev, prev2 = cur, prev
      prev2 - 1 != prev
    }.to_a
  end

  def same_suit(player)
    return 5
    player.uniq.length == 1
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
      poker.play
      poker.winner.should be player1
    end
  end

  describe "Four of a kind" do
    it "has 4 cards with the same value. Ranked by the value of the 4 cards." do
      pending
      player1 = Player.new([
        Card.new('C', 7),
        Card.new('D', 7),
        Card.new('H', 7),
        Card.new('S', 7),
        Card.new('C', 1)
      ])
      # Four of a kind
      player2 = Player.new([
        Card.new('C', 4),
        Card.new('D', 4),
        Card.new('H', 4),
        Card.new('S', 4),
        Card.new('C', 1)
      ])
      poker = Poker.new
      poker.players = [player1, player2]
      poker.play
      poker.winner.should be player1
    end
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

  it "returns the suits" do
    player1 = Player.new([
      Card.new('C', 7),
      Card.new('C', 6),
      Card.new('C', 5),
      Card.new('C', 4),
      Card.new('C', 3)
    ])
    suits = player1.suits
    suits.first.should == 'C'
    suits.last.should == 'C'
  end
end