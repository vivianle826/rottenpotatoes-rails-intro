class Movie < ActiveRecord::Base
  
  def self.all_ratings
    Movie.all 
  end 
end
