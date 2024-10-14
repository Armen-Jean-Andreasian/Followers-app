# Environment Variables Loader
#
# This script loads environment variables from a YAML configuration file
# based on the current Rails environment (development, test, or production).
#
# The expected structure of the `.env.yaml` file is:
#
# development:
#   DB_USERNAME:
#   DB_PASSWORD:
#   DB_HOST:
#   DB_PORT:
#
# test:
#   DB_USERNAME:
#   DB_PASSWORD:
#   DB_HOST:
#   DB_PORT:
#
# production:
#   DB_USERNAME:
#   DB_PASSWORD:
#   DB_HOST:
#   DB_PORT:
#
# The script raises exceptions if:
# - The `.env.yaml` file is not found.
# - The current environment configuration is missing.
# - There is a syntax error in the YAML file.
#
# Usage:
# To use this script, place it in an initializer within a Rails application,
# for example, in `config/initializers/load_env_variables.rb`. This will
# ensure that the environment variables are loaded when the application starts.

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
