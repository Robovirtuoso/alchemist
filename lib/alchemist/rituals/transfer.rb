module Alchemist

  module Rituals

    class Transfer

      # - Block and target field should be optional
      # - Assign return value of the block to the target field
      # - Target field is source_field if result_field is not given
      def initialize(source_field, result_field=nil, &block)
        @source_field = source_field
        @result_field = result_field
        @block        = block
      end

      def call(source, result)
        @source = source
        method  = target_method(result)
        result.public_send(method, argument)
      rescue NoMethodError, ArgumentError
        raise Errors::InvalidResultMethodForTransfer.new(@result_field)
      end

      private

      def argument
        block_value || source_value
      end

      def block_value
        @block.call(source_value) if @block
      end

      def source_value
        @source.public_send(@source_field)
      end

      def target_method(result)
        if result.respond_to?(result_mutator)
          result_mutator
        else
          result_method
        end
      end

      def result_method
        @result_field || @source_field
      end

      def result_mutator
        "#{result_method}="
      end

    end

  end

end
