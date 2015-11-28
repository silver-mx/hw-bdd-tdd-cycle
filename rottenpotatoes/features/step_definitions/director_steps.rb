
Given /the following movies exist:/ do |movies_table|
	movies_table.hashes.each {|movie| Movie.new(movie).save()}
end

Then /the director of "(.*)" should be "(.*)"/ do |movie_title, director|
	movie = Movie.find_by_title(movie_title)
	expect(movie.director).to eq(director)
end