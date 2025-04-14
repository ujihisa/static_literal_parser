# frozen_string_literal: true

module StaticLiteralParser
  def self.parse(str, constants)
    case constants
    when Array
      parse(str, constant_strs_array_to_hash(constants))
    when Hash
      parse_(RubyVM::AbstractSyntaxTree.parse(str), constants)
    else
      raise ArgumentError, "Unsupported constants type: #{constants}"
    end
  end

  private_class_method def self.parse_(node, constants)
    return unless node
    case node.type
    when :SCOPE
      parse_(node.children[2], constants)
    when :LIST, :ZLIST, :ZARRAY, :ARRAY
      node.children[0..-2].map {|x| parse_(x, constants) }
    when :HASH
      Hash[*parse_(node.children[0], constants)]
    when :INTEGER, :FLOAT, :SYM, :IMAGINARY, :RATIONAL, :STR, :REGX, :NIL
      node.children[0]
    when :TRUE
      true
    when :FALSE
      false
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
    when :DSTR, :DOT2, :DREGX
      raise "Unsupported node: #{node.type}\nStaticLiteralParser does not support any dyanmic evaluations."
    else
      raise "Unexpected node #{node.type}"
    end
  end

  private_class_method def self.constant_strs_array_to_hash(constant_strs_array)
    constant_strs_array.flat_map {|constant|
      constant.split('::').inject([]) {|memo, part|
        [*memo, [memo.last, part].compact.join('::')]
      }
    }.to_h {|name|
      c = Object.const_get(name)
      [name.to_sym, c]
    }
  end
end
