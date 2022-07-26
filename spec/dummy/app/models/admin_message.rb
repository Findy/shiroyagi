class AdminMessage < ApplicationRecord
  include Shiroyagi::ActsAsShiroyagi

  self.read_management_column_name = :user_read_at
end
