#learning about maps

library(ggmap)
library(dplyr)
library(tidyr)
library(readr)
library(lubridate)

sf_crime <- read_csv("train.csv")

sf_crime <- sf_crime %>% mutate(month = month(Dates), year=year(Dates)) %>%
    filter( Y < 38 )


left <- -122.52
bottom <- 37.70
right <- -122.35
top <- 37.82
location <-  c(left, bottom, right, top)
sf_osm <- get_map(location = location, color = "bw", source = "osm")

SFMap <- ggmap(sf_osm, extent="normal")
SFMap
SFMap + 
    stat_density2d(
        aes(x=X, y=Y, fill = ..level.., alpha=..level..), 
        geom = "polygon", n=100, 
        data = sf_crime %>% filter( Category == "BURGLARY" )
    ) +
    scale_fill_gradient(low = "yellow", high = "red") +
    scale_alpha(range = c(0.25, 0.5), guide = FALSE) +
    theme(legend.position = "none", axis.title = element_blank(), text = element_text(size = 12))

SFMap +
    geom_point(aes(x = X, y = Y, colour = Category),
               alpha = 0.25,
               data = sf_crime %>% filter( year == 2014, Category %in% c("ARSON", "ASSAULT", "BURGLARY", "SEX OFFENSES FORCIBLE") ) )

SFMap +
    stat_bin2d(
        aes(x = X, y = Y, colour = Category, fill = Category),
        size = .5, bins = 100, alpha = 1/2,
        data = sf_crime %>% filter( month == 1, year == 2014, Category %in% c("ARSON", "ASSAULT", "BURGLARY", "SEX OFFENSES FORCIBLE") )
    )
