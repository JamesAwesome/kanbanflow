require 'spec_helper'

describe Kanbanflow::Board do
  let(:board_json) { JSON.parse(File.read( File.dirname(__FILE__) + '/fixtures/board.json')) }
  subject(:board) { Kanbanflow::Board.new(board_json) }

  describe '#id' do
    it 'Should Return the board ID' do
      expect(board.id).to match board_json['_id']
    end
  end

  describe '#name' do
    it 'Should Return the board Name' do
      expect(board.name).to match board_json['name']
    end
  end

  describe '#==' do
    let(:same_board) { Kanbanflow::Board.new(board_json) }
    let(:different_board_json) { board_json['_id'] = 'foo' }
    let(:different_board) { Kanbanflow::Board.new(different_board_json) }

    it 'Returns true if the board ID matches on both boards' do
      expect(board == same_board).to be true
    end

    it 'Returns false if the board ID does not match on both boards' do
      expect(board == different_board).to be false
    end
  end

  describe Kanbanflow::Board::Column do
    subject(:column) { Kanbanflow::Board::Column.new(board_json['columns'][0]['uniqueId'], board_json['columns'][0]['name']) }
    describe '#id' do
      it 'Should Return the Column Id' do
        expect(column.id).to match(board_json['columns'][0]['uniqueId'])
      end
    end
    describe '#name' do
      it 'Should Return the Column Name' do
        expect(column.name).to match(board_json['columns'][0]['name'])
      end
    end
  end

  describe Kanbanflow::Board::Swimlane do
    subject(:swimlane) { Kanbanflow::Board::Column.new(board_json['swimlanes'][0]['uniqueId'], board_json['swimlanes'][0]['name']) }
    describe '#id' do
      it 'Should Return the Swimlane Id' do
        expect(swimlane.id).to match(board_json['swimlanes'][0]['uniqueId'])
      end
    end
    describe '#name' do
      it 'Should Return the Swimlane Name' do
        expect(swimlane.name).to match(board_json['swimlanes'][0]['name'])
      end
    end
  end
end
