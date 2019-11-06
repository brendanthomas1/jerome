# frozen_string_literal: true

module Jerome
  class Context
    attr_reader :dictionary

    def initialize(&block)
      @dictionary = []
      instance_eval(&block) if block
    end

    def term(left, right)
      dictionary << { left: left, right: right }
    end
  end
end
