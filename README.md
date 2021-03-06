# Dragonfly Fonts

[![Circle CI](https://circleci.com/gh/tomasc/dragonfly_fonts.svg?style=svg&circle-token=3b836116bd1aaa6b76103b45ab0caef112b3df94)](https://circleci.com/gh/tomasc/dragonfly_fonts) [![Gem Version](https://badge.fury.io/rb/dragonfly_fonts.svg)](http://badge.fury.io/rb/dragonfly_fonts) [![Coverage Status](https://img.shields.io/coveralls/tomasc/dragonfly_fonts.svg)](https://coveralls.io/r/tomasc/dragonfly_fonts)

Wraps common font-related tasks into [Dragonfly](http://markevans.github.io/dragonfly) analysers and processors.

## Installation

Add this line to your application's Gemfile:

    gem 'dragonfly_fonts'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dragonfly_fonts

## Dependencies

### FontForge

You will need [FontForge](http://fontforge.github.io) with Python extensions installed.

Using [Homebrew](http://brew.sh):

    $ brew install fontforge --enable-pyextension

Using debian/ubuntu packages:

    $ sudo apt-get install fontforge python-fontforge

### fonttools

See [fonttools](https://github.com/behdad/fonttools)

### ots-sanitize

See [ots-sanitize](https://github.com/khaledhosny/ots)

### ttf2eot

See [ttf2eot](http://code.google.com/p/ttf2eot).

### ttfautohint

See [ttfautohint](http://www.freetype.org/ttfautohint/doc/ttfautohint.html).

### woff2

See [woff2](https://github.com/google/woff2).

## Usage

Add the `:fonts` plugin to your Dragonfly config block:

```ruby
Dragonfly.app.configure do
  plugin :fonts
end
```

## Supported Formats

List of supported formats is available as:

```ruby
DragonflyFonts::SUPPORTED_FORMATS # => ["bdf", "dfont", "bin", …]
DragonflyFonts::SUPPORTED_OUTPUT_FORMATS # => ["eot", "ttf", …]
```

## Analysers

### Bbox

Returns `Struct.new("Bbox", :glyph, :min_x, :min_y, :max_x, :max_y, :width, :height)` representing the glyph's bounding box.

```ruby
DragonflyFonts::Analysers::Bbox.new.call(font, glyph)
```

### Font Info

Returns information about the font as a Hash with the following keys: `:ascent`, `:cap_height`, `:comment`, `:copyright`, `:default_base_filename`, `:descent`, `:descriptor`, `:designer`, `:designer_url`, `:em`, `:embedding_restrictions`, `:encoding`, `:familyname`, `:fontlog`, `:fontname`, `:fullname`, `:license`, `:license_url`, `:path`, `:sfnt_revision`, `:trademark`, `:upos`, `:uwidth`, `:vendor_url`, `:version`, `:weight`, `:woff_metadata`, `:woff_revision`, `:x_height`.

```ruby
font.font_info
```

### Glyphs

Returns `Array` of all glyphs contained in the font, each glyph represented by a Hash with the following keys: `:glyphclass`, `:glyphname`, `:encoding`, `:script`, `:width`, `:unicode`.

```ruby
font.glyphs
```

### GSUB Tables

Returns `Array` of gsub tables in the font.

```ruby
font.gsub_tables
```

### OTS Sanitize

Displays output of the `ots-sanitize` command.

```ruby
font.ots_sanitize

```

## Processors

### Correct Metrics

Normalizes ascent and descent values.

```ruby
font.correct_metrics
```

### Encode

Allows for conversion to EOT, OTF, SVG, TTF, WOFF, WOFF2, TTX.

```ruby
font.encode(:woff)
```

* OTF, SVG, TTF, WOFF conversion is handled by `FontForge`.
* EOT conversion is handled by `ttf2eot`. The input font needs to be in TTF format. Due to bug in IE, font FullName MUST begin with FamilyName. For example, if FamilyName is fontello, then FullName should be fontello regular and so on. In this condition is not satisfyed, then font will not be shown in IE.
* WOFF2 conversion is handled by `woff2`.
* TTX conversion is handled by `ttx` (fonttools).

### Extract Glyph

Extracts specified glyph in SVG format.

```ruby
font.extract_glyph('A')
```

### Fix DFLT table

Fix for DFLT tables causing issues in Firefox 44.

```ruby
font.fix_dflt_table
```

### Normalize Names

Fix for rejected EOT's in IE8.

```ruby
font.normalize_names
```

### OTS

Sanitize OTF/TTF & WOFF/2 font files.

```ruby
font.ots_sanitize!
```

### Set Dimensions

Adjust ascent & descent by an increment of.

```ruby
font.set_dimensions(ascent: 10, descent: -10)
```

### Set TTF Names

Allows to set the following TTF properties: `:compatible_full`, `:copyright`, `:description`, `:designer`, `:designer_url`, `:fontname`, `:fullname`, `:license`, `:license_url`, `:manufacturer`, `:postscript_cid`, `:postscript_name`, `:preferred_family`, `:preferred_subfamily`, `:sample_text`, `:trademark`, `:uid`, `:vendor_url`, `:version`, `:weight`. See [docs at Adobe](http://partners.adobe.com/public/developer/opentype/index_name.html#enc4) for more details.

```ruby
ttf_names = { designer: 'John Doe' }
font.set_ttf_names(ttf_names)
```

### Set Underline

Allows to set underline properties: position and width.

```ruby
font.set_underline({ upos: 1, uwidth: 1 })
```

### Set Width

Sets width of each character. The relative parameter can have the following values:

* when 0 the vertical width will be set exactly to `width` value
* when 1 then the vertical width will be incremented by `width` value
* when 2 then the vertical width will be scaled by `width` value/100.0.

```ruby
font.set_width(width, relative=1)
```

### Set WOFF Metadata

Converts font to WOFF and sets license-related values of embedded XML metadata. The rest of the metadata is automatically inferred from font properties (see `#set_ttf_names`).

```ruby
font.set_woff_metadata(uniqueid, licensee_name)
```

### TTF autohint

Generates FreeType auto hints. See [ttfautohint](http://www.freetype.org/ttfautohint/doc/ttfautohint.html).

```ruby
font.ttf_autohint
```

### Web Friendly

Make web friendly.

```ruby
font.web_friendly
```

## Contributing

1. Fork it ( https://github.com/tomasc/dragonfly_fonts/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
