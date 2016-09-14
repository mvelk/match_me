class Board
  attr_reader :row_len, :col_len, :grid

  def initialize
    @grid = Array.new(4) { Array.new(4,nil) }
    @values = %w(a a b b c c d d e e f f g g h h).shuffle
    @row_len = @grid.length
    @col_len = @grid[0].length
  end

  def []=(row, col, val)
    @grid[row][col] = val
  end

  def [](row, col)
    @grid[row][col]
  end

  def populate
    @grid.each do |row|
      row.map! { Card.new(@values.pop) }
    end
  end

  def cards_match?(guess1, guess2)
    self[*guess1] == self[*guess2]
  end

  def render
    @grid.each do |row|
      row_arr = []
      row.each { |card| row_arr << card.display }
      p row_arr.join(" ")
    end
  end

  def won?
    @grid.all? do |row|
      row.all? { |pos| pos.value == " "}
    end
  end

  def kill_card(row, col)
    self[row, col].kill_card
  end

  def reveal(row, col)
    self[row, col].reveal
  end

  def hide(row, col)
    self[row, col].hide
  end

end
