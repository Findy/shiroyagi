require 'rails_helper'

RSpec.describe AdminMessage, type: :model do
  describe '.reads' do
    subject { AdminMessage.reads }

    context 'when there are no messages' do
      it { is_expected.to match_array(AdminMessage.none) }
    end

    context 'when there is a message' do
      context 'when the message is read' do
        let!(:admin_message) { create :read_admin_message }

        it { is_expected.to match_array(admin_message) }
      end

      context 'when the message is unread' do
        let!(:admin_message) { create :unread_admin_message }

        it { is_expected.to match_array(AdminMessage.none) }
      end
    end

    context 'when there are messages' do
      context 'when these messages are all read' do
        let!(:admin_message_1) { create :read_admin_message }
        let!(:admin_message_2) { create :read_admin_message }

        it { is_expected.to match_array(AdminMessage.all) }
      end

      context 'when a message is read' do
        let!(:admin_message_1) { create :read_admin_message }
        let!(:admin_message_2) { create :unread_admin_message }

      it { is_expected.to match_array(admin_message_1) }
    end

    context 'when these messages are all unread' do
      let!(:admin_message_1) { create :unread_admin_message }
      let!(:admin_message_2) { create :unread_admin_message }

      it { is_expected.to match_array(AdminMessage.none) }
    end
  end
end

