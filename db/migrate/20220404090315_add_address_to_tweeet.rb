class AddAddressToTweeet < ActiveRecord::Migration[6.1]
  def change
    add_column :tweeets, :address, :text
  end
end
