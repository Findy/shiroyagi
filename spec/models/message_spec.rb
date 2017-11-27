require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '.reads' do
    subject { Message.reads }

    context 'when there are no messages' do
      it { is_expected.to match_array(Message.none) }
    end

    context 'when there is a message' do
      context 'when the message is read' do
        let!(:message) { create :read_message }

        it { is_expected.to match_array(message) }
      end

      context 'when the message is unread' do
        let!(:message) { create :unread_message }

        it { is_expected.to match_array(Message.none) }
      end
    end

    context 'when there are messages' do
      context 'when these messages are all read' do
        let!(:message_1) { create :read_message }
        let!(:message_2) { create :read_message }

        it { is_expected.to match_array(Message.all) }
      end

      context 'when a message is read' do
        let!(:message_1) { create :read_message }
        let!(:message_2) { create :unread_message }

        it { is_expected.to match_array(message_1) }
      end

      context 'when these messages are all unread' do
        let!(:message_1) { create :unread_message }
        let!(:message_2) { create :unread_message }

        it { is_expected.to match_array(Message.none) }
      end
    end
  end

  describe '.unreads' do
    subject { Message.unreads }

    context 'when there are no messages' do
      it { is_expected.to match_array(Message.none) }
    end

    context 'when there is a message' do
      context 'when the message is unread' do
        let!(:message) { create :unread_message }

        it { is_expected.to match_array(message) }
      end

      context 'when the message is read' do
        let!(:message) { create :read_message }

        it { is_expected.to match_array(Message.none) }
      end
    end

    context 'when there are messages' do
      context 'when these messages are all unread' do
        let!(:message_1) { create :unread_message }
        let!(:message_2) { create :unread_message }

        it { is_expected.to match_array(Message.all) }
      end

      context 'when a message is unread' do
        let!(:message_1) { create :unread_message }
        let!(:message_2) { create :read_message }

        it { is_expected.to match_array(message_1) }
      end

      context 'when these messages are all read' do
        let!(:message_1) { create :read_message }
        let!(:message_2) { create :read_message }

        it { is_expected.to match_array(Message.none) }
      end
    end
  end

  describe '.reads_count' do
    subject { Message.reads_count }

    context 'when there are no messages' do
      it { is_expected.to eq(0) }
    end

    context 'when there is a message' do
      context 'when the message is read' do
        let!(:message) { create :read_message }

        it { is_expected.to eq(1) }
      end

      context 'when the message is unread' do
        let!(:message) { create :unread_message }

        it { is_expected.to eq(0) }
      end
    end

    context 'when there are messages' do
      context 'when these messages are all read' do
        let!(:message_1) { create :read_message }
        let!(:message_2) { create :read_message }

        it { is_expected.to eq(2) }
      end

      context 'when a message is read' do
        let!(:message_1) { create :read_message }
        let!(:message_2) { create :unread_message }

        it { is_expected.to eq(1) }
      end

      context 'when these messages are all unread' do
        let!(:message_1) { create :unread_message }
        let!(:message_2) { create :unread_message }

        it { is_expected.to eq(0) }
      end
    end
  end

  describe '.unreads_count' do
    subject { Message.unreads_count }

    context 'when there are no messages' do
      it { is_expected.to eq(0) }
    end

    context 'when there is a message' do
      context 'when the message is unread' do
        let!(:message) { create :unread_message }

        it { is_expected.to eq(1) }
      end

      context 'when the message is read' do
        let!(:message) { create :read_message }

        it { is_expected.to eq(0) }
      end
    end

    context 'when there are messages' do
      context 'when these messages are all unread' do
        let!(:message_1) { create :unread_message }
        let!(:message_2) { create :unread_message }

        it { is_expected.to eq(2) }
      end

      context 'when a message is unread' do
        let!(:message_1) { create :unread_message }
        let!(:message_2) { create :read_message }

        it { is_expected.to eq(1) }
      end

      context 'when these messages are all read' do
        let!(:message_1) { create :read_message }
        let!(:message_2) { create :read_message }

        it { is_expected.to eq(0) }
      end
    end
  end

  describe '.mark_all_as_read' do
    subject { Message.mark_all_as_read }

    context 'when there are no messages' do
      it { is_expected.to eq([]) }
    end

    context 'when there is a message' do
      context 'when the message is read' do
        let!(:message) { create :read_message }

        it { is_expected.to eq([]) }

        it 'should not change read_at' do
          expect{ subject }.to_not change{ message.reload.read_at }
        end
      end

      context 'when the message is unread' do
        let!(:message) { create :unread_message }

        it { is_expected.to match_array(message) }

        it 'should record read_at' do
          expect{ subject }.to change{ message.reload.read_at }.from(nil).to(be_an_instance_of(ActiveSupport::TimeWithZone))
        end
      end
    end

    context 'when there are messages' do
      context 'when these messages are all unread' do
        let!(:message_1) { create :unread_message }
        let!(:message_2) { create :unread_message }

        it { is_expected.to match_array(Message.all) }

        it 'should record message_1 read_at' do
          expect{ subject }.to change{ message_1.reload.read_at }.from(nil).to(be_an_instance_of(ActiveSupport::TimeWithZone))
        end

        it 'should record message_2 read_at' do
          expect{ subject }.to change{ message_2.reload.read_at }.from(nil).to(be_an_instance_of(ActiveSupport::TimeWithZone))
        end
      end

      context 'when a message is read' do
        let!(:message_1) { create :unread_message }
        let!(:message_2) { create :read_message }

        it { is_expected.to match_array(message_1) }

        it 'should record message_1 read_at' do
          expect{ subject }.to change{ message_1.reload.read_at }.from(nil).to(be_an_instance_of(ActiveSupport::TimeWithZone))
        end

        it 'should not change message_2 read_at' do
          expect{ subject }.to_not change{ message_2.reload.read_at }
        end
      end

      context 'when these messages are all read' do
        let!(:message_1) { create :read_message }
        let!(:message_2) { create :read_message }

        it { is_expected.to match_array(Message.none) }

        it 'should not change message_1 read_at' do
          expect{ subject }.to_not change{ message_1.reload.read_at }
        end

        it 'should not change message_2 read_at' do
          expect{ subject }.to_not change{ message_2.reload.read_at }
        end
      end
    end
  end

  describe '.mark_all_as_unread' do
    subject { Message.mark_all_as_unread }

    context 'when there are no messages' do
      it { is_expected.to eq([]) }
    end

    context 'when there is a message' do
      context 'when the message is unread' do
        let!(:message) { create :unread_message }

        it { is_expected.to eq([]) }

        it 'should not change read_at' do
          expect{ subject }.to_not change{ message.reload.read_at }
        end
      end

      context 'when the message is read' do
        let!(:message) { create :read_message }

        it { is_expected.to match_array(message) }

        it 'should clear read_at' do
          expect{ subject }.to change{ message.reload.read_at }.from(ActiveSupport::TimeWithZone).to(nil)
        end
      end
    end

    context 'when there are messages' do
      context 'when these messages are all read' do
        let!(:message_1) { create :read_message }
        let!(:message_2) { create :read_message }

        it { is_expected.to match_array(Message.all) }

        it 'should clear message_1 read_at' do
          expect{ subject }.to change{ message_1.reload.read_at }.from(be_an_instance_of(ActiveSupport::TimeWithZone)).to(nil)
        end

        it 'should clear message_2 read_at' do
          expect{ subject }.to change{ message_2.reload.read_at }.from(be_an_instance_of(ActiveSupport::TimeWithZone)).to(nil)
        end
      end

      context 'when a message is unread' do
        let!(:message_1) { create :read_message }
        let!(:message_2) { create :unread_message }

        it { is_expected.to match_array(message_1) }

        it 'should clear message_1 read_at' do
          expect{ subject }.to change{ message_1.reload.read_at }.from(be_an_instance_of(ActiveSupport::TimeWithZone)).to(nil)
        end

        it 'should not change message_2 read_at' do
          expect{ subject }.to_not change{ message_2.reload.read_at }
        end
      end

      context 'when these messages are all unread' do
        let!(:message_1) { create :unread_message }
        let!(:message_2) { create :unread_message }

        it { is_expected.to match_array(Message.none) }

        it 'should not change message_1 read_at' do
          expect{ subject }.to_not change{ message_1.reload.read_at }
        end

        it 'should not change message_2 read_at' do
          expect{ subject }.to_not change{ message_2.reload.read_at }
        end
      end
    end
  end

  describe '#mark_as_read' do
    subject { message.mark_as_read }

    context 'when the message is unread' do
      let(:message) { create :unread_message }

      it { is_expected.to be_truthy }

      it 'should record read_at' do
        expect{ subject }.to change{ message.read_at }.from(nil).to(be_an_instance_of(ActiveSupport::TimeWithZone))
      end
    end

    context 'when the message is read' do
      let(:message) { create :read_message }

      it { is_expected.to be_nil }

      it 'should not change read_at' do
        expect{ subject }.to_not change{ message.read_at }
      end
    end
  end

  describe '#mark_as_unread' do
    subject { message.mark_as_unread }

    context 'when the message is read' do
      let(:message) { create :read_message }

      it { is_expected.to be_truthy }

      it 'should clear read_at' do
        expect{ subject }.to change{ message.read_at }.from(be_an_instance_of(ActiveSupport::TimeWithZone)).to(nil)
      end
    end

    context 'when the message is unread' do
      let(:message) { create :unread_message }

      it { is_expected.to be_nil }

      it 'should not change read_at' do
        expect{ subject }.to_not change{ message.read_at }
      end
    end
  end

  describe '#read?' do
    subject { message.read? }

    context 'when the message is read' do
      let(:message) { create :read_message }

      it { is_expected.to be_truthy }
    end

    context 'when the message is unread' do
      let(:message) { create :unread_message }

      it { is_expected.to be_falsy }
    end
  end

  describe '#unread?' do
    subject { message.unread? }

    context 'when the message is unread' do
      let(:message) { create :unread_message }

      it { is_expected.to be_truthy }
    end

    context 'when the message is read' do
      let(:message) { create :read_message }

      it { is_expected.to be_falsy }
    end
  end
end
