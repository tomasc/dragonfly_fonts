require 'open3'

module DragonflyFonts
  module Analysers
    class OtSanitise
      def call(font)
        `#{ot_sanitise_command} #{font.path} 2>&1`
      end

      private

      def ot_sanitise_command
        'ots-sanitize'
      end
    end
  end
end
