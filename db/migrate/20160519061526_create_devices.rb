class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :code
      t.timestamp :added

      t.timestamps null: false
    end
  end
end
