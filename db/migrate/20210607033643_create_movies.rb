class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :image
      t.date :date_created
      t.integer :qualification

      t.timestamps
    end
  end
end
