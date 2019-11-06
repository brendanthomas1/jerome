# frozen_string_literal: true

module Jerome
  module ClassMethods
    def context(name, &block)
      @contexts ||= {}
      @contexts[name] = Jerome::Context.new(&block)
    end

    def term(left, right)
      default_context.term left, right
    end

    def translate!(left, context: nil)
      ctx = get_context(context)
      translation = ctx.dictionary.find do |pairs|
        left == pairs[:left]
      end

      raise NoTranslationError unless translation

      translation[:right]
    end

    alias t! translate!

    def reverse!(right, context: nil)
      ctx = get_context(context)
      translation = ctx.dictionary.find do |pairs|
        right == pairs[:right]
      end

      raise NoTranslationError unless translation

      translation[:left]
    end

    private

    def default_context
      @default_context ||= Jerome::Context.new
    end

    def get_context(context)
      return default_context if context.nil?

      @contexts[context]
    end
  end
end
