class Human

  def initialize(name)
    @name = name
  end

  def get_guess(board)
    board.render
    puts "#{@name}, give a guess. Format should be row,col."
    row, col = nil, nil
    loop do
      row, col = gets.chomp.split(",").map(&:to_i)
      break if valid_move?(row, col, board)
      puts "Invalid move. Please try again. Format should be row,col."
    end
    [row,col]
  end

  def valid_move?(row,col,board)
    p (0..board.row_len - 1).to_a
    return false unless (0..board.row_len - 1).to_a.include?(row)
    return false unless (0..board.col_len - 1).to_a.include?(col)
    return false if board[row, col].value == " "
    true
  end

  def receive_match
  end

  def receive_revealed_cards
  end

  def clear_guesses
  end
end
