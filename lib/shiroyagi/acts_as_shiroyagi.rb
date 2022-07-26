module Shiroyagi
  module ActsAsShiroyagi
    extend ActiveSupport::Concern

    class_methods do
      def acts_as_shiroyagi(options = {})
      end

      # NOTE: override this method change column to use read management
      def read_management_column_name
        :read_at
      end

      def reads_count
        reads.count
      end

      def unreads_count
        unreads.count
      end

      def mark_all_as_read
        unreads.update(read_management_column_name => Time.current)
      end

      def mark_all_as_unread
        reads.update(read_management_column_name => nil)
      end
    end

    included do
      scope :reads,   -> { where.not(read_management_column_name => nil) }
      scope :unreads, -> { where(read_management_column_name => nil) }

      def mark_as_read
        update(self.class.read_management_column_name => Time.current) if unread?
      end

      def mark_as_unread
        update(self.class.read_management_column_name => nil) if read?
      end

      def mark_as_read!
        update!(self.class.read_management_column_name => Time.current) if unread?
      end

      def mark_as_unread!
        update!(self.class.read_management_column_name => nil) if read?
      end

      def read?
        send(self.class.read_management_column_name).send('present?')
      end

      def unread?
        send(self.class.read_management_column_name).send('blank?')
      end
    end
  end
end
