Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')

  get 'movies/director/:director', :to => 'movies#find_by_director'

end
