#' data_prep UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param data called `user_data` input by user
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_data_prep_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    p("Prepare your data for feature extraction below."), 
    
    uiOutput(ns("column_selection")),  
    
    radioButtons(inputId = ns('center'),  
                 label = 'Center variables at zero?',
                 choices = c('Yes'='Yes',
                             'No'='No'), 
                 selected = 'Yes'),
    
    radioButtons(inputId = ns('scale'), 
                 label = 'Scale variables to have unit variance?',
                 choices = c('Yes'='Yes',
                             'No'='No'), 
                 selected = 'Yes'), 
    
    tableOutput(ns("preview"))
    
 
  )
}
    
#' data_prep Server Function
#'
#' @noRd 
mod_data_prep_server <- function(input, output, session, r){
  ns <- session$ns
  
  output$column_selection <- renderUI({
    req(r$user_data)

    colnames <- names(r$user_data)

    # Create the checkboxes and select them all by default
    checkboxGroupInput(inputId = ns("columns"), 
                       label = "Choose columns to include in analysis",
                       choices  = colnames,
                       selected = colnames)
  })
  

  clean_user_data <- reactive({
    req(r$user_data)
    
    clean_user_data <- r$user_data[, input$columns, drop = FALSE]


    # center/scale as selected
    clean_user_data <- scale(clean_user_data,
                            scale = (input$scale == "Yes"),
                            center = (input$center == "Yes"))

    r$clean_user_data <- clean_user_data
    
    return(clean_user_data)
  })

  output$preview <- renderTable({
    req(clean_user_data())
    head(clean_user_data())
  })

}
    
## To be copied in the UI
# mod_data_prep_ui("data_prep_ui_1")
    
## To be copied in the server
# callModule(mod_data_prep_server, "data_prep_ui_1")
 
