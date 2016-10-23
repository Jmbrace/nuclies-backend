class AddColsToModels < ActiveRecord::Migration
  def change
  	add_column :services, :description, :text
  	add_column :services, :in_need_id, :integer

  	add_column :users, :services, :string, array: true, default: []
  end
end
