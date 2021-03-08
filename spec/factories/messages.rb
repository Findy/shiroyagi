FactoryBot.define do
  factory :message, aliases: %i(unread_message) do
    association :from_user, factory: :user, strategy: :build
    association :to_user, factory: :user, strategy: :build

    trait :with_read_at do
      read_at { Time.current }
    end

    factory :read_message, traits: %i(with_read_at)
  end
end
