library(shiny)
library(ggplot2)


data=read.csv("City Data of HUD_Health Care Facilities.csv",header = TRUE)

data$Date <- format(as.Date(data$Week))




##############################
## Define the user interface
inter_face <- shiny::pageWithSidebar(
  # Application title
  headerPanel("HUD Loan"),
  
  
  sidebarPanel(
    selectInput("city", "City:",
                c("Boston" = "BOSTON",
                  "Philadephia" = "PHILADELPHIA",
                  "New York" = "NEW YORK",
                  "Washington" = "WASHINGTON",
                  "Chicago"="CHICAGO",
                  "Los Angeles"="LOS ANGELES",
                  "Atlanta"="ATLANTA")),
    br(),
    
    selectInput("rate", 
                "Type of Rate to Plot:", 
                c("Over Night Libor"="ON",
                     "1 Week Libor"="X1W",
                     "1 Month Libor"="X1M",
                     "3 Month Libor"="X3M",
                     "6 Month Libor"="X6M",
                     "12 Month Libor"="X12M",
                     "1 Yr Treasury Rate"="X1.Yr",
                     "5 Yr Treasury Rate"="X5.Yr",
                     "10 Yr Treasury Rate"="X10.Yr",
                     "20 Yr Treasury Rate"="X20.Yr",
                     "30 Yr Treasury Rate"="X30.Yr")),
  ),
  
  # Show a tabset that includes a plot, summary, and table view
  # of the generated distribution
  mainPanel(plotOutput("Rates Comparison", width="150%", height=500))
)


##############################
## Define the server code
# The function ser_ver() accepts the arguments "input" and "output".

ser_ver <- function(input, output) {
  
  data <- reactive({  
    
    city=input$city
    rate=input$rate
    
    data_sub=data[which(data$PROPERTY.CITY==city), ]
    x=as.Date(data_sub$Date)
    plots=geom_line(aes(x,y=data_sub$rate,group=1))
    
    ggplot(data_sub)+geom_line(aes(x,y=INTEREST.RATE,group=1))+plots+scale_x_date(date_breaks = "1 year", date_labels = "%Y")
  })

  # Generate a plot of the data. Also uses the inputs to build the 
  # plot label. Note that the dependencies on both the inputs and
  # the 'data' reactive expression are both tracked, and all expressions 
  # are called in the sequence implied by the dependency graph
  output$plot <- renderPlot({
    ggplot(data_sub)+geom_line(aes(x,y=INTEREST.RATE))+plots
    
  })
  
  
}

##############################
## Return a Shiny app object

shiny::shinyApp(ui=inter_face, server=ser_ver)
