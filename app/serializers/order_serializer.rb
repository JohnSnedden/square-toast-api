class OrderSerializer < ActiveModel::Serializer
  attributes :id, :date, :status, :description, :price, :user_id, :created_at, :updated_at
  has_one :user
end
