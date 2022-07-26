FactoryBot.define do
  factory :admin_message, aliases: %i(unread_admin_message) do
    trait :with_read_at do
      user_read_at { Time.current }
    end

    factory :read_admin_message, traits: %i(with_read_at)
  end
end
