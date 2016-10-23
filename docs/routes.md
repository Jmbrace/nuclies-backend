### Authentication rouets

## Create a new volunteer
# POST to https://nuclius-backend.herokuapp.com/auth
NOTE password must be at least 8 characters!
request body
```{
	"email": "theemail@gmail.com",
	"password": "12345678",
	"password_confirmation": "12345678"
}```

response

```{
  "status": "success",
  "data": {
    "id": 1,
    "provider": "email",
    "uid": "theemail@gmail.com",
    "name": null,
    "nickname": null,
    "image": null,
    "email": "theemail@gmail.com",
    "created_at": "2016-10-22T22:41:48.280Z",
    "updated_at": "2016-10-22T22:41:48.507Z",
    "services": "--- []\n"
  }
}```

## Set a volunteers services
# POST to https://nuclius-backend.herokuapp.com/setservice
request body
```{
	"email": "theemail@gmail.com",
	"password": "12345678",
	"password_confirmation": "12345678"
}```

response

```{
  "status": "success",
  "data": {
    "id": 1,
    "provider": "email",
    "uid": "theemail@gmail.com",
    "name": null,
    "nickname": null,
    "image": null,
    "email": "theemail@gmail.com",
    "created_at": "2016-10-22T22:41:48.280Z",
    "updated_at": "2016-10-22T22:41:48.507Z",
    "services": "--- []\n"
  }
}```


## Sign in as a volunteer
# POST to https://nuclius-backend.herokuapp.com/auth/sign_in
request body
```{
	"email": "theemail@gmail.com",
	"password": "123456"
}```

response

```
{
  "data": {
    "id": 1,
    "provider": "email",
    "uid": "theemail@gmail.com",
    "name": null,
    "nickname": null,
    "image": null,
    "email": "theemail@gmail.com",
    "services": "--- []\n"
  }
}
```

## Sign in as a person in need, on mobile
# POST to https://nuclius-backend.herokuapp.com/mobile/sign_in
request body
```{
	"first_name": "bob",
	"last_name": "joe",
	"last4_ssn": 1234
}```

response 
If they do not have an account
```
{
  "success": false
}
```

If they do have an account
```{
  "success": true,
  "services": ["legal", "custom"]
}```

## Add a service that a person in need, needs
# POST to https://nuclius-backend.herokuapp.com/inneed/services
request body
```{"services":{
	    "names": ["housing", "legal", "utilities"],
	    "descriptions": ["I am currently without a home, i need a place to stay for the night", "I got into a blah blah blah and need legal advice", "I need to pay a car payment"],
	    "in_need_id": 1
	}
}```

response
```
{
  "services": [
    {
      "id": 1,
      "name": "housing",
      "volunteer_id": -1,
      "being_served": false,
      "created_at": "2016-10-23T00:38:02.132Z",
      "updated_at": "2016-10-23T00:38:02.132Z",
      "description": "I am currently without a home, i need a place to stay for the night",
      "in_need_id": 1
    },
    {
      "id": 2,
      "name": "legal",
      "volunteer_id": -1,
      "being_served": false,
      "created_at": "2016-10-23T00:38:02.147Z",
      "updated_at": "2016-10-23T00:38:02.147Z",
      "description": "I got into a blah blah blah and need legal advice",
      "in_need_id": 1
    },
    {
      "id": 3,
      "name": "utilities",
      "volunteer_id": -1,
      "being_served": false,
      "created_at": "2016-10-23T00:38:02.152Z",
      "updated_at": "2016-10-23T00:38:02.152Z",
      "description": "I need to pay a car payment",
      "in_need_id": 1
    }
  ]
}
```

## Delete a service that a person in need, needs
# DELETE to https://nuclius-backend.herokuapp.com/inneed/services
request body
```{	"services":{
	    "names": ["legal", "utilities"],
	    "in_need_id": 1
	}
}```

response (the remaining services will be returned)
```
{
  "services": [
    {
      "id": 1,
      "name": "housing",
      "volunteer_id": -1,
      "being_served": false,
      "created_at": "2016-10-23T00:38:02.132Z",
      "updated_at": "2016-10-23T00:38:02.132Z",
      "description": "I am currently without a home, i need a place to stay for the night",
      "in_need_id": 1
    }
  ]
}
```



## Mark a Service as being served by a volunteer
# POST to https://nuclius-backend.herokuapp.com/markservice
request body
```{
	 "name": "legal",
	 "volunteer_id": 1,
	 "in_need_id": 1
}```

response, if the service was found

```
{
  "service": {
    "id": 11,
    "name": "legal",
    "volunteer_id": 1,
    "being_served": true,
    "created_at": "2016-10-23T01:02:28.149Z",
    "updated_at": "2016-10-23T01:02:43.802Z",
    "description": "I got into a blah blah blah and need legal advice",
    "in_need_id": 1
  }
}
```

if the service was not found

```
{"service": null}
```

## UnMark a Service as being served by a volunteer
# DELETE to https://nuclius-backend.herokuapp.com/markservice
request body
```{
	 "name": "legal",
	 "volunteer_id": 1,
	 "in_need_id": 1
}```

response, if the service was found

```
{
  "service": {
    "id": 11,
    "name": "legal",
    "volunteer_id": -1,
    "being_served": false,
    "created_at": "2016-10-23T01:02:28.149Z",
    "updated_at": "2016-10-23T01:09:09.302Z",
    "description": "I got into a blah blah blah and need legal advice",
    "in_need_id": 1
  }
}
```

if the service was not found

```
{"service": null}
```

## Get all unmarked services that a given volunteer can match
# POST to https://nuclius-backend.herokuapp.com/getservices
request body

```
{
	 "volunteer_id": 1
}
```

response

