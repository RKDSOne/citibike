citibike.json:
	curl -o citibike.json 'https://www.citibikenyc.com/stations/json'

201501-citibike-tripdata.zip:
	curl -o  201501-citibike-tripdata.zip 'https://s3.amazonaws.com/tripdata/201501-citibike-tripdata.zip'

201502-citibike-tripdata.zip:
	curl -o  201502-citibike-tripdata.zip 'https://s3.amazonaws.com/tripdata/201502-citibike-tripdata.zip'
	
build-csv: citibike.json
	cat citibike.json  | jq '.stationBeanList[]' | jq -r '[.latitude, .longitude, .stationName] | @csv' > citibike_stations.csv
	
build-trip: 201501-citibike-tripdata.zip 201502-citibike-tripdata.zip
	ls *.zip | xargs unzip
	rm *.zip
	
clean:
	rm *.json
	rm *.csv