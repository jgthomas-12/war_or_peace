require "./lib/card"
require "./lib/deck"
require "./lib/deck_builder"

RSpec.describe DeckBuilder do
  let!(:git deck_builder) { DeckBuilder.new }

  it "exists" do
    expect(deck_builder).to be_a(DeckBuilder)
  end

  it "has readable attributes" do
    expect(deck_builder.deck.cards).to eq([])
  end
end