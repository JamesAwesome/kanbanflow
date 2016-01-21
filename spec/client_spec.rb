require 'spec_helper'

describe Kanbanflow::Client do
  subject(:client) { Kanbanflow::Client.new('test_api_token')}
  let(:board_json) { File.read( File.dirname(__FILE__) + '/fixtures/board.json') }
  let(:tasks_json) { File.read( File.dirname(__FILE__) + '/fixtures/tasks.json') }

  before do
    stub_request(:get, "https://kanbanflow.com/api/v1/board?apiToken=test_api_token").to_return(body: board_json)
    stub_request(:get, "https://kanbanflow.com/api/v1/tasks?apiToken=test_api_token").to_return(body: tasks_json)
  end

  describe '#get_board' do
    it 'Should return a kanban board' do
      expect(client.get_board).to match(Kanbanflow::Board.new(JSON.parse(board_json)))
    end
  end

  describe '#get_tasks' do
    it 'Should return a single array with all task objects' do
      expect(client.get_tasks.all? { |task| task.class == Kanbanflow::Task }).to be true
    end
  end
end
