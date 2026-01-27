# frozen_string_literal: true

module RuboCop
  module Cop
    module Boochtek
      # Removes blank lines between consecutive endless (one-liner) method definitions.
      #
      # This cop allows grouping related endless methods together without
      # the blank line that `Layout/EmptyLineBetweenDefs` normally requires.
      #
      # @example
      #   # bad
      #   def foo = @foo
      #
      #   def bar = @bar
      #
      #   # good
      #   def foo = @foo
      #   def bar = @bar
      #
      #   # good - blank line between endless and regular method is fine
      #   def foo = @foo
      #
      #   def bar
      #     @bar
      #   end
      #
      class CompactEndlessMethods < Base
        extend AutoCorrector

        MSG = "Remove blank line between consecutive endless methods."

        def on_def(node)
          check_endless_method(node)
        end

        def on_defs(node)
          check_endless_method(node)
        end

        private

        def check_endless_method(node)
          return unless endless_def?(node)

          prev_sibling = previous_sibling_def(node)
          return unless prev_sibling
          return unless endless_def?(prev_sibling)

          blank_lines = blank_lines_between(prev_sibling, node)
          return if blank_lines.empty?

          add_offense(node) do |corrector|
            blank_lines.each do |line_range|
              corrector.remove(line_range)
            end
          end
        end

        def endless_def?(node)
          return false unless node&.def_type? || node&.defs_type?

          node.endless?
        end

        def previous_sibling_def(node)
          return nil unless node.parent

          siblings = node.parent.children
          index = siblings.index(node)
          return nil if index.nil? || index.zero?

          prev = siblings[index - 1]
          # In Ruby 4.0/Prism, siblings may include non-node elements (e.g., Symbols).
          # Guard against calling AST methods on non-node types.
          return nil unless prev.is_a?(RuboCop::AST::Node)

          prev if prev.def_type? || prev.defs_type?
        end

        def blank_lines_between(prev_node, current_node)
          prev_end_line = prev_node.loc.expression.end.line
          current_start_line = current_node.loc.expression.line

          return [] if current_start_line <= prev_end_line + 1

          blank_line_numbers = ((prev_end_line + 1)...current_start_line).to_a
          return [] if blank_line_numbers.empty?

          blank_line_numbers.map do |line_num|
            line_begin = processed_source.buffer.line_range(line_num)
            # Include the newline character
            range_with_newline(line_begin)
          end
        end

        def range_with_newline(range)
          Parser::Source::Range.new(
            range.source_buffer,
            range.begin_pos,
            range.end_pos + 1
          )
        end
      end
    end
  end
end
