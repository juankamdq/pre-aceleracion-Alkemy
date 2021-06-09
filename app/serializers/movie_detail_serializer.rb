class MovieDetailSerializer < ActiveModel::Serializer
  attributes :id, :title, :image, :date_created, :qualification

 
  has_many :genres
  has_many :characters
end
