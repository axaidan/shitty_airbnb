class CreateReservations < ActiveRecord::Migration[6.0]
	def change
		create_table :reservations do |t|
			t.datetime :end_date
			t.datetime :start_date
			t.belongs_to :guest, index: true
			t.belongs_to :accomodation, index: true
			t.timestamps
		end
	end
end
