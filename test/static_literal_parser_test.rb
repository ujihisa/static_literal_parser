# frozen_string_literal: true

require 'test/unit'
require './lib/static_literal_parser.rb'

class StaticLiteralParserTest < Test::Unit::TestCase
  def test_literals
    assert_equal(1, StaticLiteralParser.parse('1', {}))
    assert_equal(0b010101, StaticLiteralParser.parse('0b010101', {}))
    assert_equal(0o1247123, StaticLiteralParser.parse('0o1247123', {}))
    assert_equal(0x1a3b, StaticLiteralParser.parse('0x1a3b', {}))
    assert_equal(0.23, StaticLiteralParser.parse('0.23', {}))
    assert_equal(1i, StaticLiteralParser.parse('1i', {}))
    assert_equal(2r, StaticLiteralParser.parse('2r', {}))
    assert_equal('hello', StaticLiteralParser.parse('"hello"', {}))
    assert_equal(:world, StaticLiteralParser.parse(':world', {}))
    assert_equal(/this/, StaticLiteralParser.parse('/this/', {}))
  end

  def test_dynamic_stuff_fails
    assert_raise {
      StaticLiteralParser.parse('"hello #{123}"', {}) # DSTR
    }
    assert_raise {
      StaticLiteralParser.parse('1..3', {}) # DOT2
    }
    assert_raise {
      StaticLiteralParser.parse('/this #{234}/', {})
    }
  end

  def test_array
    assert_equal([], StaticLiteralParser.parse('[]', {}))
    assert_equal([1, 2, 3], StaticLiteralParser.parse('[1, 2, 3]', {}))
    assert_equal([[]], StaticLiteralParser.parse('[[]]', {}))
    assert_equal([1, [2, 3], [], [4]], StaticLiteralParser.parse('[1, [2, 3], [], [4]]', {}))
  end
end