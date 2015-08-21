citibike.json:
	curl -o citibike.json 'https://www.citibikenyc.com/stations/json'

201501-citibike-tripdata.zip:
	curl -o  201501-citibike-tripdata.zip 'https://s3.amazonaws.com/tripdata/201501-citibike-tripdata.zip'
	
201502-citibike-tripdata.zip:
	curl -o  201502-citibike-tripdata.zip 'https://s3.amazonaws.com/tripdata/201502-citibike-tripdata.zip'

201503-citibike-tripdata.zip:
	curl -o  201503-citibike-tripdata.zip 'https://s3.amazonaws.com/tripdata/201503-citibike-tripdata.zip'

201504-citibike-tripdata.zip:
	curl -o  201504-citibike-tripdata.zip 'https://s3.amazonaws.com/tripdata/201504-citibike-tripdata.zip'

201505-citibike-tripdata.zip:
	curl -o  201505-citibike-tripdata.zip 'https://s3.amazonaws.com/tripdata/201505-citibike-tripdata.zip'

201506-citibike-tripdata.zip:
	curl -o  201506-citibike-tripdata.zip 'https://s3.amazonaws.com/tripdata/201506-citibike-tripdata.zip'

	
build-csv: citibike.json
	cat citibike.json  | jq '.stationBeanList[]' | jq -r '[.latitude, .longitude, .stationName] | @csv' > citibike_stations.csv
	
pull-trip-data: 201501-citibike-tripdata.zip 201506-citibike-tripdata.zip  201502-citibike-tripdata.zip 201503-citibike-tripdata.zip 201504-citibike-tripdata.zip 201505-citibike-tripdata.zip
	find . -name "*.zip" -print0 | xargs -0 -n1 unzip
	rm *.zip

concat-files: pull-trip-data
	find . -name "*citibike-tripdata.csv" -print0 | xargs -0 cat > trip_data.csv
	
clean:
	rm *.json
	rm *.csv