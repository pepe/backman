ENV['RACK_ENV'] = 'test' unless defined?(RACK_ENV)

require 'bundler/setup'
require 'rack/test'

require File.expand_path(File.dirname(__FILE__) + '/../lib/backman/api')

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

ENV['client_id'] = 'abcd'
ENV['state'] = 'abcd'
ENV['redirect_uri'] =  'http://backman.io/authorized'

def app
  Backman::API
end
