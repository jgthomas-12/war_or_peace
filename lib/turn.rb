class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if player1.deck.cards[0].rank != player2.deck.cards[0].rank
      :basic
    end
  end

  def winner
    if type == :basic
      if player1.deck.cards[0].rank > player2.deck.cards[0].rank
        winner = player1
      else
        winner = player2
      end
    end
  end

  def pile_cards
    if type == :basic
      spoils_of_war << player1.deck.cards.shift
      spoils_of_war << player2.deck.cards.shift
    end
  end

  def award_spoils(winner)
    winner.deck.cards << spoils_of_war
    winner.deck.cards.flatten!
  end
end