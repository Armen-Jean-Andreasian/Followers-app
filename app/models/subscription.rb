class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :follows, polymorphic: true
  belongs_to :followers, polymorphic: true
end
