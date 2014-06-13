require_relative 'board.rb'

class Cell
  attr_accessor :x, :y
  attr_reader :status

  def initialize(x=0, y=0)
    @status = false
    @x = x
    @y = y
  end

  def die!
    @status = false
  end

  def live!
    @status = true
  end

  def is_alive?
    @status
  end

  def to_s
    "X: #{self.x}, Y: #{self.Y}, Alive: #{status}"
  end

end
