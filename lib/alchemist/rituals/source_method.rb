module Alchemist

  module Rituals

    class SourceMethod

      def initialize(source_method, &block)
        @source_method  = source_method
        @block          = block
      end

      def call(source, result)
        @source = source

        result.instance_exec(source_value, &@block)
      end

      private

      def source_struct
        @source_struct ||= OpenStruct.new(value: value)
      end

      def value
        block_value || source_value
      end

      def block_value
        @block.call(source_value) if @block
      end

      def source_value
        @source.public_send(@source_method)
      rescue NoMethodError
        raise Errors::InvalidSourceMethod.new(@source_method)
      end

    end

  end

end
