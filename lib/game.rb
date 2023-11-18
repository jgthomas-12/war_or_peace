require "./lib/turn"

class Game
  attr_reader :player1,
              :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def start
    puts "Welcome to War! (or Peace) This game will be played with 52 cards."
    puts "The players today are #{player1.name} and #{player2.name}."
    puts "Type 'GO' to start the game!"
    puts "------------------------------------------------------------------"
    start_game_on_user_input
  end

  def start_game_on_user_input
    command = nil
    while command != 'GO'
      "Type 'GO' to start the game!"
      command = gets.chomp
    end
    play_game
  end

  # def play_game
  #   turn_counter = 1
  #   until @player1.has_lost? || @player2.has_lost? || turn_counter == 1000
  #     turn = Turn.new(@player1, @player2)
  #     winner = turn.winner
  #     if turn.type == :basic
  #       turn.pile_cards
  #       turn.award_spoils(winner)
  #       turn_counter += 1
  #       puts "Turn #{turn_counter}: #{winner.name} won 2 cards"
  #     elsif turn.type == :war
  #       turn.pile_cards
  #       turn.award_spoils(winner)
  #       turn_counter += 1
  #       puts "Turn #{turn_counter}: WAR - #{winner.name} won 6 cards"
  #     else
  #       turn.mutually_assured_destruction_play
  #       turn_counter += 1
  #       puts "Turn #{turn_counter}: *mutually assured destruction* 6 cards removed from play"
  #     end
  #     if @player1.has_lost?
  #       puts "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
  #     end
  #     if @player2.has_lost?
  #       puts "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
  #     end
  #   end
  #   if turn_counter == 1000
  #     puts "Turn #{turn_counter}: DRAW"
  #   end
  # end

  def play_game
    @turn_counter = 1
    until game_over?
      take_turn
      print_winner_messages
      @turn_counter += 1
      draw?
    end
  end

  def game_over?
    @player1.has_lost? || @player2.has_lost? || @turn_counter == 5000
  end

  def take_turn
    @turn = Turn.new(@player1, @player2)
    winner = @turn.winner
    if @turn.type == :basic
      @turn.pile_cards
      @turn.award_spoils(winner)
      puts "Turn #{@turn_counter}: #{winner.name} won 2 cards"
    elsif @turn.type == :war
      @turn.pile_cards
      @turn.award_spoils(winner)
      puts "Turn #{@turn_counter}: WAR - #{winner.name} won 6 cards"
    else
      @turn.mutually_assured_destruction_play
      puts "Turn #{@turn_counter}: *mutually assured destruction* 6 cards removed from play"
    end
  end

  def print_winner_messages
    puts "*~*~*~* #{@turn.winner.name} has won the game! *~*~*~*" if @player1.has_lost? || @player2.has_lost?
  end

  def print_draw_message
    puts "Turn #{@turn_counter}: DRAW"
  end

  def draw?
    if @turn_counter == 5000
      print_draw_message
    end
  end

end
