curl --include --request PATCH "http://localhost:4741/orders/${ID}" \
  --header "Content-Type: application/json" \
  --data '{
    "order": {
      "status": "'"${STATUS}"'"
    }
  }'
