class Tutor < ApplicationRecord
    has_many :availabilities, dependent: :destroy
    has_many :bookings, dependent: :destroy
  end
  