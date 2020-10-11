# frozen_string_literal: true

module StaticLiteralParser
  def self.parse(str, constants)
    parse_(RubyVM::AbstractSyntaxTree.parse(str), constants)
  end

  private_class_method def self.parse_(node, constants)
    case node.type
    when :SCOPE
      parse_(node.children[2], constants)
    when :LIST, :ZLIST
      node.children[..-2].map { parse_(_1, constants) }
    when :HASH
      Hash[*parse_(node.children[0], constants)]
    when :LIT, :STR
      node.children[0]
    when :CONST
      constants[node.children[0]] or raise "Missing const: #{node.children[0]}"
    when :COLON2
      (parent, child) = node.children
      case parent.type
      when :CONST, :COLON2
        parent = parse_(parent, constants)
        constants[:"#{parent}::#{child}"] or raise "Missing nested const: #{[parent, child]}"
      else
        raise "Unexpected COLON2 parent #{parent.type}"
      end
    else
      raise "Unexpected node #{node.type}"
    end
  end
end
