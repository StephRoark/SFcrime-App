# server.R

library(ggmap)
library(dplyr)
library(tidyr)
library(readr)
library(lubridate)

sf_crime <- read_csv("train.csv.gz")

sf_crime <- sf_crime %>% mutate(month = month(Dates), year=year(Dates)) %>%
    filter( Y < 38 ) %>% filter(year == 2014)


left <- -122.52
bottom <- 37.70
right <- -122.35
top <- 37.82
location <-  c(left, bottom, right, top)
print("loading map")
sf_osm <- get_map(location = location, color = "bw", source = "osm")
print("map loaded")

SFMap <- ggmap(sf_osm)

shinyServer(
    function(input, output) {
        output$value <- renderPrint({ 
            input$radio })
       
        output$SFMap <- renderPlot({
            print("Rendering")

            SFMap + 
                stat_density2d(
                    aes(x=X, y=Y, fill = ..level.., alpha=..level..), 
                    geom = "polygon", n=100, 
                    data = sf_crime %>% filter( Category == input$radio )
                ) +
                scale_fill_gradient(low = "yellow", high = "red") +
                scale_alpha(range = c(0.25, 0.5), guide = FALSE) +
                theme(legend.position = "none", axis.title = element_blank(), 
                text = element_text(size = 12))
       })
   } 
)