# library(shiny)
# library(leaflet)
# 
# fluidPage(theme = shinytheme("cerulean"),
#           navbarPage("Varanasi Analysis", id="main",
#                      tabPanel("Dustbins near me", leafletOutput("bbmap", height=840)),
#                      #tabPanel("Landmarks near me", leafletOutput("input_file", height=840)),
#                      tabPanel("Locality Of Dustbins", DT::dataTableOutput("data")),
#                      tabPanel("Guide",sidebarPanel(
#                        tags$h1("Input:"),
#                        h2("What type is your waste?"),
#                        h3("Press 1/2"),
#                        textInput("txt1", "\n1.Biodegradable \n2.Non Biodegradable", ""),
#                      ), # sidebarPanel
#                      mainPanel(
#                        h1("Header 1"),
#                        
#                        h4("Output 1"),
#                        verbatimTextOutput("txtout"),
#                        
#                      ) # mainPanel
#                      ), # Navbar 1, tabPanel     
#                      
#            tabPanel("Histogram Comparisons", tabsetPanel(
#              tabPanel("Dustbin Hostogram", plotOutput("plot")),
#              tabPanel("Landmark Hostogram", plotOutput("plot")),
#              tabPanel("Explanation")
#            )),
#            #tabPanel("Navbar 1", file("txtout")),
#            tabPanel("Read Me",includeMarkdown("readme.md")))
# )
# 
#           
#         
# 
# 

library(shiny)
library(leaflet)

fluidPage(theme = shinytheme("cerulean"),
          navbarPage("Varanasi Analysis", id="main",
                     tabPanel("Dustbins near me", leafletOutput("bbmap", height=840)),
                     tabPanel("Locality Of Dustbins", DT::dataTableOutput("data")),
                     tabPanel("Guide",sidebarPanel(
                       tags$h1("Input:"),
                       h2("What type is your waste?"),
                       h3("Press 1/2"),
                       textInput("txt1", "\n1.Biodegradable \n2.Non Biodegradable", ""),
                       textInput("txt2", "Question 2", ""),
                     ), # sidebarPanel
                     mainPanel(
                       h1("Header 1"),
                       
                       verbatimTextOutput("txtout"),
                       verbatimTextOutput("txtout2"),
                       h3("Biodegradable Waste: "),
                       h4("Biodegradable waste is any product that can be easily broken down naturally by water, oxygen, the sun's rays, radiation, or microorganisms. It is also referred to as green waste, recyclable waste, food waste or organic waste. Other biodegradable wastes include human waste, manure, sewage, slaughterhouse waste. This type of waste is used for composting. This process turns the waste into humus. By the process of anaerobic digestion, it can also be used as a source of energy in the form of heat, electricity and fuel.                                                                                        Few examples of Biodegradable waste : Paper waste, Human waste, Manure, Sewage waste, Hospital waste, Dead animals and plants ."),
                       h3("Non Biodegradable: "),
                       h4("Non-Biodegradable waste includes items that cannot be broken down or decomposed by natural agents. This type of waste is a major contributors to air, water and soil pollution. Non-Biodegradable waste can be made useful if it is recycled properly.                                                                                        Examples : Glass, Plastic, Metallic Waste, Nuclear Waste, Synthetic Fibres, Ball point pen refills, Cans, Artificial Rubber, Artificial Polymers"),
                       
                     ) # mainPanel
                     ), # Navbar 1, tabPanel     
                     tabPanel("Histo", plotOutput("plot")),
                     
                     #tabPanel("Landmarks near me", leafletOutput("input_file", height=840)),
                     
                     #tabPanel("Navbar 1", file("txtout")),
                     tabPanel("Read Me",includeMarkdown("readme.md")),
          
          # tabPanel("Histogram Comparisons", sideabarLayout(tabsetPanel(
          #                 tabPanel("Dustbin Hostogram", basicPage(
          #                   h1("R Shiny Bar Plot"),
          #                   plotOutput("plot")
          #                   
          #                 )),
          #                  tabPanel("Landmark Hostogram", plotOutput("plot")),
          #                  tabPanel("Explanation")
          #               )))
          
      
          ),
)
