module Alchemist

  module Rituals

    class SourceMethod

      def initialize(source_method, *result_methods, &block)
        @source_method  = source_method
        @result_methods = result_methods
        @block          = block
      end

      def call(source, result)
        @source = source

        @result_methods.each do |result_method|
          Transfer.new(:value, result_method).call(source_struct, result)
        end
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
