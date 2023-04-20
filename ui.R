

# Load libraries ----------------------------------------------------------
library(pacman)
p_load(shiny, leaflet, tidyverse, sf, RColorBrewer)

# UI ----------------------------------------------------------------------
ui <- fluidPage(
  titlePanel("Mapa interactivo de rendimientos de cacao"),
  sidebarLayout(
    sidebarPanel(
      # h3("Seleccione el año a visualizar"),
      # selectInput("year", "Año", choices = c(2018, 2019), selected = 2018),
      #br(),
      h3("Seleccione la variable a visualizar"),
      selectInput("variable", "Year", choices = list("2022" = "cos_1", "2021" = "cos_2"), selected = "cos_1")
    ),
    mainPanel(
      leafletOutput("map1", height = "1100px")
    )
  )
)
