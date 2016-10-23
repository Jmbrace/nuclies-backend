class CreateInNeeds < ActiveRecord::Migration
  def change
    create_table :in_needs do |t|
      t.string :first_name
      t.string :last_name
      t.integer :last_4sssn

      t.timestamps null: false
    end
  end
end
