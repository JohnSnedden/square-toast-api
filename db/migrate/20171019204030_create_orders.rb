class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.date :date
      t.string :status
      t.string :description
      t.decimal :price

      t.timestamps
    end
  end
end
