# frozen_string_literal: true

require 'jerome/version'

module Jerome
  class NoTranslationError < StandardError; end

  class << self
    def dictionary
      [
        { left: 'dog', right: 'cane' },
        { left: 'book', right: 'libro' },
        { left: 'street', right: 'strada' },
        { left: 'car', right: 'auto' },
        { left: 'doctor', right: 'dottore' }
      ]
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
end
