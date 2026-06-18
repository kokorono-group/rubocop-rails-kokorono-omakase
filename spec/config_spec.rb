require "spec_helper"
require "open3"
require "json"

# Behavior spec for the shipped rubocop.yml. Each example runs RuboCop with the
# gem's config against a source snippet (via --stdin) and asserts which cops do
# and do not fire. This proves the layered Kokorono rules are active on top of
# omakase, and guards the omit-parens / super clash.
RSpec.describe "rubocop-rails-kokorono-omakase config" do
  config_path = File.expand_path("../rubocop.yml", __dir__)

  # Returns the set of cop names RuboCop reports for `source`. The filename is
  # under app/ so omakase's path-scoped Style/StringLiterals Include applies.
  cops_for = lambda do |source, filename = "app/models/example.rb"|
    stdout, stderr, status = Open3.capture3(
      "bundle", "exec", "rubocop",
      "--config", config_path,
      "--format", "json",
      "--stdin", filename,
      stdin_data: source
    )
    raise "rubocop failed to run: #{stderr}" if stdout.strip.empty?

    JSON.parse(stdout)
      .fetch("files")
      .flat_map { |file| file.fetch("offenses") }
      .map { |offense| offense.fetch("cop_name") }
      .uniq
  end

  it "loads cleanly (no config errors)" do
    _out, err, status = Open3.capture3(
      "bundle", "exec", "rubocop", "--config", config_path, "--show-cops"
    )
    expect(status).to be_success, err
  end

  it "enforces double quotes from omakase" do
    expect(cops_for.call("x = 'hello'\n")).to include("Style/StringLiterals")
  end

  it "requires a leading underscore on memoized ivars" do
    src = "def value\n  @value ||= compute\nend\n"
    expect(cops_for.call(src)).to include("Naming/MemoizedInstanceVariableName")
  end

  it "enforces snake_case method names" do
    expect(cops_for.call("def fooBar\nend\n")).to include("Naming/MethodName")
  end

  it "flags non-CamelCase class names" do
    expect(cops_for.call("class Foo_Bar\nend\n")).to include("Naming/ClassAndModuleCamelCase")
  end

  it "requires trailing commas in multiline arrays" do
    src = "x = [\n  1,\n  2\n]\n"
    expect(cops_for.call(src)).to include("Style/TrailingCommaInArrayLiteral")
  end

  it "enforces omit_parentheses on method calls with args" do
    src = "def run(value)\n  save(value)\nend\n"
    expect(cops_for.call(src)).to include("Style/MethodCallWithArgsParentheses")
  end

  it "flags is_-prefixed predicate methods" do
    src = "def is_active\n  true\nend\n"
    expect(cops_for.call(src)).to include("Naming/PredicatePrefix")
  end

  it "does not force parentheses on super (clash guard)" do
    src = "def run(value)\n  super(value)\nend\n"
    expect(cops_for.call(src)).not_to include("Style/SuperWithArgsParentheses")
  end
end
