# frozen_string_literal: true

RSpec.describe Jerome do
  subject { TestTranslator }

  let(:dictionary) do
    [
      { left: 'street', right: 'strada' }
    ]
  end

  describe '.translate!' do
    before { allow(subject).to receive(:dictionary).and_return dictionary }

    it 'returns the translated word' do
      expect(subject.translate!('street')).to eq 'strada'
    end

    context 'when no translation can be found' do
      it 'raises an error' do
        expect { subject.translate! 'gobbledegook' }.to raise_error Jerome::NoTranslationError
      end
    end
  end

  describe '.t!' do
    it 'is an alias of .translate!' do
      expect(subject.method(:t!) == subject.method(:translate!))
    end
  end

  describe '.reverse!' do
    before { allow(subject).to receive(:dictionary).and_return dictionary }

    it 'returns the untranslated word' do
      expect(subject.reverse!('strada')).to eq 'street'
    end

    context 'when no translation can be found' do
      it 'raises an error' do
        expect { subject.reverse! 'gobbledegook' }.to raise_error Jerome::NoTranslationError
      end
    end
  end

  describe '.term' do
    it 'adds a term to the dictionary' do
      expect { subject.term 'dog', 'cane' }
        .to change { subject.dictionary.include?(left: 'dog', right: 'cane') }
        .from(false)
        .to(true)
    end
  end

  it 'has a version number' do
    expect(Jerome::VERSION).not_to be nil
  end
end
