require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
	before do
		Movie.new({:title => 'Star Wars', :director => 'George Lucas', :rating => 'R'}).save
		Movie.new({:title => 'Alien', :rating => 'R'}).save
		Movie.new({:title => 'Blade Runner', :director => 'Ridley Scott', :rating => 'R'}).save
		Movie.new({:title => 'THX-1138', :director => 'George Lucas', :rating => 'R'}).save
	end 

	describe 'get find_by_director' do

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

	describe 'index' do 
		let!(:ratings_param) {{'G'=>'G', 'NC-17'=>'NC-17', 'PG'=>'PG', 'PG-13'=>'PG-13', 'R'=>'R'}}

		before do 
			session[:ratings] = ratings_param
		end

		it 'when sorts @movies by title' do
			sort_param = 'title'
			session[:sort] = sort_param
			get :index, {:sort => sort_param, :ratings => ratings_param}
			expected_movies = Movie.where(rating: ratings_param.keys).order(sort_param)

			expect(assigns(:movies).to_a).to eq(expected_movies)
		end

		it 'when sorts @movies by release_date' do
			sort_param = 'release_date'
			session[:sort] = sort_param
			get :index, {:sort => sort_param, :ratings => ratings_param}
			expected_movies = Movie.where(rating: ratings_param.keys).order(sort_param)

			expect(assigns(:movies).to_a).to eq(expected_movies)

		end

		it 'when redirects' do
			sort_param = 'release_date'
			get :index, {:sort => sort_param, :ratings => ratings_param}
			
			expect(response).to redirect_to(movies_path(:sort => sort_param, :ratings => ratings_param))
		end
	end

	describe 'create' do
		it 'creates a movie' do
			post :create, movie: {:title => 'Stand by me', :rating => 'PG-13'}
			expect(Movie.find_by(title: 'Stand by me').title).to eq('Stand by me')
		end
	end
end
