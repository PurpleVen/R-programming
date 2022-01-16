
library(shiny)
library(leaflet)
library(shinythemes)

fluidPage(theme = shinytheme("cosmo"),
          navbarPage("Varanasi Analysis", id="main",
                     tabPanel("Dustbins near me", leafletOutput("bbmap", height=840)),
                     tabPanel("Locality Of Dustbins", DT::dataTableOutput("data")),
                     tabPanel("Guide",sidebarPanel(
                       tags$h1("Interactive dashboard"),
                       h3("Press 1 or 2"),
                       h2("What type is your waste?"),
                       
                       textInput("txt1", "\n1.Biodegradable \n2.Non Biodegradable", ""),
                       textInput("txt2", "Press 1 to know about composting. Press 2 to know about recycling", ""),
                     ), # sidebarPanel
                     mainPanel(
                       h2("Your Waste Management Plan!"),
                       
                       verbatimTextOutput("txtout"),
                       verbatimTextOutput("txtout2"),
                       h3("Biodegradable Waste i.e Green waste, Food waste or Organic waste: "),
                       h4("Biodegradable waste is any product that can be easily broken down naturally by water, oxygen, the sun's rays, radiation, or microorganisms.                                                                                   Examples: For composting: Human waste, manure, sewage, slaughterhouse waste.\n Paper waste, Manure, Sewage waste, Hospital waste, Dead animals and plants."),
                       h3("Non Biodegradable: "),
                       h4("Non-Biodegradable waste includes items that cannot be broken down or decomposed by natural agents.                                                                                Examples : Glass, Plastic, Metallic Waste, Nuclear Waste, Synthetic Fibres, Ball point pen refills, Cans, Artificial Rubber, Artificial Polymers"),
                      
                       
                      
                      
                          
                     ) # mainPanel
                     ), # Navbar 1, tabPanel     
                     #tabPanel("Histo", plotOutput("plot")),
                     
                     #tabPanel("Landmarks near me", leafletOutput("input_file", height=840)),
                     
                     #tabPanel("Navbar 1", file("txtout")),
                     
                     
                     tabPanel("Histogram Comparisons", tabsetPanel(
                       tabPanel("Dustbin Histogram", plotOutput("plotdustbins")),#basicPage(
                       #                   h1("R Shiny Bar Plot"),
                       #                   plotOutput("plot")
                       #                   
                       #                 )),
                       tabPanel("Landmark Histogram", plotOutput("plotlandmarks")),
                       tabPanel("Explanation", includeMarkdown("Explanation.md"))
                     )),
                     tabPanel("Read Me",includeMarkdown("readme.md")),
                     
                     
          )
)
