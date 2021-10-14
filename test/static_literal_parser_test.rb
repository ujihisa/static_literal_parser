# frozen_string_literal: true

require 'test/unit'
require './lib/static_literal_parser.rb'

ToplevelConstant = Object.new

module TestingModule
  class YoClass
    X = 123
  end
end

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
    assert_equal(nil, StaticLiteralParser.parse('nil', {}))
  end

  def test_dynamic_stuff_fails
    assert_raise {
      StaticLiteralParser.parse('"hello #{123}"', {}) # DSTR
    }
    assert_raise {
      StaticLiteralParser.parse('1..3', {}) # DOT2
    }
    assert_raise {
      StaticLiteralParser.parse('/this #{234}/', {}) # DREGX
    }
  end

  def test_array
    assert_equal([], StaticLiteralParser.parse('[]', {}))
    assert_equal([1, 2, 3], StaticLiteralParser.parse('[1, 2, 3]', {}))
    assert_equal([[]], StaticLiteralParser.parse('[[]]', {}))
    assert_equal([1, [2, 3], [], [4]], StaticLiteralParser.parse('[1, [2, 3], [], [4]]', {}))
  end

  def test_constants
    assert_equal(ToplevelConstant, StaticLiteralParser.parse('ToplevelConstant', {ToplevelConstant: ToplevelConstant}))

    x = Object.new
    assert_equal(x, StaticLiteralParser.parse('ToplevelConstant', {ToplevelConstant: x}))

    assert_equal(TestingModule::YoClass::X, StaticLiteralParser.parse('TestingModule::YoClass::X', {
      'TestingModule': TestingModule,
      'TestingModule::YoClass': TestingModule::YoClass,
      'TestingModule::YoClass::X': TestingModule::YoClass::X,
    }))
  end

  def test_constants_in_array
    assert_equal(ToplevelConstant, StaticLiteralParser.parse('ToplevelConstant', ['ToplevelConstant']))

    assert_equal(
      TestingModule::YoClass::X,
      StaticLiteralParser.parse('TestingModule::YoClass::X', ['TestingModule::YoClass::X']))
  end

  def test_hash
    assert_equal({a: 1}, StaticLiteralParser.parse('{a: 1}', {}))
    assert_equal({}, StaticLiteralParser.parse('{}', {}))
    assert_equal([{}], StaticLiteralParser.parse('[{}]', {}))
  end
end
