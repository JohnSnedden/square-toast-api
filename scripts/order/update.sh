curl --include --request PATCH "http://localhost:4741/orders/${ID}" \
  --header "Content-Type: application/json" \
  --data '{
    "order": {
      "date": "'"${DATE}"'",
      "status": "'"${STATUS}"'",
      "description": "'"${DESCRIPTION}"'",
      "price": "'"${PRICE}"'"
    }
  }'
