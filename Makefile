citibike.json:
	curl -o citibike.json 'https://www.citibikenyc.com/stations/json'
	
build-csv: citibike.json
	cat citibike.json  | jq '.stationBeanList[]' | jq -r '[.latitude, .longitude, .stationName] | @csv' > citibike_stations.csv
	
clean:
	rm *.json
	rm *.csv