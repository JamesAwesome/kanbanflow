require 'rest-client'
require 'kanbanflow/client/board'
require 'kanbanflow/client/tasks'
require 'kanbanflow/user'
require 'active_support/all'

module Kanbanflow
  class Client
    API_URL = 'https://kanbanflow.com/api/v1'

    attr_accessor :api_token

    def initialize(api_token)
      @api_token = api_token
    end

    include Kanbanflow::Client::Board
    include Kanbanflow::Client::Tasks

    def users(params = {})
      @users ||= get('users', params).map { |user| Kanbanflow::User.new(user) }
    end

    def get(location, params = {})
      params = { apiToken: api_token }.merge(params)
      JSON.parse(RestClient.get "#{API_URL}/#{location}", { params: params })
    end
  end
end
