require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)



# using this file migration was successful
# however, with load_env initializer it wasn't working
# and throwing KeyError: key not found: "DB_USERNAME" (KeyError)
# Did you mean?  "USERNAME"
# Uncomment the line 60 of this file, and run `rails db:create db:migrate` to reproduce the error
def temp_loader
  require 'yaml'

  env_file = Rails.root.join('.env.yaml')

  if File.exist?(env_file)
    current_env = Rails.env

    begin
      env_variables = YAML.load_file(env_file)[current_env]

      unless env_variables
        raise StandardError.new("Environment configuration for #{current_env} not found in #{env_file}.")
      end

      env_variables.each do |key, value|
        ENV[key] = value.to_s if value.present?
      end
    rescue StandardError => e
      raise StandardError.new("Error loading environment variables: #{e.message}")
    end
  else
    raise StandardError.new("#{env_file} not found. Ask the origin to provide it.")
  end
end


module SocialApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    temp_loader
  end
end
