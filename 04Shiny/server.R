# server.R
library(shiny)
library(googleVis)

a<-load("../02NaturalDisastersData/frames/seismic_1964.RData")
b<-load("../02NaturalDisastersData/frames/seismic_1974.RData")
c<-load("../02NaturalDisastersData/frames/seismic_1984.RData")
d<-load("../02NaturalDisastersData/frames/seismic_1994.RData")
e<-load("../02NaturalDisastersData/frames/seismic_2004.RData")
f<-load("../02NaturalDisastersData/frames/seismic_2014.RData")

shinyServer(function(input, output) {
  myYear <- reactive({
    input$year
  })
  
  output$text1 <- renderText({
    paste("Top Seismic Activity in ", myYear())
  })
  
  output$vis <- renderGvis({
    
    myData<- reactive({
      switch(toString(myYear()),
             '1960' = seismic_1964,
             '1970' = seismic_1974,
             '1980' = seismic_1984,
             '1990' = seismic_1994,
             '2000' = seismic_2004,
             '2010'= seismic_2014)
    })
    
    output$view <- renderTable({
      myData()
    })  
    gvisGeoMap(myData(),
                 locationvar="LATLONG", numvar="MAGNITUDE",
                 options=list(width=850, height=550,
                              colorAxis="{colors:['#FFFFFF', '#0000FF']}",
                 dataMode="markers"))     
    
    

})})



