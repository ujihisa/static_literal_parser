# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'static_literal_parser'
  s.version     = '1.3.2'
  s.date        = '2026-11-11'
  s.summary     = 'StaticLiteralParser.parse(str, constants)'
  s.description = 'StaticLiteralParser is a RubyGems library that you can convert a String to a Ruby object, parsing the string as an executable Ruby code, but without actually executing it. This internally uses RubyVM::AbstractSyntaxTree to parse to construct the object.'
  s.authors     = ['Tatsuhiro Ujihisa']
  s.email       = 'ujihisa at gmail com'
  s.files       = ['lib/static_literal_parser.rb']
  s.required_ruby_version = '>= 2.6.6'
  s.homepage    = 'https://github.com/ujihisa/static_literal_parser'
  s.license     = 'GPL-3.0-or-later'
end
