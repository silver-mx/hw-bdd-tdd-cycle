require 'rails_helper'

RSpec.describe Movie, type: :model do
  
	describe '#where' do 

		before do
			Movie.new({:title => 'Star Wars', :director => 'George Lucas'}).save
			Movie.new({:title => 'Alien'}).save
			Movie.new({:title => 'Blade Runner', :director => 'Ridley Scott'}).save
			Movie.new({:title => 'THX-1138', :director => 'George Lucas'}).save
		end

		context 'given a director' do
			let!(:movies) {Movie.where(:director => 'George Lucas')}
			
			it 'returns two movies' do
				expect(movies.size).to be(2)
				movies.each {|movie| expect(movie.director).to eq('George Lucas')}
			end
		end

		context 'given two directors' do
			let!(:movies) {Movie.where("director = 'George Lucas' AND director = 'Ridley Scott'")}
			
			it 'returns zero movies' do
				expect(movies.size).to be(0)
			end
		end
	end
end
