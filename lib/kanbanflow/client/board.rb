module Kanbanflow
  class Client
    module Board
      def get_board
        @board ||= Kanbanflow::Board.new(get('board'))
      end
    end
  end
end
