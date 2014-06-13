require 'gosu'
require_relative 'cell.rb'
require_relative 'board.rb'
require_relative 'game.rb'


class GameWindow < Gosu::Window
  def initialize(heigth = 600, width = 800)
    @heigth = heigth
    @width = width
    super width, heigth, false
    self.caption = "Game of Life"
    @background_color = Gosu::Color.new(0xffdedede)
    @alive_cell_color = Gosu::Color.new(0xff000000)
    @dead_cell_color = Gosu::Color.new(0xff676767)


    @columns = width/40
    @rows = heigth/40
    @column_width = width/@columns
    @row_heigth = heigth / @rows
    @board = Board.new(@rows,@columns)
    @game = Game.new(@board)
    @game.board.randomly_populate!


  end

  def update
    @game.tick!
  end

  def draw
    draw_quad(0,0,@background_color,
              width,0,@background_color,
              width, @heigth, @background_color,
              0, @heigth, @background_color)
    @game.board.cells.each_value do |cell|
      color = (@alive_cell_color if cell.is_alive?) || @dead_cell_color
       draw_quad( cell.x * @column_width, cell.y * @row_heigth, color,
                  cell.x * @column_width + (@column_width - 1), cell.y * @row_heigth, color,
                  cell.x * @column_width + (@column_width - 1), cell.y * @row_heigth + (@row_heigth - 1), color,
                  cell.x * @column_width, cell.y * @row_heigth + (@row_heigth - 1), color)

    end
  end

  def needs_cursor?
    true
  end
end

window = GameWindow.new
window.show
