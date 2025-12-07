# frozen_string_literal: true

require "lint_roller"
require_relative "version"

# Load custom cops
cop_dir = File.expand_path("../cop/boochtek", __dir__)
if File.directory?(cop_dir)
  Dir.glob(File.join(cop_dir, "**", "*.rb")).each do |cop_file|
    require cop_file
  end
end

module RuboCop
  module Boochtek
    class Plugin < LintRoller::Plugin
      def about
        LintRoller::About.new(
          name: "rubocop-boochtek",
          version: VERSION,
          homepage: "https://github.com/boochtek/rubocop-boochtek",
          description: "BoochTek's RuboCop configuration and custom cops"
        )
      end

      def supported?(context)
        context.engine == :rubocop
      end

      def rules(_context)
        LintRoller::Rules.new(
          type: :path,
          config_format: :rubocop,
          value: config_path
        )
      end

      private def config_path
        File.expand_path("../../../config/default.yml", __dir__)
      end
    end
  end
end
