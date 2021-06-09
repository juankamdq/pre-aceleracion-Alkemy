class MoviesController < ApplicationController

    #before_action :set_character 

    before_action :authorized, except: [:index, :show,]



  # Si tiene parametros muestra el detalle de Pelis buscado, con sus filtros.
  # Si no tiene paramtros muestra un listado de Pelis
  def index

    @movies = Movie.all

    if params[:title].present? || params[:order].present? || params[:idGenre].present?

      # Funcion que dependiendo los paramtros filtra la busqueda
      search
      render json: @movies, status: :ok, each_serializer: MovieDetailSerializer
    else
      render json: @movies , status: :ok, each_serializer: MovieListSerializer
    end
    
  end


  # Muestra el Detalle de las Peliculas, con los atributos y relaciones
  def detail
     @movies = Movie.all
     render json: @movies , status: :ok, each_serializer: MovieDetailSerializer
  end



  # Crea las peliculas
  def create
     @movie = Movie.new(films_params)
     
     gen_array = params[:gen_array]
     cha_array = params[:cha_array]
  
     
    if @movie.save 
      render json: @movie, status: :created
      
      # Si las pelicuas se guardan llamo a mi funcion para asociar las peliculas con la tabla Personajes y Generos
      add_association gen_array, cha_array
    else 
      render json: @movie.errors, status: :unprocessable_entity
    end

  end



  # Actualizar Peliculas
  def update
    @movie = Movie.find(params[:id])
    
    if @movie.update(films_params)
      render json: @movie, status: :ok
    else  
        render json: @movie.errors, status: :unprocessable_entity
    end
  end


  # Eliminar Peliculas
  def destroy

    @movie = Movie.find(params[:id])
    if @movie.destroy
      render json: {message: "Pelicula eliminada"}
    end

  end



  private
    
    # Solicitud de parametros
    def films_params
        params.require(:movie).permit(:title, :image, :date_created, :qualification)
    end



    # Funcion reutilizada para asociar Movies con Characters y/o Generos
    def add_association(gen_array, cha_array)
      
      if !gen_array.nil? 
        gen_array.each do |gen|
          if Genre.exists?(id: gen)
            @genre = Genre.find(gen)
            @movie.genres << @genre
          end
        end
     end

      if !cha_array.nil? 
        cha_array.each do |cha|
          if Character.exists?(id: cha)
            @character = Character.find(cha)
            @movie.characters << @character
          end
        end
      end

    end


  # Funcion que es reutilizada para ser llamada en #index
  def search 

    if params[:title].present?
      moviesFilter = @movies.where("title like ?","%#{params[:title]}%")
      @movies = moviesFilter
    end

    if params[:order].present?
      if params[:order] == "ASC" || "DESC"
        moviesFilter = @movies.order("date_created #{params[:order]}")
        @movies = moviesFilter
      end
    end

    
    #if params[:idGenre].present?
      #@movieFilter = @movies.joins("INNER JOIN movie_genres ON movie_genres.movie_id = movies.id where movie_genres.genre_id = 1")
      #@movies << @movieFilter
    #end

    if params[:idGenre].present?

      @movieFilter = []
      @movies.each do |mov|
        if mov.movie_genres.find_by(genre_id: params[:idGenre]) 
          @movieFilter << mov
        end    
      end
      @movies = @movieFilter
    end
  end
  

    


    #def set_character 
    #@character = Character.find(params[:character_id])


end
