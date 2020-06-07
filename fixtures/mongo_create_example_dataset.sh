#!/bin/bash

BACK_DAYS=30
DATA_FILE_NAME='mongo_example_data.json'

echo -n "" > ./$DATA_FILE_NAME
SUB_DAYS=$BACK_DAYS
while [ $SUB_DAYS != -1 ]
do
  DATE_STRING=$(date --date="$SUB_DAYS days ago" +%Y-%m-%d)
  ((SUB_DAYS--))
  echo '{ "date": {"$date": "'$DATE_STRING'T00:00:00.000Z"}, "set": "first", "val": '$(( $RANDOM % 1000 ))' }' >> ./$DATA_FILE_NAME
  echo '{ "date": {"$date": "'$DATE_STRING'T00:00:00.000Z"}, "set": "second", "val": '$(( $RANDOM % 1000 ))' }' >> ./$DATA_FILE_NAME
  echo '{ "date": {"$date": "'$DATE_STRING'T00:00:00.000Z"}, "set": "third", "val": '$(( $RANDOM % 1000 ))' }' >> ./$DATA_FILE_NAME
done
docker exec gtest-mongo sh -c 'exec mongoimport --db example --collection data --drop --file /fixtures/'$DATA_FILE_NAME
exit 0