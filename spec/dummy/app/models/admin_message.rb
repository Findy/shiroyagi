class AdminMessage < ApplicationRecord
  include Shiroyagi::ActsAsShiroyagi

  def self.read_management_column_name
    :user_read_at
  end
end
