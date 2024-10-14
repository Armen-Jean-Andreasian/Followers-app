require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

def load_env_variables
  env_file = Rails.root.join(".env.#{Rails.env}")

  if File.exist?(env_file)
    begin
      File.readlines(env_file).each do |line|
        next if line.strip.empty? || line.start_with?('#')
        key, value = line.split('=', 2).map(&:strip)
        ENV[key] = value if value.present?
      end
    rescue StandardError => e
      raise StandardError.new("Error loading environment variables: #{e.message}")
    end
  else
    raise StandardError.new("#{env_file} not found. Please provide it.")
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
    load_env_variables
  end
end
