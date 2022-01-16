library(shiny)

library(shinythemes)

library(dplyr)

library(leaflet)

library(DT)

library(ggplot2)

library(rgdal)

shinyServer(function(input, output) {
  # Import Data and clean it
  
  bb_data <- read.csv("C:/AICTE Project/Team Data Dive/Varanasi smart city analysis by team Data Dive/Dustbin.csv", stringsAsFactors = FALSE )
  bb_data <- data.frame(bb_data)
  bb_data$LATITUDE <-  as.numeric(bb_data$LATITUDE)
  bb_data$LONGITUDE <-  as.numeric(bb_data$LONGITUDE)
  bb_data=filter(bb_data, LATITUDE != "NA") # removing NA values
  
  #ward_boundary_data <- readxl::"C:/AICTE Project/Team Data Dive/Varanasi smart city analysis by team Data Dive/wardboundary.xlsx"
  
  #dd_data <- read.csv2("C:/AICTE Project/Team Data Dive/Varanasi smart city analysis by team Data Dive/Landmarks.csv")
  #dd_data <- data.frame(dd_data)
  
  #map <- readOGR("C:/AICTE Project/GIS Folder/ward boundary/Ward_Boundary.shp")
  
  #Landmarks_data <- read.csv("C:/AICTE Project/GIS Project/Converted Files/Landmarks.csv", stringsAsFactors = FALSE)
  #Landmarks_data <- data.frame(Landmarks_data)
  #plot(Landmarks_data, main = "Landmarkss", col = "red")
  # new column for the popup label

  # bb_data <- mutate(bb_data, cntnt=paste0('<strong>Landmark Name: </strong>',DUSTBIN_ID,
  #                                         '<br><strong>Zone:</strong> ', Zone,
  #                                         '<br><strong>Ward:</strong> ', Ward,
  #                                         '<br><strong>Ward ID:</strong> ',WARD_ID,
  #                                         '<br><strong>Locality:</strong> ',LOCALITY)) 

  # create a color paletter for category type in the data file
  
  pal <- colorFactor(pal = c("Red", "Blue", "Green", "Yellow", "Orange"), domain = c("Bhelupur", "Dashaswamedh", "Varunapar", "Adampur", "Kotwali"))
   
  # create the leaflet map  
  output$bbmap <- renderLeaflet({
      leaflet(bb_data) %>% 
      #addProviderTiles(providers$bbmap.Toner, group = "Toner") %>%
      #addProviderTiles(providers$bbmap.TonerLite, group = "Toner Lite") %>%
      addCircles(lng = ~LONGITUDE, lat = ~LATITUDE) %>% 
      addTiles() %>%
      
       addCircleMarkers(data = bb_data, lat =  ~LATITUDE, lng =~LONGITUDE, 
                        radius = 5, #popup = ~as.character(cntnt), 
                        color = ~pal(Zone),
                        stroke = FALSE, fillOpacity = 2.8)%>%
      
      addLegend("bottomright", pal = pal, values=bb_data$Zone,opacity=1, na.label = "Not Available", title = "Dustbin Availability In Different Zones")%>%
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
      print("you chose biodegradable")
    }else{
      if(input$txt1=="2")
        print("you chose non biodegradable")
      else{
        print("Please Enter 1 or 2!")
      }
    }
  })
    output$txtout2 <- renderText({
      paste( input$txt2, sep = " " )
      
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
    landmarks <- read.csv("C:/AICTE Project/GIS Project/Converted Files/Landmarks.csv", header = TRUE, sep = ",")
    #View(landmarks)
    #Plot
    x<- table(landmarks$WRD_ID)
    barplot(x,xlab ="Ward ID",ylab = "Landmarks" , main = "Landmarks in Different Wards in Varanasi")
    
  })
  

  
 
  
})
