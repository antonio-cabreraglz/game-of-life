require 'gosu'
require_relative 'cell.rb'
require_relative 'board.rb'
require_relative 'game.rb'


class GameWindow < Gosu::Window
  def initialize(heigth = 480, width = 640)
    @heigth = heigth
    @width = width
    super width, heigth, false
    self.caption = "Game of Life"
    @background_color = Gosu::Color.new(0xffdedede)

    @columns = width/10
    @rows = heigth/10
    @board = Board.new(@rows,@columns)
    @game = Game.new(@board)
    @game.board.randomly_populate!


  end

  def update
  end

  def draw
    draw_quad(0,0,@background_color,
              width,0,@background_color,
              width, @heigth, @background_color,
              0, @heigth, @background_color)
    @game.board.cells.each_value do |cell|

    end
  end

  def needs_cursor?
    true
  end
end

window = GameWindow.new
window.show
