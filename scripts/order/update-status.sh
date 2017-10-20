curl --include --request PATCH "http://localhost:4741/orders/${ID}" \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "order": {
      "status": "'"${STATUS}"'"
    }
  }'
