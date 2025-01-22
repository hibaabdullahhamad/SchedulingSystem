class AddTimeZoneToAvailabilities < ActiveRecord::Migration[8.0]
  def change
    add_column :availabilities, :time_zone, :string
  end
end
