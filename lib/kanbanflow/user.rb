module Kanbanflow
  class User
    attr_accessor :user_json

    def initialize(user_json)
      @user_json = user_json
    end

    def id
      user_json['_id']
    end

    %w( fullName email _id ).each do |field|
      define_method(field.underscore) { user_json[field] }
    end
    alias_method :_id, :id
    alias_method :unique_id, :id
  end
end
