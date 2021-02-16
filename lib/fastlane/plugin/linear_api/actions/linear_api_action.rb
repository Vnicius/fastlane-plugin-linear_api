require 'fastlane/action'
require_relative '../helper/linear_api_helper'
require 'faraday'

module Fastlane
  module Actions
    class LinearApiAction < Action
      def self.run(params)
        parsed_query = params[:query].gsub(/\s+/, " ").gsub(/\"/, "\\\"").strip()

        response = Faraday.post('https://api.linear.app/graphql', 
          '{ "query": "%s" }' % [parsed_query], 
          { 
            'Content-Type' => 'application/json', 
            'Authorization' => params[:api_key] 
          }
        )
        return JSON.parse(response.body)["data"]
      end

      def self.description
        "Provide an interface to access the Linear API"
      end

      def self.authors
        ["vnicius"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "This plugin will send your query to the Linear - Issue Tracking GraphQL API and return the result json"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :api_key,
                                  env_name: "LINEAR_API_KEY",
                               description: "Your personal auth key to access the API",
                                  optional: false,
                                      type: String),
          
          FastlaneCore::ConfigItem.new(key: :query,
                                  env_name: "LINEAR_API_QUERY",
                               description: "The GraphQL query to the api (without 'query')",
                                  optional: false,
                                      type: String)                                      
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end

      def self.example_code
        
      end
    end
  end
end
