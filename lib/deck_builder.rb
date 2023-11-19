class DeckBuilder
  attr_reader :deck

  def initialize
    @deck = Deck.new([])
  end
end