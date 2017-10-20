curl --include --request POST "http://localhost:4741/orders" \
  --header "Content-Type: application/json" \
  --data '{
    "order": {
      "date": "'"${DATE}"'",
      "status": "'"${STATUS}"'",
      "description": "'"${DESCRIPTION}"'",
      "price": "'"${PRICE}"'"
    }
  }'
