FactoryGirl.define do
  factory :user do
    name     "Ivan Gudak"
    email    "ihudak@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end