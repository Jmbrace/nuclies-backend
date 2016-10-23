class FixTypo < ActiveRecord::Migration
  def change
    remove_column :in_needs, :last_4sssn
    add_column :in_needs, :last4_ssn, :integer
  end
end
