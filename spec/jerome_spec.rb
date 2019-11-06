# frozen_string_literal: true

RSpec.describe Jerome do
  subject { TestTranslator }

  describe '.translate!' do
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
    it "adds a term to the default context's dictionary" do
      default_context = subject.instance_variable_get(:@default_context)

      expect { subject.term 'dog', 'cane' }
        .to change { default_context.dictionary.include?(left: 'dog', right: 'cane') }
        .from(false)
        .to(true)
    end
  end

  describe '.context' do
    it 'creates a new context' do
      expect { subject.context :french }
        .to change { subject.instance_variable_get(:@contexts).count }
        .by(1)
    end
  end

  it 'has a version number' do
    expect(Jerome::VERSION).not_to be nil
  end
end
