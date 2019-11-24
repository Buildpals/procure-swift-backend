class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :full_name
      t.string :phone_number
      t.float  :price
      t.float  :shipping_cost
      t.string :amazon_url
      t.string :email
      t.timestamps
    end
  end
end
