class Event < ActiveRecord::Base
  belongs_to :host, class_name: "User"
  validates :city, :name, presence: true
  validates :date, presence: true
  validates_date :date, after: lambda { Date.current }, :after_message => "must be scheduled in the future.."
  validates :state, presence: true, length: {is: 2}
  has_many :attendances
  has_many :users, through: :attendances
  has_many :comments
end
