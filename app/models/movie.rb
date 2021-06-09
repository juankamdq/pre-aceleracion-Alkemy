class Movie < ApplicationRecord
    has_many :character_movies, dependent: :destroy
    has_many :characters, through: :character_movies 
    has_many :movie_genres, dependent: :destroy
    has_many :genres, through: :movie_genres

 

    validates :image, :title, :date_created, :qualification, presence: true

    validates :title, uniqueness: { case_insensitive: false }, length: { minimum: 4}
    validates :qualification, inclusion: { in: (1..5), message: "Calificar de 1 a 5 estrellas"}
    

    # Genero un validador para que la fecha ingresada no supere a la actual
    validate :date_created_validity

    def date_created_validity
        return if date_created.blank? 
        return if date_created <= Date.today
        errors.add :date_created, "Fecha no puede superar a la actual"
    end
end
