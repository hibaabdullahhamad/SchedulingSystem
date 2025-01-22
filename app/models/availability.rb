class Availability < ApplicationRecord
  belongs_to :tutor
  validates :time_zone, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :day, presence: true
end
