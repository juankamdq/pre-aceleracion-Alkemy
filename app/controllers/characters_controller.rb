class CharactersController < ApplicationController

    before_action :authorized, except: [:index, :detail]

    def index 

        @characters = Character.all

        # Si hay al menos un caracter hace la llamada a la funcion SEARCH. Caso contrario solo muestra un Listado
        if params[:name].present? || params[:age].present? || params[:idMovie].present?
            search
        else
            render json: @characters, each_serializer: CharacterListSerializer
        end
    end

    # Muestra detalle de los actores con sus correspondientes peliculas
    def detail
        @characters = Character.all
        render json: @characters, each_serializer: CharacterDetailSerializer 
    end


    # Creo el actor
    def create
        @character = Character.new(character_params)
        
        if @character.save
            render json: @character, status: :created
        else  
            render json: @character.errors
        end
    end


    def update
        @character = Character.find(params[:id])

    
        if @character.update(character_params)
            render json: @character, status: :ok
        else
            render status: 401
        end

    end



    def destroy
        @character = Character.find(params[:id])
        
        if @character.destroy
            render json: {message: "Personaje eliminado"}
        else  
            render status: 404
        end
    end
   

    def search

            if params[:name].present?
                characterFilter = @characters.where("name like ?", "%#{params[:name]}%")
                @characters = characterFilter
            end

            if params[:age].present?
                characterFilter = @characters.where("age = ?", "#{params[:age]}")
                @characters = characterFilter
            end

            #CORREGIR!!!!!!!!!!!!!!!!!!!!!
            if params[:idMovie].present?
                characterFilter = @characters.joins("INNER JOIN character_movies ON character_movies.character_id = characters.id where character_movies.movie_id = #{params[:idMovie]}")
                @characters = characterFilter
            end
         
        render json: @characters, status: :ok ,each_serializer: CharacterDetailSerializer
        
    end

    private
    

    def character_params
        params.require(:character).permit(:name, :image, :age, :weight, :story)
    end

    def set_character 
        @movie = Movie.find(params[:film_id])
    end
end
