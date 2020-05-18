# MongoDB datasource
  
## Instal plugin
https://github.com/JamesOsgood/mongodb-grafana
```shell script
cd plugins
git clone git@github.com:JamesOsgood/mongodb-grafana.git
cd ..
```

## Run
```shell script
docker-compose up -d
```

## Feed collection
```mongojs
db.accounts.insertMany([
    { "dateint": 20200510, "nb": 5 },
    { "dateint": 20200511, "nb": 14 },
    { "dateint": 20200512, "nb": 5 },
    { "dateint": 20200513, "nb": 21 },
    { "dateint": 20200514, "nb": 11 },
    { "dateint": 20200515, "nb": 28 }
])
```

## Grafana dashboard
```shell script
http://localhost:3000
```

## Grafana datasources
```text
URL: http://mongods:3333
Access: Server
MongoDB URL: mongodb://mongo:27017
```

## Query
```mongojs
db.accounts.aggregate([
    { "$sort" : { "dateint" : 1 } },
    { "$project": {
        "name": "value",
        "value": "$nb",
        "ts": {
            "$dateFromString": {
                 "dateString":  { 
                    "$convert": { "input": "$dateint", "to": "string" } 
                 },
                 "format": "%Y%m%d"
             }
        },
        "_id": 0
    }}
])
```