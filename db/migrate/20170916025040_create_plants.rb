class CreatePlants < ActiveRecord::Migration[5.1]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :category
      t.string :size
      t.string :condition
      t.belongs_to :user


      t.timestamps
    end
  end
end
