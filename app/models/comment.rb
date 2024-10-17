class Comment < ApplicationRecord
  belongs_to :commenter
  belongs_to :commented_to, polymorphic: true
end
