class CreateAccomodations < ActiveRecord::Migration[6.0]
	def change
		create_table :accomodations do |t|
			t.belongs_to :city, index: true
			t.belongs_to :admin, index: true			
			t.boolean :has_wifi?	
			t.integer :price
			t.integer :beds
			t.text :desc
			t.text :welcome
			t.timestamps
		end
	end
end
