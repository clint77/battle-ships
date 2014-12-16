require 'board'

describe Board do
  BOAT = 3
  WATER = 0
  SHOT = 1

  let(:board){Board.new(:size => 2)}
  let(:ship){double :ship}
  
  it 'should have a size' do
    expect(board.size).not_to eq nil
  end

  it 'should initialize an empty board' do
    expect(board.show).to eq [[WATER,WATER,WATER],[WATER,WATER,WATER],[WATER,WATER,WATER]]
  end

  it 'should be able to be shot at' do
    board.receive_shot(1,1) #B2
    expect(board.show).to eq [[WATER,WATER,WATER],[WATER,SHOT,WATER],[WATER,WATER,WATER]]
  end

  it 'should not be able to take shots on negative coordinates' do
    board.receive_shot(1,-1) 
    expect(board.show).to eq [[WATER,WATER,WATER],[WATER,WATER,WATER],[WATER,WATER,WATER]]
  end

  it 'should not be able to take shots outside the boundaries' do
    board.receive_shot(1,40) 
    expect(board.show).to eq [[WATER,WATER,WATER],[WATER,WATER,WATER],[WATER,WATER,WATER]]
  end

  it 'should accept shots on the boundaries' do
    board.receive_shot(0,0) 
    expect(board.show).to eq [[SHOT,WATER,WATER],[WATER,WATER,WATER],[WATER,WATER,WATER]]
    board.receive_shot(2,2) 
    expect(board.show).to eq [[SHOT,WATER,WATER],[WATER,WATER,WATER],[WATER,WATER,SHOT]]
  end


  it 'should not add a ship outside the board' do
    allow(ship).to receive(:coordinates).and_return([[0,0],[1,0],[30,0]])
    # expect(board.add_ship(ship)).to raise_error(RuntimeError, 'Coordinates are invalid')
    expect(board.add_ship(ship)).to eq false
  end

  it 'should not add a ship on a position that is already taken' do
    allow(ship).to receive(:coordinates).and_return([[0,0],[0,1],[0,2]])
    # expect(board.add_ship(ship)).to raise_error(RuntimeError, 'Coordinates are invalid')
    board.add_ship(ship)
    expect(board.add_ship(ship)).to eq false
  end


  it 'should have a list with ships' do
    allow(ship).to receive(:coordinates).and_return([[0,0],[1,0],[2,0]])
    board.add_ship(ship)
    expect(board.ships.count).to eq 1
    expect(board.show).to eq [[BOAT,WATER,WATER],[BOAT,WATER,WATER],[BOAT,WATER,WATER]]
  end



end
