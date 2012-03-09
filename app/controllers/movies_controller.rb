class MoviesController < ApplicationController
  helper_method :sort_column, :sort_direction, :array_to_hash
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    column = sort_column
    direction = sort_direction
    @all_ratings = Movie.valid_ratings 
    @ratings = filter_ratings
    session_ratings = session_ratings
    if (!params.include?(:ratings) && !params.include?(:sort))
      mp = array_to_hash(session_ratings)
      mp[:sort] = column
      redirect_to movies_path(mp)
    else
      session[:ratings] = @ratings
      session[:sort] = column
      @movies = @ratings.empty? ? Movie.order(column + " " + direction) : Movie.order(column + " " + direction).where(:rating => @ratings)      
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
  
  
  def sort_column(ar=nil)
    ar = params if ar == nil
    Movie.column_names.include?(ar[:sort]) ? ar[:sort] : "title"
  end
    
  def filter_ratings(ar=nil)
    ar = params if ar == nil
    r = ar[:ratings]
    r == nil ? [] : r.keys & Movie.valid_ratings
  end
  
  def session_ratings()
    r = session[:ratings]
    r & Movie.valid_ratings
  end
  
  def sort_direction
    #%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    "asc"
  end
  
    
  def array_to_hash(a)
    Hash[*a.collect { |v| [v, v*2] }.flatten]
  end


end
