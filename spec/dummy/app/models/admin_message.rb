class AdminMessage < ApplicationRecord
  include Shiroyagi::ActsAsShiroyagi

  acts_as_shiroyagi column: 'user_read_at'
end
