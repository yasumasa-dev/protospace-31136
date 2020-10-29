class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prototypes
  validates :text, presence: ture
end
