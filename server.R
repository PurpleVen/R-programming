library(shiny)

library(dplyr)

library(leaflet)

library(DT)

library(ggplot2)

shinyServer(function(input, output) {
  # Import Data and clean it
  
  bb_data <- read.csv("D:/Sem 3/Extras/MoHUA/Dustbin.csv", stringsAsFactors = FALSE )
  bb_data <- data.frame(bb_data)
  bb_data$LATITUDE <-  as.numeric(bb_data$LATITUDE)
  bb_data$LONGITUDE <-  as.numeric(bb_data$LONGITUDE)
  bb_data=filter(bb_data, LATITUDE != "NA") # removing NA values
  
  dd_data <- read.csv2("D:/Sem 3/Extras/MoHUA/Landmarks.csv")
  dd_data <- data.frame(dd_data)
  
  #Landmarks_data <- read.csv("C:/AICTE Project/GIS Project/Converted Files/Landmarks.csv", stringsAsFactors = FALSE)
  #Landmarks_data <- data.frame(Landmarks_data)
  #plot(Landmarks_data, main = "Landmarks", col = "red")
  # new column for the popup label
  
  # bb_data <- mutate(bb_data, cntnt=paste0('<strong>Landmark Name: </strong>',DUSTBIN_ID,
  #                                         '<br><strong>Zone:</strong> ', Zone,
  #                                         '<br><strong>Ward:</strong> ', Ward,
  #                                         '<br><strong>Ward ID:</strong> ',WARD_ID,
  #                                         '<br><strong>Locality:</strong> ',LOCALITY)) 
  
  # create a color paletter for category type in the data file
  
  #pal <- colorFactor(pal = c("#1b9e77", "#d95f02", "#7570b3"), domain = c("Religious Structures", "Education", "Toilet"))
  
  # create the leaflet map  
  output$bbmap <- renderLeaflet({
    leaflet(bb_data) %>% 
      addCircles(lng = ~LONGITUDE, lat = ~LATITUDE) %>% 
      addTiles() %>%
      addCircleMarkers(data = bb_data, lat =  ~LATITUDE, lng =~LONGITUDE, 
                       radius = 3, #popup = ~as.character(cntnt), 
                       #color = ~pal(Category),
                       stroke = FALSE, fillOpacity = 0.8)%>%
      # addLegend(pal=pal, values=bb_data$Category,opacity=1, na.label = "Not Available")%>%
      addEasyButton(easyButton(
        icon="fa-crosshairs", title="ME",
        onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
  })
  
  # output$llmap <- renderLeaflet({
  #   leaflet(Landmarks_data) %>%
  #     addCircles(y = ~Y, x = ~X) %>% 
  #     #addTiles() %>%
  #     addCircleMarkers(data = Landmarks_data, #y =  ~Y, x =~X, 
  #                      radius = 3, #popup = ~as.character(cntnt), 
  #                      #color = ~pal(Category),
  #                      stroke = FALSE, fillOpacity = 0.8)%>%
  #     addEasyButton(easyButton(
  #       icon="fa-crosshairs", title="ME",
  #       onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
  # })
  output$input_file <- renderLeaflet({
    
  })
  
  
  #create a data object to display data
  
  output$data <-DT::renderDataTable(datatable(
    bb_data[,c(-23,-24,-25,-28:-35)],filter = 'top',
    
    colnames = c("X", "Y", "DUSTBIN_ID","SUB_ZONE","CAPACITY","PERMANENT","LOCALITY", "WARD_ID", "TYPE", "LATITUDE","LONGITUDE", "TIME_ST" ,"Ward",	"Zone")
    
  ))
  
  # output$data <-DT::renderDataTable(datatable(
  #   Landmarks_data[,c(-23,-24,-25,-28:-35)],filter = 'top',
  #   
  #   colnames = c("X", "Y",	"LM_ID",	"CLASS",	"SUB_CLASS",	"WRD_ID",	"RD_ID",	"LOCALITY",	"LM_CODE",	"LM_DESC",	"TIME_ST",	"Ward", 	"Zone",	"Landmark_T")
  #   
  # ))
  
  output$txtout <- renderText({
    if(input$txt1=="1"){
      print("You chose Biodegradable waste. 
You can dump your waste in the biodegradable waste bin in your town. 
Composting is also one of the best ways to dispose biodegradable waste.
You can compost try home or backyard composting.
You can send your segregated biodegradable waste to nearby composting facilities in your town. 
")
    }else{
      if(input$txt1=="2")
        print("you chose non biodegradable")
      else{
        print("Please Enter 1 or 2!")
      }
    }
  })
    output$txtout2 <- renderText({
      if(input$txt2=="1"){
        print("1.Ready the pit: Select a suitable location.( A place with good air circulation is preferred).  Also make sure the spot of land gets good drainage. Construct the pit.
2.     Prepare the base: Place a 1" layer of dry leaves or bagasse at the bottom of the pit. After that, spread a thin layer of ready compost on the base. Place another layer of dry leaves over this.
3.     Add the waste.
4.     Add the bacterial culture:
5.     Add dry leaves: Add a layer of dry leaves over the waste.
6.     Repeat 4 and 5 on the second day.
7.     On the third day, mix the matter in the pit thoroughly with the help of the fork provided.
8.     From the third day onwards, add the waste and spread it evenly as instructed above, add bacterial culture once again, mix the matter completely with the fork and add a layer of dry leaves everyday.")
      }else{
        if(input$txt2=="2")
          print("you chose recycling")
        else{
          print("Please Enter 1 or 2!")
        }
      }
    })
    # paste( input$txt1, input$txt2, sep = " " )
  
  
  
  output$plotdustbins <- renderPlot({
    dustbins <- read.csv("D:/Sem 3/Extras/MoHUA/Dustbin.csv", header = TRUE, sep = ",")
    View(dustbins)
    #Plot
    x<- table(dustbins$WARD_ID)
    barplot(x,xlab ="Ward",ylab = "Dustbins" , main = "Dustbin Availability On Different Zones Of Varanasi")
    
  })
  
  
  output$plotlandmarks <- renderPlot({
    landmarks <- read.csv("D:/Sem 3/Extras/MoHUA/Landmarks.csv", header = TRUE, sep = ",")
    View(landmarks)
    #Plot
    x<- table(landmarks$WRD_ID)
    barplot(x,xlab ="Ward",ylab = "Landmarks" , main = "Landmarks in Varanasi")
    
  })

  
})