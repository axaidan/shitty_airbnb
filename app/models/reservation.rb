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

=begin
	def duration
		(start_date - end_date).day
	end
=end

	private
	def dates_are_valid
		errors.add(:start_date, "End Date is before Start Date") unless	start_date < end_date	
	end
end
