# Load R packages
library(shiny)
library(shinythemes)


# Define UI
ui <- fluidPage(theme = shinytheme("cerulean"),
                navbarPage(
                  # theme = "cerulean",  # <--- To use a theme, uncomment this
                  "Varanasi Cleanliness",
                  tabPanel("Map",
                           sidebarPanel(
                             tags$h3("Garbage Levels:"),
                             #textInput("txt1", "Given Name:", ""),
                             #textInput("txt2", "Surname:", ""),
                             selectInput(inputId = "Landmark",
                                         label = "Choose The Level You Want To Check",
                                         list("High", "Medium", "Low")),
                             plotOutput("plot")
                             
                           ), # sidebarPanel
                           mainPanel(
                             h1("Header 1"),
                             
                             h4("Output 1"),
                             verbatimTextOutput("txtout"),
                             
                           ) # mainPanel
                           
                  ), # Navbar 1, tabPanel
                  tabPanel("Datasets", "This panel is intentionally left blank"),
                  tabPanel("Read Me", "This panel is intentionally left blank")
                  
                ) # navbarPage
) # fluidPage


# Define server function  
server <- function(input, output) {
  
  output$txtout <- renderText({
    paste( input$txt1, input$txt2, sep = " " )
  })
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)
