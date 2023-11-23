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
    if player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) && player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
      :mutually_assured_destruction
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
      :war
    else
      :basic
    end
  end

  def winner
    if type == :basic
      basic_play
    elsif type == :war
      war_play
    else
      "No Winner"
    end
  end

  def pile_cards
    if type == :basic
      basic_pile
    elsif type == :war
      war_pile
    else
      mutually_assured_destruction_play
    end
  end

  def award_spoils(winner)
    return "No Winner, No Spoils" if winner == "No Winner"
    winner.deck.cards << spoils_of_war
    winner.deck.cards.flatten!
  end

  def basic_play
    return player1 if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
    player2
  end

  def war_play
    return player1 if player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2)
    player2
  end

  def mutually_assured_destruction_play
    3.times { player1.deck.remove_card }
    3.times { player2.deck.remove_card }
  end

  def basic_pile
    spoils_of_war << player1.deck.cards.shift
    spoils_of_war << player2.deck.cards.shift

  end

  def war_pile
    spoils_of_war.concat(player1.deck.cards[0..2])
    3.times { player1.deck.remove_card }
    spoils_of_war.concat(player2.deck.cards[0..2])
    3.times { player2.deck.remove_card }
    spoils_of_war.flatten!
  end
end