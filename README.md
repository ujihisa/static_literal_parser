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

## API

* `StaticLiteralParser.parse(str, constants)`
    * Pass a String that can be parsed as Ruby code into str arg. Note that it
      won't even try to execute anything, any dynamic things will end up raising
      RuntimeError, such as "#{1 + 2}"
    * Pass a Hash to constants arg. This hash is only used as constants to
      lookup in the given str. Note that you must provide all the levels of
      nested constants that you'd like to parse.

## FAQ

* Q. Why can't local variables, instance variables, or any other variables be passed like constants?
    * A. Simply because the author had not found use cases for that yet. If there are use cases, let's add them.

## Development

```
ruby test/static_literal_parser_test.rb
```

## Author

Tatsuhiro Ujihisa

## Licence

Static Literal Parser is released under the GPLv3 or any later versions.
https://www.gnu.org/licenses/gpl-3.0.en.html

## Changelog

### 1.3.0

* 

### 1.2.0

* Support constants in Array as an alternative representation

### 1.1.1

* Support `nil`

### 1.1.0

* Support Ruby 2.6.6 or any later versions

### 1.0.0

* Initial release
