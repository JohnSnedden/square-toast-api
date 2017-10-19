class OrderSerializer < ActiveModel::Serializer
  attributes :id, :date, :status, :description, :price
end
