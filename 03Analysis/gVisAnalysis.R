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
#top 400 magnitudes by year
#seismic_1964 <- dbGetQuery(jdbcConnection, 
#"select substr(datetime,1,10) as datez, Magnitude,CAST(Latitude||':'||Longitude as varchar(10)) as LatLong 
#from (select * from seismic_data where substr(datetime,1,4) in ('1964') order by magnitude desc) where rownum <=400")
#save(seismic_1964,file="seismic_1964.RData")

  s <- dbGetQuery(jdbcConnection, 
  "select substr(datetime,1,10) as datez, Magnitude,CAST(Latitude||':'||Longitude as varchar(10)) as LatLong 
   from (select * from seismic_data where substr(datetime,1,4) in ('2014') order by magnitude desc) where rownum <=10")

dbDisconnect(jdbcConnection)
}
#load("C:/Users/msand_000/Desktop/cs378DS/NaturalDisasters/seismic_1964.RData")
t<- gvisGeoMap(data=s, locationvar="LATLONG",
               numvar="MAGNITUDE", 
               options=list(colors="[0xECE7F2,0xA6BDDB,0x2B8CBE]",width="750px",height="500px", dataMode="markers"))
plot(t)







# Load source_GitHubData
#library(devtools)

# The functions' gist ID is 4466237
#source_gist("4466237")

# Create Disproportionality data UrlAddress object
# Make sure the URL is for the "raw" version of the file
# The URL was shortened using bitly
#UrlAddress <- "http://bit.ly/Ss6zDO"

# Download data
#Data <- source_GitHubData(url = UrlAddress)

# Show Data variable names
#names(Data)