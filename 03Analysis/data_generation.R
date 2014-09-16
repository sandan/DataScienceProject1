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
 
  #volcano_top_10
  volcano_financial_top10 <- dbGetQuery(jdbcConnection,
  "select CAST(country||' , '||year as varchar(200)) as Data ,damage_mill as \"MILLIONS OF DOLLARS\", CAST(Latitude||':'||Longitude as varchar(20)) as LatLong from 
 (select * from volcano_data where damage_mill > 0 and year >1944 order by damage_mill desc)
 where rownum <=10")
  save(volcano_financial_top10,file="volcano_financial_top10.RData")

  volcano_deaths_top10 <- dbGetQuery(jdbcConnection,
  "select CAST(country||' , '||year as varchar(200)) as Data ,num_deaths as Deaths, CAST(Latitude||':'||Longitude as varchar(20)) as LatLong from 
 (select * from volcano_data where num_deaths > 0 and year >1944 order by num_deaths desc)
 where rownum <=10") 
  save(volcano_deaths_top10,file="volcano_deaths_top10.RData")
  
  tsunami_financial_top10 <- dbGetQuery(jdbcConnection,
  "select CAST(country||' , '||year as varchar(200)) as Data ,damage_millions_dollars as \"MILLIONS OF DOLLARS\", CAST(Latitude||':'||Longitude as varchar(20)) as LatLong from (
 select * from tsunami_runup_data where damage_millions_dollars >0 and tsunami_runup_data.YEAR > 2009 order by damage_millions_dollars desc)
 where rownum<=10" )  
  save(tsunami_financial_top10,file="tsunami_financial_top10.RData")
  
  tsunami_deaths_top10 <- dbGetQuery(jdbcConnection,
  "select CAST(country||' , '||year as varchar(200)) as Data ,deaths, CAST(Latitude||':'||Longitude as varchar(20)) as LatLong from (select * from tsunami_runup_data where deaths >0 and YEAR > 2009 order by deaths desc) where rownum<=10") 
  save(tsunami_deaths_top10,file="tsunami_deaths_top10.RData")
  
  
  #earthquake_losses_top20 <- dbGetQuery(jdbcConnection,
  #"select average_annual_loss,CAST(Latitude||':'||Longitude as varchar(10)) as LatLong from (select * from earthquake_losses where average_annual_loss > 0 order by average_annual_loss desc) where rownum <=20")
  #save(earthquake_losses_top20,file="earthquake_losses_top20.RData")

  dbDisconnect(jdbcConnection)
}
load("C:/Users/msand_000/Desktop/cs378DS/NaturalDisasters/02NaturalDisastersData/frames/seismic_1964.RData")
seismic_1964