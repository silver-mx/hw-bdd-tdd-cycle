require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

	describe 'get find_by_director' do

		before do
			Movie.new({:title => 'Star Wars', :director => 'George Lucas'}).save
			Movie.new({:title => 'Alien'}).save
			Movie.new({:title => 'Blade Runner', :director => 'Ridley Scott'}).save
			Movie.new({:title => 'THX-1138', :director => 'George Lucas'}).save
		end 

		context 'when params[:director] == "George Lucas"' do
			let!(:director) {'George Lucas'}

			before {get :find_by_director, {:director => director, :title => 'THX-1138'}}
			
			it 'assigns @movies' do
				expected_movies = Movie.where(:director => director)
				expect(assigns(:movies).size).to be(2)
				expect(assigns(:movies)).to eq(expected_movies)
			end

			it 'renders the find_by_director template' do
				expect(response).to render_template('find_by_director')
			end
		end


		context 'when director param is not provided' do
			let!(:title) {'Alien'}
			before {get :find_by_director, {:director => 'nil', :title => title }}

			it 'redirects to home page' do
				expect(response).to redirect_to(:action => :index)
			end

			it 'sets flash message' do
				expect(flash[:no_director_found_message]).to eq("'#{title}' has no director info")
			end
		end
	end
end
