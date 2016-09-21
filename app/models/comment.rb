class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates :content, length: {minimum: 5}, presence: true
end
