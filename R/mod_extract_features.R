#' extract_features UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param data called `clean_user_data` input by user
#' @param list of factor columns from input data called `factor_cols`
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_extract_features_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    p("Finally, select the parameters for feature extraction!"),
    br(),
    
    radioButtons(inputId = ns('method'),  
                 label = 'Select a method: ',
                 choices = c('Principal Componenent Analysis'='pca',
                             'Independent Component Analysis'='ica', 
                             'Linear Discriminant Analysis'="lca"), 
                 selected = 'pca'), 
    
    radioButtons(inputId = ns('dims'), 
                 label = "Select 2 or 3 dimensions", 
                 choices = c('Two' = '2', 
                             'Three' = '3'),
                 selected = '2'),
    
    uiOutput(ns("group_selection")), 
    
    actionButton(inputId = ns('go'), 
                 label = "Extract features!")
 
  )
}
    
#' extract_features Server Function
#'
#' @noRd 
mod_extract_features_server <- function(input, output, session, r){
  ns <- session$ns

  output$group_selection <- renderUI({
    req(r$factor_cols)
    selectInput(
      inputId = ns("grouping"),
      label = "Select a grouping variable (for visualization)",
      choices = r$factor_cols,
      selected = r$factor_cols[1],
      multiple = FALSE
    )
  })
  
  observeEvent(input$go, {
    r$go <- "go"
    r$dims <- reactive({input$dims})
    r$method <- reactive({input$method})
    r$grouping <- reactive({input$grouping})
  })
  
  

  
  
 
}
    
## To be copied in the UI
# mod_extract_features_ui("extract_features_ui_1")
    
## To be copied in the server
# callModule(mod_extract_features_server, "extract_features_ui_1")
 
