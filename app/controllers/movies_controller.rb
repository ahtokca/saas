class MoviesController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    column = sort_column
    direction = sort_direction
    @movie = Movie.order(column + " " + direction) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    order = params[:order]
    direction = params[:direction]
    @movies = Movie.find(:all, :order => "#{order} ASC")
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
  
  
  def sort_column()
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end
