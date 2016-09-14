class Computer
  def initialize(name)
    @name = name
    @guess1 = nil
    @guess2 = nil
    make_fake_board
  end

  def clear_guesses
    @guess1 = nil
    @guess2 = nil
  end

  def make_fake_board
    @fake_board = Board.new
    @fake_board.grid.each do |row|
      row.map! { "!" }
    end
  end

  def get_guess(board)
    board.render
    puts "#{@name}, give a guess. Format should be row,col."
    guess = pick_coords
    @guess1.nil? ? @guess1 = guess : @guess2 = guess
    guess
  end

  def pick_coords
    match_positions = find_match
    unless match_positions.nil?
      return @guess1.nil? ? match_positions[0] : match_positions[1]
    end
    find_unknown
  end

  def find_match
    positions = find_matched_letter_positions
    positions.each do |_, position|
      return position if position.length == 2
    end
    nil
  end

  def find_matched_letter_positions
    positions = Hash.new { |hash, key| hash[key] = [] }
    @fake_board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |pos, col_idx|
        unless pos == "!" || pos == " "
          positions[pos] << [row_idx, col_idx]
        end
      end
    end
    positions
  end

  def find_unknown
    @fake_board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |pos, col_idx|
        return [row_idx, col_idx] if pos == "!" && [row_idx, col_idx] != @guess1
      end
    end
    raise "You have something odd going on. Talk to your doctor."
  end

  def receive_match(guess1, guess2)
    @fake_board[*guess1] = " "
    @fake_board[*guess2] = " "
  end

  def receive_revealed_card(guess1, value)
    @fake_board[*guess1] = value
  end

end
