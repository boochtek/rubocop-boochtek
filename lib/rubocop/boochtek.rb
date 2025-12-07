# frozen_string_literal: true

require_relative "boochtek/version"
require_relative "boochtek/plugin"

module RuboCop
  module Boochtek
    class Error < StandardError; end

    # Auto-discover and load custom cops from lib/rubocop/cop/boochtek/
    COP_DIR = File.expand_path("cop/boochtek", __dir__)
    if File.directory?(COP_DIR)
      Dir.glob(File.join(COP_DIR, "**", "*.rb")).each do |cop_file|
        require cop_file
      end
    end
  end
end
