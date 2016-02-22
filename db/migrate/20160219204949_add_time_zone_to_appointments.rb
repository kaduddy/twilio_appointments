class AddTimeZoneToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :time_zone, :string
  end
end
