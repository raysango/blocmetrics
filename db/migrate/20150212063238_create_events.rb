class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :app_name
      t.string :ip_address
      t.string :event_type

      t.timestamps
    end
  end
end
