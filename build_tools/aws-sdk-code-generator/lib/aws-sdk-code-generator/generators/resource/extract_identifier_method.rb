module AwsSdkCodeGenerator
  module Generators
    module Resource
      class ExtractIdentifierMethod < Dsl::Method

        include Helper

        # @option options [required, String] :identifier
        # @option options [required, Integer] :index
        def initialize(options = {})
          identifier = options.fetch(:identifier)
          name = underscore(identifier['name'])
          type = identifier_type(identifier)
          super("extract_#{name}", access: :private)
          param('args')
          param('options')
          code(<<-CODE)
value = args[#{options.fetch(:index)}] || options.delete(:#{name})
case value
when #{type} then value
when nil then raise ArgumentError, "missing required option :#{name}"
else
  msg = "expected :#{name} to be a #{type}, got \#{value.class}"
  raise ArgumentError, msg
end
          CODE
        end

      end
    end
  end
end