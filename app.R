# HINF 5620 - Data Visualization
# Final Project
#
# Usage: Generates network graphs from adjacency tables
# Input: CSV file (max 5MB) of a square matrix with row and column names in the first
#         row and first column, respectively. All other values must be numeric 
#
#
# Written by Abderrahman Day
# Updated 05/01/2022
#-------------------------------------------------------------------------------
library(shiny)
library(datasets)
library(igraph)

ui <- fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      fileInput(
        inputId = "inFile",
        label = "Choose a file with numeric values"
      ),
      actionButton(
        inputId = "my_button",
        label = "Submit"
      ),
      sliderInput("node_size", "Node size", min = 0, max = 10, value = 2),
      sliderInput("edge_width", "Edge width", min = 0, max = 10, value = 1, step = 1),
      sliderInput("min_corr", "Minimum weight threshold", min = 0, max = 1, value = 0.5, step = 0.01),
      selectInput(
        "lyt",
        "Select layout",
        c("sphere","circle","random","fruchterman.reingold"),
        selected = "circle",
        multiple = FALSE,
        selectize = TRUE,
        width = NULL,
        size = NULL
      ),
    ),
    mainPanel(
      # outputs
      plotOutput(
        outputId = "plot1"
      )
    )
  )
)

server <- function(input, output, session) {
  

  
  readData <- eventReactive(input$my_button, {
    data <- read.table(input$inFile$datapath, header = TRUE, sep = ",", row.names = 1) %>% 
      as.matrix()
    })
  
  output$plot1 <- renderPlot({
    df <- readData()
    node_size = input$node_size
    edge_width = input$edge_width
    min_corr = input$min_corr
    lyt = input$lyt
    
    network <- graph_from_adjacency_matrix(df, diag = FALSE,weighted=TRUE, mode = "undirected")
    network <- delete.edges(network, E(network)[ abs(weight) < min_corr])
    
    plot(network,
         vertex.label = NA,
         vertex.size=node_size,
         edge.width=abs(E(network)$weight)*edge_width, 
         edge.color=ifelse(df > 0, "blue","red"),
         layout = ifelse(lyt == "circle",layout.circle,
                         ifelse(lyt == "random",layout.random,
                                ifelse(lyt == "fruchterman.reingold",layout.fruchterman.reingold,
                                       ifelse(lyt == "sphere",layout.sphere,layout.circle)))))
    })
}

shinyApp(ui, server)

#library(rsconnect)
#deployApp()



