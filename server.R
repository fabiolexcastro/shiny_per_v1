
# Load libraries ----------------------------------------------------------
library(pacman)
p_load(shiny, leaflet, tidyverse, sf, RColorBrewer)

# Server ------------------------------------------------------------------
server <- function(input, output) {
  
  tble <- read_csv('www/points_clean_dup.csv')
  colnames(tble)[5:6] <- c('cos_1', 'cos_2')
  colnames(tble)[2:3] <- c('lon', 'lat')
  dta <- reactiveValues()
  
  observeEvent(input$variable,{
    dta$datos_filtrados <- tble %>% 
      select(gid, lon, lat, cell, cosecha_ha_parcela , cosecha_ha_anoanterior, start, end, input$variable )
    
    names(dta$datos_filtrados)[ncol(dta$datos_filtrados)] <- "yield"
    
    print(names(dta$datos_filtrados))
    
  })
  
  observeEvent(input$rasters, {
    
  })
  
  output$map1 <- renderLeaflet({
    
    # Definimos las paletas de colores para cada año
    pal_1 <- colorNumeric(palette = 'YlOrRd', domain = dta$datos_filtrados$yield)
    
    # Creamos el mapa
    
    leaflet() %>%
      addProviderTiles(provider = "CartoDB.Positron") %>%
      addCircleMarkers(lng = dta$datos_filtrados$lon, lat = dta$datos_filtrados$lat,
                       color =  pal_1(dta$datos_filtrados$yield),
                       fillColor =  pal_1(dta$datos_filtrados$yield),
                       popup = paste0('Rendimiento: ', dta$datos_filtrados$yield),
                       fillOpacity = 0.5, radius = 5,
                       group = "markers1") %>%
      addLegend(position = "bottomright", 
                pal = pal_1, 
                values = dta$datos_filtrados$yield, 
                title = paste0("Cosecha ", input$variable )) 
    
    
  })
  
}
