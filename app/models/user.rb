class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password
  validates :first_name, :last_name, :city, presence: true, length: {minimum: 3}
  validates :email, presence: true, uniqueness: {case_sensitve: false}, format: {with: VALID_EMAIL_REGEX}
  validates :state, presence: true, length: {is: 2}
  has_many :hosted_events, class_name: "Event", foreign_key: "host_id"
  has_many :attendances
  has_many :events, through: :attendances
  has_many :comments

end
