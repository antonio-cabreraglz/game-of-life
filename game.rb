require_relative 'board.rb'
require_relative 'cell.rb'

class Game
  attr_accessor :board, :seeds

  def initialize(board = Board.new, seeds=[])
    @board = board
    @seeds = seeds
    seeds.each do |seed|
      board.cells[seed].live!
    end
  end

  def tick!
    live_cells = []
    dead_cells = []
    board.cells.each do |key, cell|
      #Rule 1
      dead_cells << key if cell.is_alive? && board.neighbours_around_cell(cell).count < 2
      #Rule 2
      live_cells << key if cell.is_alive? && ([2,3].include? board.neighbours_around_cell(cell).count)
      #Rule 3
      dead_cells << key if cell.is_alive? && board.neighbours_around_cell(cell).count > 3
      #Rule 4
      live_cells << key if !cell.is_alive? && board.neighbours_around_cell(cell).count == 3
    end

    live_cells.each do |key|
      board.cells[key].live!
    end

    dead_cells.each do |key|

      board.cells[key].die!
    end

  end

end
