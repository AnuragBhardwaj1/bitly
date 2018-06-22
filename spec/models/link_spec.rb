require "rails_helper"

RSpec.describe Link, type: :model do
  let(:link) { build(:link) }
  let(:saved_link) { create(:link) }

  context 'Validations' do
    it { is_expected.to validate_presence_of(:long_link) }

    context '#long_link_format' do
      before do
        link.long_link = 'invalid link'
        saved_link.long_link = 'www.test.com'
      end
      it ' is expected to be invalid for invalid long_link' do
        expect(link.valid?).to eq(false)
      end

      it ' is expected to be valid for valid long_link' do
        expect(saved_link.valid?).to eq(true)
      end
    end

    context 'short_link uniqueness' do
      before do
        allow(link).to receive(:generate_short_link).and_return(nil)
        link.short_link = saved_link.short_link
        link.valid?
      end

      it 'is expected to be invalid' do
        expect(link.valid?).to eq false
      end

      it 'is expected to add errors' do
        expect(link.errors.messages[:short_link]).to eq ['has already been taken']
      end
    end

    context 'short_link presence' do
      before do
        allow(link).to receive(:generate_short_link).and_return(nil)
        link.valid?
      end

      it 'is expected to be invalid' do
        expect(link.valid?).to eq false
      end

      it 'is expected to add errors' do
        expect(link.errors.messages[:short_link]).to eq ["can't be blank"]
      end

    end
  end

  context 'methods' do
    context '#generate_short_link' do
      context 'before validation callback runs' do
        it 'is expected to be blank before validation' do
          expect(link.short_link).to eq nil
        end
      end

      context 'after validation callback runs' do
        before { link.valid? }
        it 'is expected to be present after validation' do
          expect(link.short_link).not_to eq ''
        end
      end
    end

    context '#sanitize_long_link' do
      before do
        link.long_link = ' www.google.com '
        link.valid?
      end

      it 'is expected to be valid' do
        expect(link.valid?).to eq true
      end

      it 'is expected to be sanitized' do
        expect(link.long_link).to eq 'www.google.com'
      end
    end

    context '#redirection_url' do

    end
  end
end
