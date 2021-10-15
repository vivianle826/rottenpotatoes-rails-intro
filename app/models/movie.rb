class Movie < ActiveRecord::Base
  
  def self.with_ratings(ratings_list)
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
    if ratings_list.kind_of?(Array)==true 
      byebug
      Movie.where(rating: ratings_list)
    else 
      Movie.all 
    end 
  end 
end
