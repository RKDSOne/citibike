#
#
# Thanks
# http://blog.dominodatalab.com/geographic-visualization-with-rs-ggmaps/
#
#

library(ggmap)
library(plyr)

scaling_factor <- 10

if(!exists("tripData")){
  tripData <- read.csv("201501-citibike-tripdata.csv")
}

#print(summary(tripData))
#print(names(tripData))

trips = data.frame(tripData$start.station.latitude, 
                   tripData$start.station.longitude, 
                   tripData$start.station.id)

colnames(trips) = c('lat','lon','stations') 
trips$count <- 1
trips.sum <- ddply(trips, c("lat","lon","stations"), summarize, count = sum(count))
print(head(trips.sum))
trips.sum$size <- scaling_factor*trips.sum$count / max(trips.sum$count)


LES = as.numeric(geocode("Lower East Side"))
MANHATTAN = ggmap(get_googlemap(center=LES, scale=1, zoom=13), extent="normal")
MANHATTAN <- MANHATTAN + 
  geom_point(aes(x=lon, y=lat), data=trips.sum, col="red", alpha=.5, size=trips.sum$size)
print(MANHATTAN)


png(filename="start_station_popularity.png",width=1000,height=1000)
plot(MANHATTAN)
dev.off()

