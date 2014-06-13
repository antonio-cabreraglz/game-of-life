require 'rspec'
require_relative 'cell.rb'
require_relative 'board.rb'
require_relative 'game.rb'


describe "Game of Life" do

  let(:board) { Board.new }

  context "Utility board methods" do
    subject {Board.new}
    it "should expect a new board object" do
      expect(subject).to be_a Board
    end

    it "should have proper methods" do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:columns)
      expect(subject).to respond_to(:cells)
      expect(subject).to respond_to(:neighbours_around_cell).with(1).argument
    end

    it "should create a proper grid" do
      expect(subject.cells).to be_a Hash
      expect(subject.cells[[subject.columns,subject.rows]]).to be nil
      (0..subject.columns-1).each do |column|
        (0..subject.rows-1).each do |row|
          expect(subject.cells[[column,row]]).to be_a(Cell)
        end
      end
    end

    it "should detect a neighbour to the North" do
      subject.cells[[1,0]].live!
      subject.cells[[1,1]].live!

      expect(subject.neighbours_around_cell(subject.cells[[1,1]]).count).to be 1
    end

    it "should detect a neighbour to the East" do
      subject.cells[[2,1]].live!
      subject.cells[[1,1]].live!

      expect(subject.neighbours_around_cell(subject.cells[[1,1]]).count).to be 1
    end

    it "should detect a neighbour to the North East" do
      subject.cells[[2,0]].live!
      subject.cells[[1,1]].live!
      expect(subject.neighbours_around_cell(subject.cells[[1,1]]).count).to be 1
    end

    it "should detect a neighbour to the South" do
      subject.cells[[1,2]].live!
      subject.cells[[1,1]].live!
      expect(subject.neighbours_around_cell(subject.cells[[1,1]]).count).to be 1
    end

    it "should detect a neighbour to the South East" do
      subject.cells[[2,2]].live!
      subject.cells[[1,1]].live!
      expect(subject.neighbours_around_cell(subject.cells[[1,1]]).count).to be 1
    end

    it "should detect a neighbour to the West" do
      subject.cells[[0,1]].live!
      subject.cells[[1,1]].live!
      expect(subject.neighbours_around_cell(subject.cells[[1,1]]).count).to be 1
    end

    it "should detect a neighbour to the North West" do
      subject.cells[[0,0]].live!
      subject.cells[[1,1]].live!
      expect(subject.neighbours_around_cell(subject.cells[[1,1]]).count).to be 1
    end

    it "should detect a neighbour to the South West" do
      subject.cells[[0,2]].live!
      subject.cells[[1,1]].live!
      expect(subject.neighbours_around_cell(subject.cells[[1,1]]).count).to be 1
    end

    it "North wall test" do
      subject.cells[[1,0]].live!
      expect(subject.neighbours_around_cell(subject.cells[[1,0]]).count).to be 0
    end

    it "East wall test" do
      subject.cells[[4,1]].live!
      expect(subject.neighbours_around_cell(subject.cells[[4,1]]).count).to be 0
    end

    it "South wall test" do
      subject.cells[[1,4]].live!
      expect(subject.neighbours_around_cell(subject.cells[[1,4]]).count).to be 0
    end

    it "West wall test" do
      subject.cells[[0,1]].live!
      expect(subject.neighbours_around_cell(subject.cells[[0,1]]).count).to be 0
    end

  end

  context "Cell" do
    subject { Cell.new }
    it "should create a cell object" do
      expect(subject).to be_a Cell
    end

    it "should have proper methods" do
      expect(subject).to respond_to :status
      expect(subject).to respond_to :x
      expect(subject).to respond_to :y
      expect(subject).to respond_to :die!
      expect(subject).to respond_to :live!
      expect(subject).to respond_to :is_alive?
    end

    it "should initialize properly" do
      expect(subject.status).to be false
      expect(subject.x).to be 0
      expect(subject.y).to be 0
    end

    it "should die" do
      expect(subject.die!).to be false
    end

    it "should live" do
      expect(subject.live!).to be true
    end

  end

  context "Game" do
    subject { Game.new }

    it "should create a new Game object" do
      expect(subject).to be_a Game
    end

    it "should have the following methods" do
      expect(subject).to respond_to :board
      expect(subject).to respond_to :seeds
    end

    it "should initialize properly" do
      expect(subject.board).to be_a Board
      expect(subject.seeds).to be_an Array
    end

    it "should sow the seeds" do
      game = Game.new(board, [[1,2], [2,2]])
      expect(board.cells[[1,2]].is_alive?).to be true
      expect(board.cells[[2,2]].is_alive?).to be true
    end

  end

  context "Rules" do
    let(:game) { Game.new }
    context "Rule #1: Any live cell with fewer than two live neighbours dies,
     as if caused by under-population." do
       it "should let a cell die if it has less than two neighbours" do
         game = Game.new(board, [[1,2],[2,2]])
         expect(board.cells[[1,2]].is_alive?).to be true
         game.tick!
         expect(board.cells[[1,2]].is_alive?).to be false
         expect(board.cells[[2,2]].is_alive?).to be false
       end
    end

    context "Rule #2 Any live cell with two or three live neighbours lives on to the next generation." do
      it "cell in the middle should live" do
        game = Game.new(board, [[1,0],[1,1], [1,2]])
        game.tick!
        expect(board.cells[[1,1]].is_alive?).to be true
        expect(board.cells[[1,2]].is_alive?).to be false
      end
    end

    context "Rule #3 Any live cell with more than three live neighbours dies, as if by overcrowding." do
      it "1,1 cell should die" do
        game = Game.new(board, [[0,1],[1,1],[2,1], [1,2], [2,2]])
        game.tick!
        expect(board.cells[[1,1]].is_alive?).to be false
        expect(board.cells[[1,2]].is_alive?).to be false
      end
    end

  context "Rule #4" do
    it "should revive two cells" do
      game = Game.new(board, [[0,1],[1,1],[2,1]])
      game.tick!
      expect(board.cells[[1,0]].is_alive?).to be true
      expect(board.cells[[1,2]].is_alive?).to be true
    end
  end

  end

end
