module DragonflyFonts
  module Processors
    class WebFriendly
      def call(content, opts = {})
        raise UnsupportedFormat unless content.ext
        raise UnsupportedFormat unless FONT_FORGE_SUPPORTED_FORMATS.include?(content.ext.downcase)

        content.shell_update(ext: content.ext || 'ttf') do |old_path, new_path|
          "#{fontforge_command} -script #{DragonflyFonts::SCRIPT_DIR.join('webfonts.pe')} #{old_path} #{new_path}"
        end
      end

      private

      def fontforge_command
        'fontforge'
      end
    end
  end
end
