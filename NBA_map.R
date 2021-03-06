#rm(list = ls())
setwd("/Users/Yuchong/Desktop/basketball/R4Fun")
library(ggplot2)
library(maps)
library(png)
library(grid)
library(ggmap)
library(jpeg)

all_states <- map_data("state")

df = read.csv("geoinfo.csv", header=TRUE)
visited <- c("Houston,TX","Los Angeles,CA","Brooklyn,NY","San Antonio,TX","New Orleans,LA","Oakland,CA","Sacramento,CA","Atlanta,GA","Memphis,TN","Oklahoma City,OK","Dallas,TX","Chicago,IL","Milwaukee,WI","Minneapolis,MN","Denver,CO","Salt Lake City,UT","Cleveland,OH","Phoenix,AZ","Washington,D.C.","Detroit,MI","Boston,MA","Orlando,FL","Miami,FL","Charlotte,NC")
#ll.visited <- geocode(visited)
ll.visited<-subset(df, city %in% visited)
visit.x <- ll.visited$lon
visit.y <- ll.visited$lat
non_visited<-c("Portland,OR","Indianapolis,IN","New York,NY","Philadelphia,PA","Toronto,ON")
#ll.non_visited <- geocode(non_visited)
ll.non_visited<-subset(df, !(city %in% visited))
non_visit.x <- ll.non_visited$lon
non_visit.y <- ll.non_visited$lat
city.all<-c("Houston,TX","Los Angeles,CA","Brooklyn,NY","San Antonio,TX","New Orleans,LA","Oakland,CA","Sacramento,CA","Atlanta,GA","Memphis,TN","Oklahoma City,OK","Dallas,TX","Chicago,IL","Milwaukee,WI","Minneapolis,MN","Denver,CO","Salt Lake City,UT","Portland,OR","Phoenix,AZ","Cleveland,OH","Indianapolis,IN","Detroit,MI","Boston,MA","New York,NY","Philadelphia,PA","Washington,D.C.","Charlotte,NC","Orlando,FL","Miami,FL","Toronto,ON")
ll.all <- rbind(ll.visited, ll.non_visited)
ll.all['city']=city.all
#write.csv(ll.all, file="geoinfo.csv",row.names = FALSE)


visit.label<-c("Rockets","Lakers","Nets","Spurs","Pelicans","Warriors","Kings","Hawks","Grizzlies","Thunder","Mavericks","Bulls","Bucks","Timberwolves","Nuggets","Jazz","Cavaliers",'Suns','Wizards','Pistons','Celtics','Magic','Heat','Hornets')
#p <- p+ geom_text(hjust=0.5, vjust=-0.5,aes(x=visit.x, y=visit.y,label=visit.label), size=3)
Team.visit <- data.frame(lon=visit.x,lat=visit.y,name=visit.label)
Team.nonvisit <-data.frame(lon=non_visit.x,lat=non_visit.y)
year.visit <- c(2014,2014,2015,2015,2016,2016,2016,2016,2016,2016,2016,2017,2017,2017,2018,2018,2018,2018,2019,2019,2019,2020,2020,2020)                         
Team.visit<-cbind(Team.visit,year.visit)
Team.visit$year.visit<-as.character(Team.visit$year.visit)

#mpmapWorld <- borders("world", colour="gray50", fill="gray50")
#mp <- ggplot() +   mapWorld
#mp

setwd("/Users/Yuchong/Desktop/basketball/R4Fun/images")

img_hou <- readPNG("hou.png")
img_lal <- readPNG("lal.png")
img_bkn <- readPNG("bkn.png")
img_sas <- readPNG("sas.png")
img_nop <- readPNG("nop.png")
img_gsw <- readPNG("gsw.png")
img_sac <- readPNG("sac.png")
img_atl <- readPNG("atl.png")
img_mem <- readPNG("mem.png")
img_okc <- readPNG("okc.png")
img_dal <- readPNG("dal.png")
img_chi <- readPNG("chi.png")
img_mil <- readPNG("mil.png")
img_min <- readPNG("min.png")
img_den <- readPNG("den.png")
img_uta <- readPNG("uta.png")
img_cle <- readPNG("cle.png")
img_phx <- readPNG("phx.png")
img_was <- readPNG("was.png")
img_det <- readPNG("det.png")
img_bos <- readPNG("bos.png")
img_orl <- readPNG("orl.png")
img_mia <- readPNG("mia.png")
img_cha <- readPNG("cha.png")
img_nba <- readPNG("nba.png")
img_ali <- readJPEG("ali.jpg")

