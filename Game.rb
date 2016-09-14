require_relative 'Board'
require_relative 'Card'
require_relative 'Human'
require_relative 'Computer'

class Game
  def initialize(player, turns_left = 20)
    @board = Board.new
    @player = player
    @turns_left = turns_left
  end

  def play
    @board.populate
    until over?
      p "TURN NUMBER: #{@turns_left}"
      play_turn
      @turns_left -= 1
    end
    end_game
  end

  def play_turn
    guess1 = guess
    guess2 = guess
    @board.render
    sleep(2)
    # system("clear")
    check_guess(guess1, guess2)
    @player.clear_guesses
  end

  def check_guess(guess1, guess2)
    if @board.cards_match?(guess1, guess2)
      @board.kill_card(*guess1)
      @board.kill_card(*guess2)
      @player.receive_match(guess1, guess2)
    else
      @player.receive_revealed_card(guess1, @board[*guess1].value)
      @player.receive_revealed_card(guess2, @board[*guess2].value)
      @board.hide(*guess1)
      @board.hide(*guess2)
    end
  end

  def guess
    row, col = @player.get_guess(@board)
    @board.reveal(row, col)
    [row,col]
  end

  def over?
    @board.won? || @turns_left == 0
  end

  def end_game
    p @board.won? ? "You win!" : "You suck!"
  end
end

if __FILE__ == $PROGRAM_NAME
  player = Computer.new("Mike")
  game = Game.new(player)
  game.play
end
