class Character < ApplicationRecord
    has_many :character_movies, dependent: :destroy
    has_many :movies, through: :character_movies

    validates :name, :image, :age, :weight, :story, presence: true 

    validates :name, length: { minimum: 4 }
    validates :story, length: { minimum: 10 }
end
