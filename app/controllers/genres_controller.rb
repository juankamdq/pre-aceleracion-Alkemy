class GenresController < ApplicationController
    before_action :authorized, except: [:index]

    # Obtengo todos los Generos
    def index 
        @genres = Genre.all  
        render json: @genres, status: :ok
    end

    # Busco Generos por ID
    def show 
        @genre = Genre.find(params[:id])
        render json: @genre, status: :ok
    end

    # Crea un nuevo Genero
    def create 
        @genre = Genre.new(params_genre)

        if @genre.save 
            render json: @genre, status: :created 
        else  
            render json: { message: @genre.errors}, status: :unprocessable_entity 
        end
    end

    # Actualizo un solo Genero buscado por ID
    def update 
        @genre = Genre.find(params[:id])

        if @genre.update(params_genre)
            render json: @genre, status: :ok 
        else  
            render json: { message: @genre.errors}, status: :unprocessable_entity 
        end 
    end


    # Elimino un solo Genero buscado por ID
    def destroy 
        @genre = Genre.find(params[:id])

    
        if @genre.destroy 
            render json: { message: "Genero eliminado"}
        end
    end

    private 

    def params_genre
        params.require(:genre).permit(:name,:image)   
    end
end
