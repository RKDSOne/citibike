
library(ggmap)

data <- read.csv("citibike_stations.csv")
colnames(data) = c('lat','lon','name')  

usa_center = as.numeric(geocode("Lower East Side"))
MANHATTAN = ggmap(get_googlemap(center=usa_center, scale=1, zoom=12), extent="normal")
MANHATTAN <- MANHATTAN + 
  geom_point(aes(x=lon, y=lat), data=data, col="red", alpha=.5, size=3)
print(MANHATTAN)

png(filename="output/manhattan.png",width=1000,height=1000)
plot(MANHATTAN)
dev.off()



