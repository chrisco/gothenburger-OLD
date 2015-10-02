ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'lib/gb.rb')

require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'coveralls'
require 'simplecov'
require 'dm-rspec'
require 'database_cleaner'

SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
]
Coveralls.wear!

Capybara.app = Gothenburger

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include DataMapper::Matchers
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end


  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  #Commented out this until database tables are created.
  # config.before(:suite) do
  #   DatabaseCleaner.strategy = :transaction
  #   DatabaseCleaner.clean_with(:truncation)
  # end
  #
  # config.before(:each) do
  #   DatabaseCleaner.start
  # end
  #
  # config.after(:each) do
  #   DatabaseCleaner.clean
  # end

end
