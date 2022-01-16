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
                       h4("Biodegradable waste is any product that can be easily broken down naturally by water, oxygen, the sun's rays, radiation, or microorganisms.                                                                                   
                          Examples: For composting: Human waste, manure, sewage, slaughterhouse waste.\n Paper waste, Manure, Sewage waste, Hospital waste, Dead animals and plants."),
                       h3("Non Biodegradable: "),
                       h4("Non-Biodegradable waste includes items that cannot be broken down or decomposed by natural agents.                                                                                       
                          Examples : Glass, Plastic, Metallic Waste, Nuclear Waste, Synthetic Fibres, Ball point pen refills, Cans, Artificial Rubber, Artificial Polymers"),
                       h3("Composting:"),
                       h4("The process of converting plant and animal wastes, kitchen wastes like left-over food, vegetable, and fruit peels, into nutrient-rich manure is called composting."),
                       h3("Recycling:"),
                       h4("Items that can be recycled: Flattened cardboard, newspapers, magazines, office paper, envelopes, soda cans, food cans, juice and milk bottles, cartons, plastic bottles 
Items that have NO place in recycling Containers:1.NO electronics, batteries and light bulbs.    
2.NO food(food trash should be composted where composting programs are offered.                   3.NO clothing and shoes (reuse or donate it)                      
4.NO soiled paper or wet items (dispose with your trash)
5.NO diapers (dispose them in your trash                    
6.NO styrofoam (reuse it)                      
7.NO plastic bags and wrappers and flexible plastic packaging (reuse them in your home)                 8. NO yard waste (compost it)
9.NO tools. it may find a second life(give them away for reuse)                   
10.NO toys because they are often made of plastic (donate them)   
11.NO construction waste(wood,sheetrock dispose of in your trash)           
12.NO medical needles as it may cause serious harm to workers (dispose in proper medical waste containers)

                          "),
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