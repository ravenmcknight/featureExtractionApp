#' extract_features UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
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
                 selected = '2')
    
    # this will need to made with render UI
    # selectInput(inputid = ns('group'), 
    #             label = "Select a grouping variable (for visualization)", 
    #             choices = )
 
  )
}
    
#' extract_features Server Function
#'
#' @noRd 
mod_extract_features_server <- function(input, output, session, r){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_extract_features_ui("extract_features_ui_1")
    
## To be copied in the server
# callModule(mod_extract_features_server, "extract_features_ui_1")
 
