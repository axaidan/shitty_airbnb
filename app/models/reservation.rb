class Reservation < ApplicationRecord
	#GUESTS
	belongs_to :guest, class_name: "User"
	validates :guest, presence: true

	#ACCOMODATION
	belongs_to :accomodation
	validates :accomodation, presence: true

	#DATETIMES
	validates :start_date, presence: true
	validates :end_date, presence: true
	validate :dates_are_valid
	validate :overlapping?

	def duration
		end_date.day - start_date.day 
	end

	private
	def dates_are_valid
		errors.add(:start_date, "End Date is before Start Date") unless	start_date < end_date	
	end

	def overlapping?
		new_start = self.start_date
		new_end = self.end_date
		new_duration = self.duration
		res_arr = self.accomodation.reservations
		res_arr.each do |reservation|
			if (new_start >= reservation.start_date &&
					new_start <= reservation.end_date)
				errors.add(:new_start,
						   "New reservation's START Date is overlapping a pre-existing reservation's dates for this accomodation.")
			elsif (new_end >= reservation.start_date &&
				   new_end <= reservation.end_date)
				errors.add(:new_end,
						   "New reservation's END Date is overlapping a pre-existing reservation's dates for this accomodation.")
=begin
			elsif (new_end - (new_duration/2).day >= reservation.start_date &&
				   new_end - (new_duration/2).day <= reservation.end_date)
				errors.add(:new_duration,
						   "New reservation INTERVAL is overlapping a pre-existing reservation's dates for this accomodation.")
				puts self.errors.messages
=end
			elsif (new_start <= reservation.start_date && new_end >= reservation.end_date)
				errors.add(:new_duration,
						   "New reservation INTERVAL is overlapping a pre-existing reservation's dates for this accomodation.")
			end
		end
	end
end
