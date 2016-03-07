library(shiny)

categories <- c("ARSON", "ASSAULT", "BRIBERY", "BURGLARY", "DRIVING UNDER THE INFLUENCE", "DRUG/NARCOTIC", "EMBEZZLEMENT", "EXTORTION", "FRAUD", "GAMBLING", "LARCENY/THEFT", "PROSTITUTION", "ROBBERY", "SEX OFFENSES FORCIBLE", "SUICIDE", "VEHICLE THEFT")

shinyUI(fluidPage(
    sidebarLayout(
        sidebarPanel(
            helpText("Choose a crime category to explore the maps."),
            
            radioButtons("radio", label = h3("Crime Category"),
                         choices = categories,
                         selected = categories[1])
        ),
        mainPanel(
            h2("Mapping Crime Locations in San Francisco", align = "center"),  
            div(imageOutput("SFMap"), style="text-align: center;")
        )
    )
))