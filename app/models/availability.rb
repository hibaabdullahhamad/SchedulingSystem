class Availability < ApplicationRecord
  belongs_to :tutor
  validates :time_zone, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :day, presence: true

  validate :start_time_before_end_time

  # Convert time zone
  def converted_availability_to_student_time_zone(student_time_zone)
    {
      day: day,
      start_time: format_time(convert_time_to_zone(start_time, time_zone, student_time_zone)),
      end_time: format_time(convert_time_to_zone(end_time, time_zone, student_time_zone)),
      time_zone: student_time_zone
    }
  end

  private

  def start_time_before_end_time
    if start_time.present? && end_time.present? && start_time >= end_time
      errors.add(:start_time, "must be before end time")
    end
  end

  def convert_time_to_zone(time, from_zone, to_zone)
    from_zone_time = ActiveSupport::TimeZone[from_zone].local_to_utc(time)
    ActiveSupport::TimeZone[to_zone].utc_to_local(from_zone_time)
  end

  # Strip the date
  def format_time(time)
    time.strftime("%H:%M:%S") # Format as "HH:MM:SS"
  end
end
