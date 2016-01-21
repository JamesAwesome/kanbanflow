require 'spec_helper'

describe Kanbanflow::Client do
  subject(:client) { Kanbanflow::Client.new('test_api_token')}
  let(:board_json) { File.read( File.dirname(__FILE__) + '/fixtures/board.json') }

  before do
    stub_request(:get, "https://kanbanflow.com/api/v1/board?apiToken=test_api_token").to_return(body: board_json)
  end

  describe '#get_board' do
    it 'Should return a kanban board' do
      expect(client.get_board).to match(Kanbanflow::Board.new(JSON.parse(board_json)))
    end
  end

  describe '#columns' do
    it 'Should return an array of column structs' do
      expect(client.get_board.columns.all? { |column| column.class == Kanbanflow::Board::Column }).to be true
    end
  end

  describe '#swimlanes' do
    it 'Should return an array of swimlane structs' do
      expect(client.get_board.swimlanes.all? { |swimlane| swimlane.class == Kanbanflow::Board::Swimlane }).to be true
    end
  end
end
