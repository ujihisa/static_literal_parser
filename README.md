# Static Literal Parser for Ruby

```ruby
# data.txt
{
  name: 'ujihisa',
  tags: ['ruby', 'vim'],
  country: CANADA,
  money: 10.02,
}

# main_code.rb
require 'static_literal_parser'
CANADA = ...

pp StaticLiteralParser.parse(
  File.read('/tmp/data.txt'),
  {CANADA: CANADA})
#=> {:name=>"ujihisa", :tags=>["ruby", "vim"], :country=>..., :money=>10.02}
```

StaticLiteralParser is a RubyGems library that you can convert a String to a Ruby object, parsing the string as an executable Ruby code, but without actually executing it. This internally uses RubyVM::AbstractSyntaxTree to parse to construct the object.

* This does not depend on any other libraries
* This uses CRuby's `RubyVM::AbstractSyntaxTree` class
    * This may not work with other Ruby implementations

## Author

Tatsuhiro Ujihisa

## Licence

Static Literal Parser is released under the GPLv3 or any later versions.
https://www.gnu.org/licenses/gpl-3.0.en.html
