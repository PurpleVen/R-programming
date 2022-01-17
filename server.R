library(shiny)

library(shinythemes)

library(dplyr)

library(leaflet)

library(DT)

library(ggplot2)

library(rgdal)

library(rsconnect)
#rsconnect::deployApp('https://datadive.shinyapps.io/VaranasismartcityanalysisbyteamDataDive2022/')

shinyServer(function(input, output) {
  # Import Data and clean it

  bb_data <- read.csv("C:/AICTE Project/Team Data Dive/Varanasi smart city analysis by team Data Dive/Dustbin.csv", stringsAsFactors = FALSE )
  bb_data <- data.frame(bb_data)
  bb_data$LATITUDE <-  as.numeric(bb_data$LATITUDE)
  bb_data$LONGITUDE <-  as.numeric(bb_data$LONGITUDE)
  bb_data=filter(bb_data, LATITUDE != "NA") # removing NA values

  pal <- colorFactor(pal = c("Red", "Blue", "Green", "Yellow", "Orange"), domain = c("Bhelupur", "Dashaswamedh", "Varunapar", "Adampur", "Kotwali"))

  # create the leaflet map
  output$bbmap <- renderLeaflet({
      leaflet(bb_data) %>%
      addCircles(lng = ~LONGITUDE, lat = ~LATITUDE) %>%
      addTiles() %>%

       addCircleMarkers(data = bb_data, lat =  ~LATITUDE, lng =~LONGITUDE,
                        radius = 5, #popup = ~as.character(cntnt),
                        color = ~pal(Zone),
                        stroke = FALSE, fillOpacity = 2.8)%>%

      addLegend("bottomright", pal = pal, values=bb_data$Zone,opacity=1, na.label = "Not Available", title = "Dustbins Distribution In Different Zones")%>%
      addEasyButton(easyButton(
        icon="fa-crosshairs", title="ME",
        onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
        })
  
    


  #create a data object to display data

  output$data <-DT::renderDataTable(datatable(
      bb_data[,c(-23,-24,-25,-28:-35)],filter = 'top',

      colnames = c("X", "Y", "DUSTBIN_ID","SUB_ZONE","CAPACITY","PERMANENT","LOCALITY", "WARD_ID", "TYPE", "LATITUDE","LONGITUDE", "TIME_ST" ,"Ward",	"Zone")

  ))


  output$txtout <- renderText({
    if(input$txt1=="1"){
      print("You can dump your waste in the biodegradable labelled waste bin in your town. 
OR 
Composting is one of the best ways to recycle biodegradable waste. 
You can try home or backyard composting.You can send your segregated biodegradable waste to nearby composting facilities in your town.")
    }else{
      if(input$txt1=="2")
        print("Recycling is the best way to dispose Non-Biodegradable waste.Recycle at home Send the waste to nearby recycling centres or facilities in your town. Segregate waste that can be recycled prior to the recycle pickup provided by the municipality.")
      else{
        print("Please Enter 1 For Biodegradable Waste And 2 For Non-Biodegradable Waste On The Text Field")
      }
    }
  })
    output$txtout2 <- renderText({
      if(input$txt2=="1"){
        print("The biodegradable components of garbage are used to make the compost through the process of composting. The waste materials are kept in pits and covered with soil. Microorganisms decompose these waste materials and manure is obtained. 
 How to compost waste by yourself : 
 1.     Ready the pit: Select a suitable location.( A place with good air circulation is preferred).  Also make sure the spot of land gets good drainage. Construct the pit.
 2.     Prepare the base: Place a 1” layer of dry leaves or bagasse at the bottom of the pit. After that, spread a thin layer of ready compost on the base. Place another layer of dry leaves over this.
 3.     Add the waste.
 4.     Add the bacterial culture:
 5.     Add dry leaves: Add a layer of dry leaves over the waste.
 6.     Repeat 4 and 5 on the second day.
 7.     On the third day, mix the matter in the pit thoroughly with the help of the fork provided.
 8.     From the third day onwards, add the waste and spread it evenly as instructed above, add bacterial culture once again, mix the matter completely with the fork and add a layer of dry leaves everyday.
|:--------------------------------------------------------------------------------------------------------|
|                   # = decomposes quickly          * = takes time to decompose                           |                                
|:--------------------------------------------------------------------------------------------------------|                             
|                        You Are Advised To Compost                   |  You Are Advised To Not Compost   |
|:------------------------------------------------------------------:|-----------------------------------:|
|  #Fruit, vegetable waste                                            | Fish bones ,leftover  meat        |
|  #Leaves trimmed from houseplants                                   | Cooked food that may become moldy |
|  #Cooked Rice,pasta                                                 | Animal waste                      |
|  *Coffee, Tea bags                                                  | Milk and dairy products, oil      |
|  *Used Paper/Cotton napkins/towels                                  | Tea and Coffee Bags               |
|  *Stale tortilla,cereal,bread,potato chips,tomato sauce, protein    | Citrus Peels and Onions           |  
|  *Toothpicks                                                        | Glossy or coated papers           |
|  *Hair from hairbrush                                               | Large Branches                    |
|  *Nail clippings and cotton balls                                   | Synthetic Fertilizer              |
|  *used 100% cotton tampons and sanitary pads                        | Sawdust from Treated Wood         |
|  *Pencil Shavings                                                   | Coal Fire Ash                     |
|  *Dry dog or cat food, fish pellets ,pet hair                       | Frying fats                       |
|:--------------------------------------------------------------------------------------------------------|
              ")
      }else{
        if(input$txt2=="2"){
          print("Know recycling! \nThe key to recycling the right way is ensuring your items are clean and dry.
|:---------------------------------------------------------------------------------------|                             
|           You Are Advised To Recycle       |  You Are Advised To Not Recycle           |
|:------------------------------------------:|------------------------------------------:|
|   Flattened cardboard                      |  Electronics, batteries and light bulbs   |
|   Newspapers                               |  Clothing, Shoes (reuse or donate it)     |
|   Magazines                                |  Diapers                                  |
|   Office paper                             |  Styrofoam                                |
|   Envelopes                                |  Flexible plastic packaging (reuse them)  |                          
|   Soda, Food cans                          |  Yard waste (compost it)                  |  
|   Juice and Milk cartons                   |  Plastic Toys                             |
|   Plastic bottles                          |  Construction waste (wood)                |
|:--------------------------------------------------------------------------------------:|
                                            
 How to recycle waste at home? 
 1. Reuse Glass, Plastic and Cardboard Containers
 One of the best uses for empty plastic soda bottles is as a planter for flowers and herbs. 
 Take an empty 2-liter pop bottle and cut off the top two thirds, leaving the bottle’s bottom third. Now you have a reusable flower pot. 
 Empty glass and plastic jars make excellent kitchen storage. Empty shoe boxes make great storage bins for things like jewelry, toiletries and household items.
 2. Reuse your Home Delivered Newspaper
 There are several ways to reuse the newspaper once you have read it. You can use it as packing paper for fragile china, wrapping paper for gifts or as a cleaning aid.
 3. Reuse Aluminium Foil 
 Use it as a Reflector: Place foil behind plants in the shade to reflect light on them
 4. Miscellaneous Items
 -Turn old clothing or jeans into bags, aprons, skirts, patchwork quilts.                                          
 -Save old mascara brushes and toothbrushes for cleaning in small, hard-to-reach places.        
 -Donate torn jeans to the rag bin at your local household waste site. The cotton in the jeans will be reclaimed for industrial use.")
        }
        else{
          print("Please Enter 1 For Composting And 2 For Recycling On The Text Field.")
        }
      }

    })
    # paste( input$txt1, input$txt2, sep = " " )



  output$plotdustbins <- renderPlot({
    dustbins <- read.csv("C:/AICTE Project/Team Data Dive/Varanasi smart city analysis by team Data Dive/Dustbin.csv", header = TRUE, sep = ",")
    #View(dustbins)
    #Plot
    x<- table(dustbins$WARD_ID)
    barplot(x,xlab ="Ward ID",ylab = "Dustbins" , main = "Dustbin Availability On Different Wards Of Varanasi")

  })


  output$plotlandmarks <- renderPlot({
    landmarks <- read.csv("C:/AICTE Project/Team Data Dive/Varanasi smart city analysis by team Data Dive/Landmarks.csv", header = TRUE, sep = ",")
    #View(landmarks)
    #Plot
    x<- table(landmarks$WRD_ID)
    barplot(x,xlab ="Ward ID",ylab = "Landmarks" , main = "Landmarks in Different Wards in Varanasi")

  })





})



