module Kanbanflow
  class Board
    attr_reader :board_json

    def initialize(board_json)
      @board_json = board_json
    end

    Column   = Struct.new(:id, :name)
    Swimlane = Struct.new(:id, :name)

    def id
      board_json['_id']
    end

    def name
      board_json['name']
    end

    def columns
      @columns ||= board_json['columns'].map { |column| Column.new(column['uniqueId'], column['name']) }
    end

    def swimlanes
      @swimlanes ||= board_json['swimlanes'].map { |swimlane| Swimlane.new(swimlane['uniqueId'], swimlane['name']) }
    end

    def ==(other)
      id == other.id
    end
  end
end
