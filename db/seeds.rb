# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
City.destroy_all
Accomodation.destroy_all
Reservation.destroy_all

#CUSTOM ARRAY FOR SEED
zip_code_arr = []
50.times do
	zip_code_arr << rand(10000..99999).to_s
end
phone_arr = []
50.times do
	phone_arr << "01" + rand(10000000..99999999).to_s
end

#USER
20.times do
	User.create(email: Faker::Internet.email, phone: phone_arr[rand(0..49)], desc: Faker::Lorem.sentence)
end

#CITY
10.times do
	City.create(name: Faker::Address.city, zip_code: zip_code_arr[rand(0..49)])
end

#ACCOMODATION
User.all.each do |admin|
	5.times do 
		Accomodation.create(city: City.all[rand(0..9)], admin: admin, has_wifi?: Faker::Boolean.boolean, price: rand(15..80), beds: rand(1..4), desc: Faker::Lorem.words(number: 120).join(' '), welcome: Faker::Quote.famous_last_words)
	end
end

#RESERVATION
Accomodation.all.each do |accomodation|
	#FUTURE RESERVATION
	10.times do 
		admin1 = User.all[rand(0..19)]
		faker_start = Faker::Date.between(from: 1.days.from_now, to: 8.days.from_now)
		Reservation.create(guest: User.all[rand(0..19)], 
						   accomodation: admin1.accomodations.all[rand(0..(admin1.accomodations.all.count - 1))], 
						   start_date: faker_start, 
						   end_date: Faker::Date.between(from: faker_start + 2.day, to: faker_start + 10.day))
	end

=begin
	#PAST RESERVATION
	rand(4..7).times do
		Reservation.create()

	end
=end
end
