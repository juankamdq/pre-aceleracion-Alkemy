class MovieListSerializer < ActiveModel::Serializer
  attributes :image, :title, :date_created
end
