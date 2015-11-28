require 'rails_helper'

RSpec.describe Movie, type: :model do
  
	describe '#where' do 
		context 'given a director' do
			movies = Movie.where(:director => 'George Lucas')
			it 'returns two movies' do 
				movies.each {|movie| expect(movie.director).to eq('George Lucas')}
			end
		end

		context 'given two directors' do
			movies = Movie.where("director = 'George Lucas' AND director = 'Ridley Scott'")
			it 'returns zero movies' do
				expect(movies.size).to be(0)
			end
		end
	end
end
