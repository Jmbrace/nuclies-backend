class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.integer :volunteer_id
      t.boolean :being_served

      t.timestamps null: false
    end
  end
end
