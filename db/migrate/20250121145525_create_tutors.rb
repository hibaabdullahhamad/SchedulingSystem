class CreateTutors < ActiveRecord::Migration[8.0]
  def change
    create_table :tutors do |t|
      t.string :first_name
      t.string :last_name
      t.string :subject
      t.string :time_zone

      t.timestamps
    end
  end
end