describe '.unreads' do
  subject { AdminMessage.unreads }

  context 'when there are no messages' do
    it { is_expected.to match_array(AdminMessage.none) }
  end

  context 'when there is a message' do
    context 'when the message is unread' do
      let!(:admin_message) { create :unread_admin_message }

      it { is_expected.to match_array(admin_message) }
    end

    context 'when the message is read' do
      let!(:admin_message) { create :read_admin_message }

      it { is_expected.to match_array(AdminMessage.none) }
    end
  end

  context 'when there are messages' do
    context 'when these messages are all unread' do
      let!(:admin_message_1) { create :unread_admin_message }
      let!(:admin_message_2) { create :unread_admin_message }

      it { is_expected.to match_array(AdminMessage.all) }
    end

    context 'when a message is unread' do
      let!(:admin_message_1) { create :unread_admin_message }
      let!(:admin_message_2) { create :read_admin_message }

      it { is_expected.to match_array(admin_message_1) }
      end

      context 'when these messages are all read' do
        let!(:admin_message_1) { create :read_admin_message }
        let!(:admin_message_2) { create :read_admin_message }

        it { is_expected.to match_array(AdminMessage.none) }
      end
    end
  end

  describe '.reads_count' do
    subject { AdminMessage.reads_count }

    context 'when there are no messages' do
      it { is_expected.to eq(0) }
    end

    context 'when there is a message' do
      context 'when the message is read' do
        let!(:admin_message) { create :read_admin_message }

        it { is_expected.to eq(1) }
      end

      context 'when the message is unread' do
        let!(:admin_message) { create :unread_admin_message }

        it { is_expected.to eq(0) }
      end
    end

    context 'when there are messages' do
      context 'when these messages are all read' do
        let!(:admin_message_1) { create :read_admin_message }
        let!(:admin_message_2) { create :read_admin_message }

        it { is_expected.to eq(2) }
      end

      context 'when a message is read' do
        let!(:admin_message_1) { create :read_admin_message }
        let!(:admin_message_2) { create :unread_admin_message }

        it { is_expected.to eq(1) }
      end

      context 'when these messages are all unread' do
        let!(:admin_message_1) { create :unread_admin_message }
        let!(:admin_message_2) { create :unread_admin_message }

        it { is_expected.to eq(0) }
      end
    end
  end

  describe '.unreads_count' do
    subject { AdminMessage.unreads_count }

    context 'when there are no messages' do
      it { is_expected.to eq(0) }
    end

    context 'when there is a message' do
      context 'when the message is unread' do
        let!(:admin_message) { create :unread_admin_message }

        it { is_expected.to eq(1) }
      end

      context 'when the message is read' do
        let!(:admin_message) { create :read_admin_message }

        it { is_expected.to eq(0) }
      end
    end

    context 'when there are messages' do
      context 'when these messages are all unread' do
        let!(:admin_message_1) { create :unread_admin_message }
        let!(:admin_message_2) { create :unread_admin_message }

        it { is_expected.to eq(2) }
      end

      context 'when a message is unread' do
        let!(:admin_message_1) { create :unread_admin_message }
        let!(:admin_message_2) { create :read_admin_message }

        it { is_expected.to eq(1) }
      end

      context 'when these messages are all read' do
        let!(:admin_message_1) { create :read_admin_message }
        let!(:admin_message_2) { create :read_admin_message }

        it { is_expected.to eq(0) }
      end
    end
  end

  describe '.mark_all_as_read' do
    subject { AdminMessage.mark_all_as_read }

    context 'when there are no messages' do
      it { is_expected.to eq([]) }
    end

    context 'when there is a message' do
      context 'when the message is read' do
        let!(:admin_message) { create :read_admin_message }

        it { is_expected.to eq([]) }

        it 'should not change user_read_at' do
          expect{ subject }.to_not change{ admin_message.reload.user_read_at }
        end
      end

      context 'when the message is unread' do
        let!(:admin_message) { create :unread_admin_message }

        it { is_expected.to match_array(admin_message) }

        it 'should record user_read_at' do
          expect{ subject }.to change{ admin_message.reload.user_read_at }.from(nil).to(be_an_instance_of(ActiveSupport::TimeWithZone))
        end
      end
    end

    context 'when there are messages' do
      context 'when these messages are all unread' do
        let!(:admin_message_1) { create :unread_admin_message }
        let!(:admin_message_2) { create :unread_admin_message }

        it { is_expected.to match_array(AdminMessage.all) }

        it 'should record admin_message_1 user_read_at' do
          expect{ subject }.to change{ admin_message_1.reload.user_read_at }.from(nil).to(be_an_instance_of(ActiveSupport::TimeWithZone))
        end

        it 'should record admin_message_2 user_read_at' do
          expect{ subject }.to change{ admin_message_2.reload.user_read_at }.from(nil).to(be_an_instance_of(ActiveSupport::TimeWithZone))
        end
      end

      context 'when a message is read' do
        let!(:admin_message_1) { create :unread_admin_message }
        let!(:admin_message_2) { create :read_admin_message }

        it { is_expected.to match_array(admin_message_1) }

        it 'should record admin_message_1 user_read_at' do
          expect{ subject }.to change{ admin_message_1.reload.user_read_at }.from(nil).to(be_an_instance_of(ActiveSupport::TimeWithZone))
        end

        it 'should not change admin_message_2 user_read_at' do
          expect{ subject }.to_not change{ admin_message_2.reload.user_read_at }
        end
      end

      context 'when these messages are all read' do
        let!(:admin_message_1) { create :read_admin_message }
        let!(:admin_message_2) { create :read_admin_message }

        it { is_expected.to match_array(AdminMessage.none) }

        it 'should not change admin_message_1 user_read_at' do
          expect{ subject }.to_not change{ admin_message_1.reload.user_read_at }
        end

        it 'should not change admin_message_2 user_read_at' do
          expect{ subject }.to_not change{ admin_message_2.reload.user_read_at }
        end
      end
    end
  end

  describe '.mark_all_as_unread' do
    subject { AdminMessage.mark_all_as_unread }

    context 'when there are no messages' do
      it { is_expected.to eq([]) }
    end

    context 'when there is a message' do
      context 'when the message is unread' do
        let!(:admin_message) { create :unread_admin_message }

        it { is_expected.to eq([]) }

        it 'should not change user_read_at' do
          expect{ subject }.to_not change{ admin_message.reload.user_read_at }
        end
      end

      context 'when the message is read' do
        let!(:admin_message) { create :read_admin_message }

        it { is_expected.to match_array(admin_message) }

        it 'should clear user_read_at' do
          expect{ subject }.to change{ admin_message.reload.user_read_at }.from(ActiveSupport::TimeWithZone).to(nil)
        end
      end
    end

    context 'when there are messages' do
      context 'when these messages are all read' do
        let!(:admin_message_1) { create :read_admin_message }
        let!(:admin_message_2) { create :read_admin_message }

        it { is_expected.to match_array(AdminMessage.all) }

        it 'should clear admin_message_1 user_read_at' do
          expect{ subject }.to change{ admin_message_1.reload.user_read_at }.from(be_an_instance_of(ActiveSupport::TimeWithZone)).to(nil)
        end

        it 'should clear admin_message_2 user_read_at' do
          expect{ subject }.to change{ admin_message_2.reload.user_read_at }.from(be_an_instance_of(ActiveSupport::TimeWithZone)).to(nil)
        end
      end

      context 'when a message is unread' do
        let!(:admin_message_1) { create :read_admin_message }
        let!(:admin_message_2) { create :unread_admin_message }

        it { is_expected.to match_array(admin_message_1) }

        it 'should clear admin_message_1 user_read_at' do
          expect{ subject }.to change{ admin_message_1.reload.user_read_at }.from(be_an_instance_of(ActiveSupport::TimeWithZone)).to(nil)
        end

        it 'should not change admin_message_2 user_read_at' do
          expect{ subject }.to_not change{ admin_message_2.reload.user_read_at }
        end
      end

      context 'when these messages are all unread' do
        let!(:admin_message_1) { create :unread_admin_message }
        let!(:admin_message_2) { create :unread_admin_message }

        it { is_expected.to match_array(AdminMessage.none) }

        it 'should not change admin_message_1 user_read_at' do
          expect{ subject }.to_not change{ admin_message_1.reload.user_read_at }
        end

        it 'should not change admin_message_2 user_read_at' do
          expect{ subject }.to_not change{ admin_message_2.reload.user_read_at }
        end
      end
    end
  end

  describe '#mark_as_read' do
    subject { admin_message.mark_as_read }

    context 'when the message is unread' do
      let(:admin_message) { create :unread_admin_message }

      it { is_expected.to be_truthy }

      it 'should record user_read_at' do
        expect{ subject }.to change{ admin_message.user_read_at }.from(nil).to(be_an_instance_of(ActiveSupport::TimeWithZone))
      end
    end

    context 'when the message is read' do
      let(:admin_message) { create :read_admin_message }

      it { is_expected.to be_nil }

      it 'should not change user_read_at' do
        expect{ subject }.to_not change{ admin_message.user_read_at }
      end
    end
  end

  describe '#mark_as_unread' do
    subject { admin_message.mark_as_unread }

    context 'when the message is read' do
      let(:admin_message) { create :read_admin_message }

      it { is_expected.to be_truthy }

      it 'should clear user_read_at' do
        expect{ subject }.to change{ admin_message.user_read_at }.from(be_an_instance_of(ActiveSupport::TimeWithZone)).to(nil)
      end
    end

    context 'when the message is unread' do
      let(:admin_message) { create :unread_admin_message }

      it { is_expected.to be_nil }

      it 'should not change user_read_at' do
        expect{ subject }.to_not change{ admin_message.user_read_at }
      end
    end
  end

  describe '#read?' do
    subject { admin_message.read? }

    context 'when the message is read' do
      let(:admin_message) { create :read_admin_message }

      it { is_expected.to be_truthy }
    end

    context 'when the message is unread' do
      let(:admin_message) { create :unread_admin_message }

      it { is_expected.to be_falsy }
    end
  end

  describe '#unread?' do
    subject { admin_message.unread? }

    context 'when the message is unread' do
      let(:admin_message) { create :unread_admin_message }

      it { is_expected.to be_truthy }
    end

    context 'when the message is read' do
      let(:admin_message) { create :read_admin_message }

      it { is_expected.to be_falsy }
    end
  end
end
