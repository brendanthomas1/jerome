# frozen_string_literal: true

require 'jerome/class_methods'
require 'jerome/context'
require 'jerome/version'

module Jerome
  class NoTranslationError < StandardError; end

  def self.included(klass)
    klass.extend(ClassMethods)
  end
end
