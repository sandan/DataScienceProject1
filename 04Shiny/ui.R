# ui.R
shinyUI(fluidPage(
  titlePanel("Seismic Activity"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Toggle the slide to view Seismic Activity by decade"),
        
      sliderInput("year", 
                  label="Decade",
                  min = 1960, max = 2010,step=10,
                value = 1960, animate = FALSE),
      
      tableOutput("view")
    ),  
    mainPanel(
      h3(textOutput("text1")),
      htmlOutput("vis")
    )
  )
))