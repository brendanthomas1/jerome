# frozen_string_literal: true

RSpec.describe Jerome::Context do
  describe 'initialize' do
    context 'when no block is given' do
      subject { described_class.new }

      it 'initializes with an empty dictionary' do
        expect(subject.dictionary).to eq []
      end
    end

    context 'when given a block that adds terms' do
      subject do
        described_class.new do
          term 'milk', 'latte'
        end
      end

      it 'creates the contexts and adds the terms to the dictionary' do
        expect(subject.dictionary).to include(left: 'milk', right: 'latte')
      end
    end
  end
end
