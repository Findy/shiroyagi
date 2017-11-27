module Shiroyagi
  module ActsAsShiroyagi
    extend ActiveSupport::Concern

    class_methods do
      # TODO: The read_at column name should be customizable via an argument.
      def acts_as_shiroyagi(options = {})
      end

      def reads_count
        reads.count
      end

      def unreads_count
        unreads.count
      end

      def mark_all_as_read
        unreads.update(read_at: Time.current)
      end

      def mark_all_as_unread
        reads.update(read_at: nil)
      end
    end

    included do
      scope :reads,   -> { where.not(read_at: nil) }
      scope :unreads, -> { where(read_at: nil) }

      def mark_as_read
        update(read_at: Time.current) if unread?
      end

      def mark_as_unread
        update(read_at: nil) if read?
      end

      def mark_as_read!
        update!(read_at: Time.current) if unread?
      end

      def mark_as_unread!
        update!(read_at: nil) if read?
      end

      def read?
        read_at.present?
      end

      def unread?
        read_at.blank?
      end
    end
  end
end
