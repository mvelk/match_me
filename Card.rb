class Card
  attr_reader :value

  def initialize(value)
    @face_up = false
    @value = value
  end

  def ==(card)
    @value == card.value
  end

  def display
    @face_up ? @value : "!"
  end

  def kill_card
    @value = " "
  end

  def reveal
    @face_up = true
  end

  def hide
    @face_up = false
  end

  def to_s
  end

end
