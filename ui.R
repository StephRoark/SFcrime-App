library(shiny)
library(ggplot2)
library(ggmap)
library(dplyr)
library(tidyr)
library(readr)
library(lubridate)

shinyUI(fluidPage(
    sidebarLayout(
        sidebarPanel(
            helpText("Choose a crime category to explore the maps."),
            helpText("It could take a moment for the map to load."),
            
            radioButtons("radio", label = h3("Crime Category"),
                         choices = c("ARSON", "ASSAULT", "BRIBERY", "BURGLARY", "DRIVING UNDER THE INFLUENCE", "DRUG/NARCOTIC", "EMBEZZLEMENT", "EXTORTION", "FRAUD", "GAMBLING", "LARCENY/THEFT", "PROSTITUTION", "ROBBERY", "SEX OFFENSES FORCIBLE", "SUICIDE", "VEHICLE THEFT"),
                         selected = "ARSON")
        ),
       mainPanel(
         h3(titlePanel("Mapping Crime Locations in San Francisco"), align = "center"),  
         plotOutput("SFMap")
      )
   )
))