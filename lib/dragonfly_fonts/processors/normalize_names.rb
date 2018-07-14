module DragonflyFonts
  module Processors
    class NormalizeNames
      def call(content, options = {})
        # TODO: if other then convert first
        raise UnsupportedFormat unless FONT_FORGE_SUPPORTED_FORMATS.include?(content.ext)

        content.shell_update(ext: content.ext || 'ttf') do |old_path, new_path|
          "#{fontforge_command} -script #{DragonflyFonts::SCRIPT_DIR.join('normalize_names.sh')} #{old_path} #{new_path}"
        end
      end

      private

      def fontforge_command
        'fontforge'
      end
    end
  end
end
