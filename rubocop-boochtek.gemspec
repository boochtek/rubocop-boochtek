require_relative "lib/rubocop/boochtek/version"

Gem::Specification.new do |spec|
  spec.name = "rubocop-boochtek"
  spec.version = RuboCop::Boochtek::VERSION
  spec.authors = ["Craig Buchek"]
  spec.email = ["craig@boochtek.com"]

  spec.summary = "BoochTek's RuboCop configuration and custom cops"
  spec.description = "Shared RuboCop configuration for BoochTek projects. " \
                     "Includes opinionated defaults and support for custom cops."
  spec.homepage = "https://github.com/boochtek/rubocop-boochtek"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["default_lint_roller_plugin"] = "RuboCop::Boochtek::Plugin"

  spec.files = Dir[
    "lib/**/*",
    "config/**/*",
    ".rubocop.yml",
    "CHANGELOG.md",
    "LICENSE.md",
    "README.md",
    "Rakefile"
  ]
  spec.require_paths = ["lib"]

  spec.add_dependency "lint_roller", "~> 1.1"
  spec.add_dependency "rubocop", "~> 1.72"
  spec.add_dependency "rubocop-performance", "~> 1.20"
  spec.add_dependency "rubocop-rspec", "~> 3.0"
end
