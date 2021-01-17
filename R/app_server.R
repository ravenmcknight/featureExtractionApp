#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  r <- reactiveValues()
  # List the first level callModules here
  callModule(mod_data_upload_server, "data_upload_ui_1", r = r)
  callModule(mod_data_prep_server, "data_prep_ui_1", r = r)

}
