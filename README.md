# MongoDB datasource
  
## Run
```shell script
docker-compose up -d
```

## Feed collection
### MongoDB
```shell script
$ cd fixtures
$ ./mongo_create_example_dataset.sh
```
### PostgreSQL
//TODO

## Grafana dashboard
```shell script
http://localhost:3000
```

## Grafana datasources
### MongoDB
```text
URL: http://mongods:3333
Access: Server
MongoDB URL: mongodb://mongo:27017
MongoDB Database: example
```
### PostgreSQL
```text
Host: postgres:5432
Database: database
User: admin
Password: admin
SSL Mode: disable
Version: 10
```

## Queries
### MongoDB example data set 
```mongojs
db.data.aggregate ([ 
    { "$match": { "date": { "$gte" : "$from", "$lte" : "$to" } } },        
    { "$sort": {"date": 1} },            
    { "$project": { "name": "$set", "value": "$val", "ts": "$date", "_id": 0} } 
])
```
An example of converting other types to date type:
```json
"ts": {
    "$dateFromString": {
         "dateString":  { 
            "$convert": { "input": "$dateint", "to": "string" } 
         },
         "format": "%Y%m%d"
     }
}
```