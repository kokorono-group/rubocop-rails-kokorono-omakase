source "https://rubygems.org"

# Brings in the gem's own runtime dependency (rubocop-rails-omakase, and
# transitively rubocop / rubocop-rails / rubocop-performance).
gemspec

# Runs spec/config_spec.rb, which lints snippets with the shipped rubocop.yml
# and asserts which cops fire.
gem "rspec", require: false
