require 'active_support/all'

module Kanbanflow
  class Task
    attr_reader :task_json, :client

    def initialize(task_json, client)
      @task_json = task_json
      @client = client
    end

    %w( _id name columnId swimlaneId description color responsibleUserId groupingDate ).each do |field|
      define_method(field.underscore) { task_json.fetch(field, '') }
    end
    alias_method :id, :_id
    alias_method :unique_id, :_id

    %w( totalSecondsEstimate totalSecondsSpent ).each do |field|
      define_method(field.underscore) { task_json.fetch(field, 0) }
    end

    %w( subtasks labels dates collaborators comments ).each do |meth|
      define_method(meth) do
        instance_variable_set("@#{meth}", instance_variable_get("@#{meth}") || client.get("tasks/#{id}/#{meth}"))
      end
    end

    def number
      task_json.fetch('number', {})
    end

    def title
      number.fetch('prefix', '') + String(number.fetch('value', '')) + ": #{name}"
    end
    alias_method :full_name, :title

    def swimlane_name
      @swimlane_name ||= client.get_board.swimlanes.find { |swimlane| swimlane.id == swimlane_id }
    end

    def has_owner?
      !owner.nil?
    end

    def owner
      @owner ||= client.users.find { |user| user.id == responsible_user_id }
    end

    def ==(other)
      id == other.id
    end
  end
end
