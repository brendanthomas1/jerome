# frozen_string_literal: true

require 'jerome/version'

module Jerome
  class NoTranslationError < StandardError; end

  module ClassMethods
    def dictionary
      @dictionary ||= []
    end

    def term(left, right)
      dictionary << { left: left, right: right }
    end

    def translate!(left)
      translation = dictionary.find do |pairs|
        left == pairs[:left]
      end

      raise NoTranslationError unless translation

      translation[:right]
    end

    alias t! translate!

    def reverse!(right)
      translation = dictionary.find do |pairs|
        right == pairs[:right]
      end

      raise NoTranslationError unless translation

      translation[:left]
    end
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end
end
