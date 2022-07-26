module Shiroyagi
  module ActsAsShiroyagi
    extend ActiveSupport::Concern

    class_methods do
      def acts_as_shiroyagi(options = {})
      end

      def read_management_column_name
        @read_management_column_name || :read_at
      end

      # NOTE: call this method to change column that use read management
      def read_management_column_name=(column_name)
        @read_management_column_name = column_name.to_sym
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
        update(read_management_column_name => Time.current) if unread?
      end

      def mark_as_unread
        update(read_management_column_name => nil) if read?
      end

      def mark_as_read!
        update!(read_management_column_name => Time.current) if unread?
      end

      def mark_as_unread!
        update!(read_management_column_name => nil) if read?
      end

      def read?
        send(read_management_column_name).present?
      end

      def unread?
        send(read_management_column_name).blank?
      end
    end

    private

    def read_management_column_name
      self.class.read_management_column_name
    end
  end
end
