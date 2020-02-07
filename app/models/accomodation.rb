class Accomodation < ApplicationRecord
	#CITY
	belongs_to :city

	#ADMIN
	belongs_to :admin, class_name: "User"
	
	#INTEGERS
	validates :price, numericality: {greater_than: 0}, presence: true
	validates :beds, numericality: {greater_than: 0}, presence: true

	#TEXT
	validates :desc, length: {minimum: 140}, presence: true
	validates :welcome, presence: true

	#WIFI
	#validates :has_wifi?, presence: true
	
	#RESERVATIONS
	has_many :reservations
end
