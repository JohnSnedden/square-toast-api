# Square Toast - API

This repo project is an API and database for a simple Point of Sale (POS) system.
A second repo exists for a [corresponding web client](https://github.com/JohnSnedden/square-toast-client)

Below follows background information, you can also just skip ahead to the [API Docs](#) if you like.


## Background
This is my second project as part of the General Assembly [Web Development Immersive](https://generalassemb.ly/education/web-development-immersive) program.

We were given the freedom to choose what to develop as long as it met the following requirements/specifications:

#### Deployment
Be deployed online, where the rest of the world can access it.
1. Deploy client application on GH pages.
2. Deploy server application on Heroku.

#### Auth Specifications
1. Signup with email, password, and password confirmation.
1. Login with email and password.
2. Logout when logged in.
3. Change password with current and new password.
4. Give feedback to the user after each action's success or failure.

#### Client Specifications
1.  Use a front-end Javascript app to communicate with your API (both read and write) and render data that it receives in the browser.
2. Have semantically clean HTML and CSS
3. User must be able to create a new resource
4. User must be able to update a resource
5. User must be able to delete a resource
6. User must be able to view a single or multiple resource(s)
7. Give feedback to the user after each action's success or failure.

#### API Specifications
1. Create at least 4 RESTful routes for handling GET, POST, PUT/PATCH, and DELETE requests.
2. Any actions which change data must be authenticated and the data must be "owned" by the user performing the change.
3. Utilize an ORM to create a database table structure and interact with data
4. Have at least 1 resource that has a relationship to User


I chose to develop a simple POS based on my interest and experience with order processes and systems.

Earlier in my career I worked with [SAP order to cash](https://www.sap.com/products/enterprise-management-erp/order-to-cash-module.html) product which gave me a lot of exposure to that database and the associated processes.

More recently I've worked with some saas order systems such as [Shopify](https://www.shopify.com/pos), [Square](https://squareup.com/pos), and [Vend](https://www.vendhq.com/us/).
I also have an interest in the [Toast](https://pos.toasttab.com/) product.


## My Planning and Development Process, and Problem Solving Strategy
I started by putting my initial thoughts about a POS system into a [mind map](https://drive.google.com/open?id=0B_T6q5vZjOqcQTBWTDNudTFQcHc).
This helped me organicze my various thoughts and from that I was able to start to conceptulize what my ERD might look like.

I then created an [ERD](https://drive.google.com/open?id=0B_T6q5vZjOqcRVF0UlotQ1gxSWM).
The ERD builds upon its self for what I thought would be five clear stages of product development.


## Wireframes
Initial low-res hand sketch wireframes can be located [here](https://photos.app.goo.gl/ENLFeQ9wKtaOLayH2)


## User Stories
I utilized a [Trello board](https://trello.com/b/WOcJ8Bqd) to keep track of my user stories, progress, and bugs/issues during initial development. After initial development is complete I will switch to using the [GitHub repo issues list](https://github.com/JohnSnedden/square-toast-api/issues) for ongoing issue management.


## Built With

* Ruby on Rails


## Unsolved Problems

* I'm not entirely happy with the lack of company component in this initial version. With the current setup multiple users can not share orders, like they might if they were working at the same food service establishment.


## Future Development

There is a lot of scope for building out this product.
To begin with I'd like to add the following resources and incorporate them into the database and API:
* Company - Enables users to belong to one or more companies, and orders to belong to a single company.
* Company authorization - Allow users to view/edit all orders for all companies they are connected to.
* Order Items - Allow each order to have multiple items.
* Products - Predefined products which can entered into orders.
* Customer - Allow orders to be associated witha customer.

Beyond the above items I have many more concepts on the initial mind map which can be assessed for product market fit and feasibility based on user feedabck.



## API

Scripts are included in [`scripts`](scripts) to test built-in actions.

### Authentication

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| PATCH  | `/change-password/:id` | `users#changepw`  |
| DELETE | `/sign-out/:id`        | `users#signout`   |

#### POST /sign-up

Request:

```sh
curl http://localhost:4741/sign-up \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'",
      "password_confirmation": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah scripts/auth/sign-up.sh
```

Response:

```md
HTTP/1.1 201 Created
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com"
  }
}
```

#### POST /sign-in

Request:

```sh
curl http://localhost:4741/sign-in \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=ava@bob.com PASSWORD=hannah scripts/auth/sign-in.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "ava@bob.com",
    "token": "BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f"
  }
}
```

#### PATCH /change-password/:id

Request:

```sh
curl --include --request PATCH "http://localhost:4741/change-password/$ID" \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
    "passwords": {
      "old": "'"${OLDPW}"'",
      "new": "'"${NEWPW}"'"
    }
  }'
```

```sh
ID=1 OLDPW=hannah NEWPW=elle TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/auth/change-password.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

#### DELETE /sign-out/:id

Request:

```sh
curl http://localhost:4741/sign-out/$ID \
  --include \
  --request DELETE \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=1 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/auth/sign-out.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

### Users

| Verb | URI Pattern | Controller#Action |
|------|-------------|-------------------|
| GET  | `/users`    | `users#index`     |
| GET  | `/users/1`  | `users#show`      |

#### GET /users

Request:

```sh
curl http://localhost:4741/users \
  --include \
  --request GET \
  --header "Authorization: Token token=$TOKEN"
```

```sh
TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/users/users.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "users": [
    {
      "id": 2,
      "email": "bob@ava.com"
    },
    {
      "id": 1,
      "email": "ava@bob.com"
    }
  ]
}
```

#### GET /users/:id

Request:

```sh
curl --include --request GET http://localhost:4741/users/$ID \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=2 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/users/user.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 2,
    "email": "bob@ava.com"
  }
}
```

### Orders

| Verb   | URI Pattern | Controller#Action |
|--------|-------------|-------------------|
| GET    | `/orders`   | `orders#index`    |
| GET    | `/orders/1` | `orders#show`     |
| POST   | `/orders`   | `orders#create`   |
| PATCH  | `/orders/1` | `orders#update`   |
| DELETE | `/orders/1` | `orders#destroy`  |

#### GET /orders

Request:

```sh
curl http://localhost:4741/orders \
  --include \
  --request GET \
  --header "Authorization: Token token=$TOKEN"
```

```sh
TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/order/orders.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "orders": [
    {
      "id": 21,
      "date": "2017-10-20",
      "status": "open",
      "description": "rice bowl with chicken",
      "price": "10.0",
      "user_id": 1
    },
    {
      "id": 22,
      "date": "2017-10-20",
      "status": "open",
      "description": "bacon milkshake",
      "price": "6.5",
      "user_id": 1
    }
  ]
}
```

#### GET /orders/:id

Request:

```sh
curl --include --request GET http://localhost:4741/orders/$ID \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=61 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/orders/show.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "order": {
    "id": 61,
    "date": "2017-10-23",
    "status": "Open",
    "description": "carnitas bowl + rice",
    "price": "9.5",
    "user_id": 1
  }
}
```

#### POST /orders

Request:

```sh
curl http://localhost:4741/orders \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "order": {
      "date": "'"${DATE}"'",
      "status": "'"${STATUS}"'",
      "description": "'"${DESCRIPTION}"'",
      "price": "'"${PRICE}"'"
    }
  }'
```

```sh
DATE="2017-10-15" STATUS="open" DESCRIPTION="wood fired pizza" PRICE="11.50" TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/order/create.sh
```

Response:

```md
HTTP/1.1 201 Created
Content-Type: application/json; charset=utf-8

{
  "order": {
    "id": 26,
    "date": "2017-10-15",
    "status": "open",
    "description": "wood fired pizza",
    "price": "11.5",
    "user_id": 1,
  }
}
```

#### PATCH /orders/:id

Request:

```sh
curl --include --request PATCH "http://localhost:4741/orders/$ID" \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
    "order": {
      "date": "'"${DATE}"'",
      "status": "'"${STATUS}"'",
      "description": "'"${DESCRIPTION}"'",
      "price": "'"${PRICE}"'"
    }
  }'
```

```sh
ID=64 DATE="2017-10-24" STATUS="Open" DESCRIPTION="All you can eat pancakes" PRICE="19.00" TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/order/update.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "order": {
    "id": 64,
    "date": "2017-10-24",
    "status": "Open",
    "description": "All you can eat pancakes",
    "price": "19.0",
    "user_id": 1,
  }
}
```

#### DELETE /orders/:id

Request:

```sh
curl http://localhost:4741/orders/$ID \
  --include \
  --request DELETE \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=1 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/order/destroy.sh
```

Response:

```md
HTTP/1.1 204 No Content
```
