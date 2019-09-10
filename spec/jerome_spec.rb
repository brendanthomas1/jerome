# frozen_string_literal: true

RSpec.describe Jerome do
  before do
    allow(Jerome).to receive(:dictionary).and_return dictionary
  end

  let(:dictionary) do
    [
      { left: 'street', right: 'strada' }
    ]
  end

  describe '.translate!' do
    it 'returns the translated word' do
      expect(Jerome.translate!('street')).to eq 'strada'
    end

    context 'when no translation can be found' do
      it 'raises an error' do
        expect { Jerome.translate! 'gobbledegook' }.to raise_error Jerome::NoTranslationError
      end
    end
  end

  describe '.t!' do
    it 'is an alias of .translate!' do
      expect(Jerome.method(:t!) == Jerome.method(:translate!))
    end
  end

  describe '.reverse!' do
    it 'returns the untranslated word' do
      expect(Jerome.reverse!('strada')).to eq 'street'
    end

    context 'when no translation can be found' do
      it 'raises an error' do
        expect { Jerome.reverse! 'gobbledegook' }.to raise_error Jerome::NoTranslationError
      end
    end
  end

  it 'has a version number' do
    expect(Jerome::VERSION).not_to be nil
  end
end
