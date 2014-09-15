library("ggplot2")
Sys.setenv(JAVA_HOME="") #need this to be able to find the java home path
options(java.parameters="-Xmx2g") #2G java jvm memory
library(rJava)
library(RJDBC)

jdbcDriver <- JDBC(driverClass="oracle.jdbc.OracleDriver", classPath="C:\\Program Files\\Java\\jdk1.8.0_20\\ojdbc6.jar")

# In the following, use your username and password instead of "CS347_prof", "orcl_prof" once you have an Oracle account
possibleError <- tryCatch(
  jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@128.83.138.158:1521:orcl", "C##cs347_mas5774", "orcl_mas5774"),
  error=function(e) e
)
if(!inherits(possibleError, "error")){
  earthquakes <- dbGetQuery(jdbcConnection, 
    "select Datetime, Magnitude,CAST(Latitude||':'||Longitude as varchar(10)) as LatLong from seismic_data 
where to_date(Datetime,'YYYY-MM-DD HH24:MI:SS') > to_date('01-01-1988','DD-MM-YYYY') and to_date(Datetime,'YYYY-MM-DD HH24:MI:SS') < to_date('01-12-1988','DD-MM-YYYY')"

  dbDisconnect(jdbcConnection)
}

#volcano
#hist(tsunami$YEAR)
#ggplot(tsunami, aes(y= DEATHS, x = WATER_HT)) + geom_point()
#ggplot(tsunami, aes(y= DEATHS, x = DAMAGE_DESCR)) + geom_point()
#ggplot(subset(tsunami, WATER_HT < 150), aes(y= DEATHS, x = WATER_HT)) + geom_point()

#? ggplot
#?? googleVis
#browseVignettes(package = "ggplot2")
#earthquakes
t<- gvisGeoMap(data=earthquakes, locationvar="LATLONG",
               numvar="MAGNITUDE", 
               options=list(height=350,dataMode="markers"))
plot(t)
#head(earthquakes)
#hist(volcano$ELEVATION)
#hist(volcano$DAMAGE_SCALE)
#data(Andrew)
class(Andrew)
class(Andrew$LatLong)
class(Andrew$Speed_kt)

class(head(earthquakes)$LatLong)
class(head(earthquakes$Magnitude))
y=head(earthquakes)
y
class(y)
