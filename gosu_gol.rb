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
    @cell_color = Gosu::Color.new(0xff000000)

    @columns = width/10
    @column_width = @columns
    @rows = heigth/10
    @row_heigth = heigth / @rows
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
      color = (@cell_color if cell.is_alive?) || @background_color
      draw_quad(cell.x * @column_width, cell.y * @row_heigth,color,
                cell.x * @column_width + @column_width, cell.y * @row_heigth,color,
                cell.x * @column_width + @column_width, cell.y * @row_heigth + @row_heigth, color,
                cell.x * @column_width, cell.y * @row_heigth + @row_heigth, color)

    end
  end

  def needs_cursor?
    true
  end
end

window = GameWindow.new
window.show
