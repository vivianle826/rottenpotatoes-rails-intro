 class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index 
    @all_ratings = Movie.all_ratings
    if params[:ratings] != nil
      session[:ratings] = params[:ratings]
    end 
    if session[:ratings]==nil
      @movies = Movie.all 
      @ratings_to_show =[]
    else
      @movies = Movie.with_ratings(session[:ratings].keys)
      @ratings_to_show = session[:ratings].keys 
    end 
    sort = params[:sort] || session[:sort]
    if params[:sort] != nil 
      session[:sort] = params[:sort]
    end 
    if sort == "title"
      @title_header = 'p-3 mb-2 bg-warning text-dark'
      @movies = @movies.sorted_by_name 
    elsif sort == 'date'
      @release_date_header = 'p-3 mb-2 bg-warning text-dark'
      @movies = @movies.sorted_by_date 
    end
  end 
    
    #byebug
      
#    if sort == nil
#      if params[:ratings]==nil
#        @movies = Movie.all 
#        @ratings_to_show =[]
#      else    
#        @movies = Movie.with_ratings(params[:ratings].keys)
#        @ratings_to_show = params[:ratings].keys 
#      end 
#    elsif sort == "title"
 #     @title_header = 'p-3 mb-2 bg-warning text-dark'
#      if params[:ratings]==nil
#        @movies = Movie.sorted_by_name 
#        @ratings_to_show =[]
#      else 
#        @movies = Movie.with_ratings(params[:ratings].keys).sorted_by_name
#        @ratings_to_show = params[:ratings].keys
#      end 
#    elsif sort == "date"
#      @release_date_header = 'p-3 mb-2 bg-warning text-dark'
#      if params[:ratings]==nil
#        @movies = Movie.sorted_by_date
#        @ratings_to_show =[]
#      else 
#        @movies = Movie.with_ratings(params[:ratings].keys).sorted_by_name
#        @ratings_to_show = params[:ratings].keys
 #     end 
  #  elsif params[:ratings]==nil
  #    @movies = Movie.all 
  #    @ratings_to_show =[]
  #  else    
  #    @movies = Movie.with_ratings(params[:ratings].keys)
      #@ratings_to_show = Movie.with_ratings(params[:ratings].keys)
#    end 
    
#    if params[:ratings]==nil
#      @ratings_to_show =[]
#    else 
#      @ratings_to_show = Movie.with_ratings(params[:ratings].keys)
#    end
    
#  end
      
      

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end