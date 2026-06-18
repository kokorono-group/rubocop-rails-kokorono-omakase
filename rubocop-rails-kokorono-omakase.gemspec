Gem::Specification.new do |spec|
  spec.name        = "rubocop-rails-kokorono-omakase"
  spec.version     = "0.1.0"
  spec.authors     = [ "Kokorono" ]
  spec.email       = [ "developers@kokorono.co.jp" ]
  spec.summary     = "Kokorono Ruby styling for Rails"
  spec.description = "Inherits rubocop-rails-omakase and layers the Kokorono house style " \
                     "(naming discipline, multiline trailing commas, omit-parentheses) on top."
  spec.homepage    = "https://github.com/kokorono-group/rubocop-rails-kokorono-omakase"
  spec.license     = "MIT"

  # Config-only gem: ships a rubocop.yml, no cop code (mirrors rubocop-rails-omakase).
  spec.files         = [ "rubocop.yml", "README.md", "LICENSE" ]
  spec.require_paths = [ "lib" ]

  spec.add_dependency "rubocop-rails-omakase", ">= 1.1"
end
