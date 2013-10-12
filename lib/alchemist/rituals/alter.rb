# alter do
#   let :method1, :method2
#
#   target :method_on_result_object do
#     method1 + method2
#   end
# end

module Alchemist

  module Rituals

    class Alter

      def initialize(&block)
        @source_methods = nil
        @target_list    = []
        @block = block
      end

      def call(source, result)
        @source ||= source
        @result ||= result
      end

      private

      def evalutate_block
        instance_exec(&@block)
      end

      def let(*methods)
        methods.each do |method|
          #source_methods.add_method()
        end
      end

      def target(*targets, &block)
      end

      def source_methods
        @source_methods ||= SourceMethods.new
      end

    end

  end

end
