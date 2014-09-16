library("ggplot2")
Sys.setenv(JAVA_HOME="") #need this to be able to find the java home path
options(java.parameters="-Xmx2g") #2G java jvm memory
library(rJava)
library(RJDBC)
library(googleVis)
jdbcDriver <- JDBC(driverClass="oracle.jdbc.OracleDriver", classPath="C:\\Program Files\\Java\\jdk1.8.0_20\\ojdbc6.jar")

# In the following, use your username and password instead of "CS347_prof", "orcl_prof" once you have an Oracle account
possibleError <- tryCatch(
  jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@128.83.138.158:1521:orcl", "C##cs347_mas5774", "orcl_mas5774"),
  error=function(e) e
)
if(!inherits(possibleError, "error")){
#top 10 magnitudes by year
seismic_1964 <- dbGetQuery(jdbcConnection, 
"select Magnitude,CAST(Latitude||':'||Longitude as varchar(20)) as LatLong 
from (select * from seismic_data where substr(datetime,1,4) in ('1964') order by magnitude desc) where rownum <=10")
save(seismic_1964,file="seismic_1964.RData")

seismic_1974 <- dbGetQuery(jdbcConnection, 
"select Magnitude,CAST(Latitude||':'||Longitude as varchar(20)) as LatLong 
from (select * from seismic_data where substr(datetime,1,4) in ('1974') order by magnitude desc) where rownum <=10")
save(seismic_1974,file="seismic_1974.RData")

seismic_1984 <- dbGetQuery(jdbcConnection, 
"select Magnitude,CAST(Latitude||':'||Longitude as varchar(20)) as LatLong 
from (select * from seismic_data where substr(datetime,1,4) in ('1984') order by magnitude desc) where rownum <=10")
save(seismic_1984,file="seismic_1984.RData")

seismic_1994 <- dbGetQuery(jdbcConnection, 
  "select Magnitude,CAST(Latitude||':'||Longitude as varchar(20)) as LatLong 
  from (select * from seismic_data where substr(datetime,1,4) in ('1994') order by magnitude desc) where rownum <=10")
save(seismic_1994,file="seismic_1994.RData")

seismic_2004 <- dbGetQuery(jdbcConnection, 
  "select Magnitude,CAST(Latitude||':'||Longitude as varchar(20)) as LatLong 
  from (select * from seismic_data where substr(datetime,1,4) in ('2004') order by magnitude desc) where rownum <=10")
save(seismic_2004,file="seismic_2004.RData")

seismic_2014 <- dbGetQuery(jdbcConnection, 
"select Magnitude,CAST(Latitude||':'||Longitude as varchar(20)) as LatLong 
from (select * from seismic_data where substr(datetime,1,4) in ('2014') order by magnitude desc) where rownum <=10")
save(seismic_2014,file="seismic_2014.RData")
  
  
#  s <- dbGetQuery(jdbcConnection, 
#  "select substr(datetime,1,10) as datez, Magnitude,CAST(Latitude||':'||Longitude as varchar(10)) as LatLong 
#   from (select * from seismic_data where substr(datetime,1,4) in ('2014') order by magnitude desc) where rownum <=10")

dbDisconnect(jdbcConnection)
}