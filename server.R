# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
    
    output$SFMap <- renderImage({
        filename <- normalizePath(file.path('.',
                    paste0( gsub(" |/","",input$radio), ".jpeg")))
        list(src = filename,
             contentType = 'image/jpg',
             width = 600,
             height = 600)
    }, deleteFile = FALSE)
    
})
