module Kanbanflow
  class Client
    module Tasks
      def get_tasks(params = {})
        get('tasks', params).inject([]) do |tasks, task_set|
          tasks + task_set['tasks'].map { |task| Kanbanflow::Task.new(task, self) }
        end
      end
    end
  end
end