g_hou <- rasterGrob(img_hou, interpolate=TRUE)
g_lal <- rasterGrob(img_lal, interpolate=TRUE)
g_bkn <- rasterGrob(img_bkn, interpolate=TRUE)
g_sas <- rasterGrob(img_sas, interpolate=TRUE)
g_nop <- rasterGrob(img_nop, interpolate=TRUE)
g_gsw <- rasterGrob(img_gsw, interpolate=TRUE)
g_sac <- rasterGrob(img_sac, interpolate=TRUE)
g_atl <- rasterGrob(img_atl, interpolate=TRUE)
g_mem <- rasterGrob(img_mem, interpolate=TRUE)
g_okc <- rasterGrob(img_okc, interpolate=TRUE)
g_dal <- rasterGrob(img_dal, interpolate=TRUE)
g_chi <- rasterGrob(img_chi, interpolate=TRUE)
g_mil <- rasterGrob(img_mil, interpolate=TRUE)
g_min <- rasterGrob(img_min, interpolate=TRUE)
g_den <- rasterGrob(img_den, interpolate=TRUE)
g_uta <- rasterGrob(img_uta, interpolate=TRUE)
g_cle <- rasterGrob(img_cle, interpolate=TRUE)
g_phx <- rasterGrob(img_phx, interpolate=TRUE)
g_was <- rasterGrob(img_was, interpolate=TRUE)
g_det <- rasterGrob(img_det, interpolate=TRUE)
g_bos <- rasterGrob(img_bos, interpolate=TRUE)
g_orl <- rasterGrob(img_orl, interpolate=TRUE)
g_mia <- rasterGrob(img_mia, interpolate=TRUE)
g_cha <- rasterGrob(img_cha, interpolate=TRUE)
g_nba <- rasterGrob(img_nba, interpolate=TRUE)
g_ali <- rasterGrob(img_ali, interpolate=TRUE)

p<-ggplot(all_states,aes(long,lat))
#p<-p+geom_polygon(aes(group=group),colour="grey10", fill="white" )
p<-p+geom_polygon(data=all_states, aes(x=long, y=lat, group = group),colour="gray10", fill="white" )
p <- p + geom_jitter(data=Team.visit,aes(x=lon, y=lat,color=year.visit) , size=5)
p <- p + geom_jitter(data=Team.nonvisit,aes(x=lon, y=lat) ,alpha=0.3, size=5)
p <- p +labs(col="YEAR") 
p <- p + theme(legend.position = c(0.9, 0.2))
p<-p+theme(legend.title=element_text(face="bold",size=12))
p<-p+annotation_custom(g_hou, xmin=-97, xmax=-92, ymin=25, ymax=30)
p<-p+annotation_custom(g_lal, xmin=-120, xmax=-115, ymin=30, ymax=35)
p<-p+annotation_custom(g_bkn, xmin=-75.5, xmax=-70.5, ymin=36, ymax=41)
p<-p+annotation_custom(g_sas, xmin=-101, xmax=-96, ymin=25, ymax=30)
p<-p+annotation_custom(g_nop, xmin=-92.5, xmax=-87.5, ymin=25.5, ymax=30.5)
p<-p+annotation_custom(g_gsw, xmin=-125.5, xmax=-120.5, ymin=33, ymax=38)
p<-p+annotation_custom(g_sac, xmin=-121.5, xmax=-117.5, ymin=35, ymax=39)
p<-p+annotation_custom(g_atl, xmin=-85, xmax=-81, ymin=30, ymax=34)
p<-p+annotation_custom(g_mem, xmin=-92.5, xmax=-87.5, ymin=30.5, ymax=35.5)
p<-p+annotation_custom(g_dal, xmin=-102, xmax=-97, ymin=30, ymax=35)
p<-p+annotation_custom(g_okc, xmin=-99, xmax=-94, ymin=35, ymax=40)
p<-p+annotation_custom(g_chi, xmin=-92, xmax=-87, ymin=38, ymax=43)
p<-p+annotation_custom(g_mil, xmin=-90, xmax=-86, ymin=43, ymax=47)
p<-p+annotation_custom(g_min, xmin=-95, xmax=-91, ymin=45, ymax=49)
p<-p+annotation_custom(g_den, xmin=-105, xmax=-100, ymin=39.5, ymax=44.5)
p<-p+annotation_custom(g_uta, xmin=-111, xmax=-106, ymin=40, ymax=45)
p<-p+annotation_custom(g_cle, xmin=-84, xmax=-81, ymin=38.5, ymax=41.5)
p<-p+annotation_custom(g_phx, xmin=-112, xmax=-107, ymin=30, ymax=35)
p<-p+annotation_custom(g_was, xmin=-79, xmax=-73, ymin=34, ymax=40)
p<-p+annotation_custom(g_det, xmin=-81, xmax=-86, ymin=41.5, ymax=46.5)
p<-p+annotation_custom(g_bos, xmin=-67, xmax=-72, ymin=42, ymax=47)
p<-p+annotation_custom(g_orl, xmin=-81, xmax=-76, ymin=27, ymax=32)
p<-p+annotation_custom(g_mia, xmin=-80, xmax=-75, ymin=23, ymax=27)
p<-p+annotation_custom(g_cha, xmin=-80, xmax=-75, ymin=31.5, ymax=36.5)

p<-p+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank())
p<-p+theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank(),axis.title.y=element_blank(),axis.text.y=element_blank(),axis.ticks.y=element_blank())
p<-p+annotation_custom(g_nba, xmin=-118.5, xmax=-113.5, ymin=25, ymax=30)
p<-p+annotation_custom(g_ali, xmin=-124, xmax=-119, ymin=25, ymax=30)


