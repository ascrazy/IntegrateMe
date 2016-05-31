FactoryGirl.define do
  sequence(:competition_name) { |n| "Competition ##{n}" }

  factory :competition do
    sequence(:name) { |n| "Competition ##{n}" }
  end
end
