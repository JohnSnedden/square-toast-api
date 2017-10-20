class OrderSerializer < ActiveModel::Serializer
  attributes :id, :date, :status, :description, :price, :created_at, :updated_at
end
