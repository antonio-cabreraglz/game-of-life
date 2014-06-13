require_relative 'cell.rb'

class Board
  attr_accessor :cells, :rows, :columns

  def initialize(rows=5,columns=5)

    @rows = rows
    @columns = columns
    @cells = Hash.new
    (0..columns-1).each do |column|
      (0..rows-1).each do |row|
        @cells[[column, row]] = Cell.new(column, row)
      end
    end


  end

  def neighbours_around_cell(cell)
    return [] if !cell
    neighbours = []

    #North
    neighbour = self.cells[[cell.x, cell.y - 1]]
    neighbours << neighbour if neighbour && neighbour.is_alive?

    #East
    neighbour = self.cells[[cell.x + 1, cell.y]]
    neighbours << neighbour if neighbour && neighbour.is_alive?

    #North East
    neighbour = self.cells[[cell.x + 1, cell.y - 1]]
    neighbours << neighbour if neighbour && neighbour.is_alive?

    #South
    neighbour = self.cells[[cell.x, cell.y + 1]]
    neighbours << neighbour if neighbour && neighbour.is_alive?

    #South East
    neighbour = self.cells[[cell.x + 1, cell.y + 1]]
    neighbours << neighbour if neighbour && neighbour.is_alive?

    #West
    neighbour = self.cells[[cell.x - 1, cell.y]]
    neighbours << neighbour if neighbour && neighbour.is_alive?

    #North West
    neighbour = self.cells[[cell.x - 1, cell.y - 1]]
    neighbours << neighbour if neighbour && neighbour.is_alive?

    #North West
    neighbour = self.cells[[cell.x - 1, cell.y + 1]]
    neighbours << neighbour if neighbour && neighbour.is_alive?


    neighbours
  end

end
