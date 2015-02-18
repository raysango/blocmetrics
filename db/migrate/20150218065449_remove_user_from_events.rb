class RemoveUserFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :user_id_id, :integer
  end
end
