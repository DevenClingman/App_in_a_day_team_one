require_relative 'boot'

require 'rails/all'

# require './app/helpers/google_calendar_helper'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TeamOneApp
  class Application < Rails::Application

  end
end
