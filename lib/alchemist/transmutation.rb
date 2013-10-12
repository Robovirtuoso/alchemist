module Alchemist

  class Transmutation

    attr_reader :source, :result_type, :recipe

    def initialize(source, result_type)
      @source      = source
      @result_type = result_type
    end

    def process
      recipe.rituals.each { |ritual| ritual.call(context) }
    end

    private

    def source_type
      @source.class
    end

    def result
      @result ||= recipe.get_result(source)
    end

    def recipe
      @recipe ||= RecipeBook.lookup(source_type, result_type)
    end

    def context
      @context ||= Context.new(source, recipe.get_result)
    end

  end

end

