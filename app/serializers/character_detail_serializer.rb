class CharacterDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :age, :weight
  
  has_many :movies
end
