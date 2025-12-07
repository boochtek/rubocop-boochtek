# RuboCop BoochTek

BoochTek's shared RuboCop configuration for Ruby projects.

## Installation

Add to your `Gemfile`:

```ruby
group :development, :test do
  gem "rubocop-boochtek", github: "boochtek/rubocop-boochtek"
end
```

Or install directly:

```bash
gem install rubocop-boochtek
```

## Usage

Create a `.rubocop.yml` in your project root:

```yaml
plugins:
  - rubocop-boochtek
```

That's it! The gem automatically loads `rubocop-rspec` and `rubocop-performance`.

### Overriding Settings

Override any settings in your project's `.rubocop.yml`:

```yaml
plugins:
  - rubocop-boochtek

Layout/LineLength:
  Max: 160

AllCops:
  NewCops: enable
```

## Key Style Decisions

### `private def` (Inline Access Modifiers)

We prefer `private def` over a separate `private` section:

```ruby
# Good
private def my_method
  # ...
end

# Avoided
private

def my_method
  # ...
end
```

This makes it easier to see at a glance which methods are private, and makes moving methods around simpler.

### Semantic Block Delimiters

Use `{}` for blocks that return a value; use `do`/`end` otherwise:

```ruby
# Good - returns a value
names = users.map { |u| u.name }

# Good - side effects only
users.each do |user|
  send_email(user)
end
```

### Double Quotes

We use double quotes by default for strings, as they require fewer changes when you later need interpolation.

### Other Notable Preferences

- Line length: 120 characters
- No frozen string literal comments required
- No documentation required for classes/modules
- `fail` for raising exceptions, `raise` for re-raising
- `%x[]` for shell commands (not backticks)
- Unicode allowed in comments and identifiers

## Adding Custom Cops

Create cops in `lib/rubocop/cop/boochtek/`:

```ruby
# lib/rubocop/cop/boochtek/my_custom_cop.rb
module RuboCop
  module Cop
    module Boochtek
      class MyCustomCop < Base
        MSG = "Custom message here"

        def on_send(node)
          # ...
        end
      end
    end
  end
end
```

Custom cops are auto-loaded when the gem is required.

## Development

```bash
git clone https://github.com/boochtek/rubocop-boochtek
cd rubocop-boochtek
bundle install
bundle exec rake
```

## License

MIT License. See [LICENSE](LICENSE) for details.
