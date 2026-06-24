# rubocop-rails-kokorono-omakase

Kokorono's shared RuboCop configuration. It inherits [rubocop-rails-omakase](https://github.com/rails/rubocop-rails-omakase) and layers a thin house-style on top, so every Kokorono Rails app shares one source of truth instead of copy-pasted `.rubocop.yml` files.

## What it layers on omakase

- **Naming discipline** — omakase turns the whole `Naming` department off; this re-enables the cops the team keeps: `@_foo` memoization (`Naming/MemoizedInstanceVariableName`), snake_case methods and variables, CamelCase classes/modules, constant naming, and predicate naming.
- **Redundant directive cleanup** — omakase turns the whole `Lint` department off; this re-enables the cops that flag stale `# rubocop:disable` / `# rubocop:enable` comments (`Lint/RedundantCopDisableDirective`, `Lint/RedundantCopEnableDirective`), both autocorrectable.
- **Trailing commas** in multiline arrays, hashes, and arguments (omakase enforces the opposite).
- **Omit parentheses** for method calls with arguments (`Style/MethodCallWithArgsParentheses`), with `Style/SuperWithArgsParentheses` disabled to avoid the clash.

Everything else is stock omakase.

## Installation

Add to the app's `Gemfile` (git-sourced, no version pin — Dependabot raises the bump PRs):

```ruby
group :development, :test do
  gem "rubocop-rails-kokorono-omakase", github: "kokorono-group/rubocop-rails-kokorono-omakase", require: false
end
```

## Usage

Replace the app's `.rubocop.yml` with a one-line inherit:

```yaml
inherit_gem: { rubocop-rails-kokorono-omakase: rubocop.yml }
```

A repo with a local custom cop (e.g. `oyatoko-crm`'s `Kokosapo/DraftScope`) keeps its `require` and enable on top of that line.

## Development

```bash
bin/setup        # bundle install
bundle exec rspec    # config-behavior spec (asserts the layered rules fire)
bundle exec rubocop  # dogfood the config on this repo
```
