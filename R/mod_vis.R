#' vis UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param `clean_user_data` input by user
#' @param `dims` - number of dimensions to visualize
#' @param `method` - method to visualize
#' @param `grouping` - grouping variable to use for vis
#' @param `go` - tell vis to start
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_vis_ui <- function(id){
  ns <- NS(id)
  tagList(
    textOutput(ns("testtext"))
 
  )
}
    
#' vis Server Function
#'
#' @noRd 
mod_vis_server <- function(input, output, session, r){
  ns <- session$ns
  
  output$testtext <- renderText({
      "hell0"
  })
  
}
    
## To be copied in the UI
# mod_vis_ui("vis_ui_1")
    
## To be copied in the server
# callModule(mod_vis_server, "vis_ui_1")
 
