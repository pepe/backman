ENV['RACK_ENV'] = 'test' unless defined?(RACK_ENV)

require 'rack/test'
require 'dotenv'

# Require application code
require File.expand_path(File.dirname(__FILE__) + '/../lib/backman/api')

# Configure rspec
RSpec.configure do |config|
  # TODO: include only for web tests
  config.include Rack::Test::Methods

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect

    mocks.verify_partial_doubles = true
  end
end

# set up ENV
Dotenv::Environment.new('spec/test.env')

# app for the rack-test
def app
  Backman::API
end
