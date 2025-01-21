class Student < ApplicationRecord
    has_many :bookings, dependent: :destroy
end
