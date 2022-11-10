class AddIndexToUrlRandomId < ActiveRecord::Migration[6.1]
  def change
    add_index :urls, :random_id
  end
end
