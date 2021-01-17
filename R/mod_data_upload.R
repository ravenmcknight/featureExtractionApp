#' data_upload UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_data_upload_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    ## introduction text
    
    ## csv options
    p("Tell us about your CSV below or use our sample data. Note that
      only numeric columns with non-zero variance will be returned."),

    radioButtons(inputId = ns('header'),  
                 label = 'Do your columns have headers?',
                 choices = c('Yes'='Yes',
                             'No'='No'), 
                 selected = 'Yes'),
    
    radioButtons(inputId = ns('sep'), 
                 label = 'What seperator does your csv use?',
                 c(Comma=',',
                   Semicolon=';',
                   Tab='\t'),
                 selected = ','),
    
    radioButtons(inputId = ns('quote'), # this is just hard to read yikes
                 label = 'If there are quotes in your csv, which style are they?',
                 c(None='',
                   'Double Quote' = '"',
                   'Single Quote' = "'"),
                 selected = '"'), 
    
    ## upload data
    fileInput(ns('file'), 'Select a clean CSV:',
              multiple = FALSE,
              accept = c(
                'text/csv',
                'text/comma-separated-values',
                'text/tab-separated-values',
                'text/plain',
                '.csv',
                '.tsv'
              )),
    
    tableOutput(ns("upload_preview"))
    
 
  )
}
    
#' data_upload Server Function
#'
#' @noRd 
#' 
#' @return 
#' \describe{
#'   \item{user_data}{raw data uploaded by user (reactive)}
#' }
mod_data_upload_server <- function(input, output, session, r){
  ns <- session$ns
 
  
  # read in the CSV
  user_data <- reactive({
    req(input$file)
    file <- input$file
    if (is.null(file)) return(NULL)
    user_data <- read.csv(file$datapath, header = (input$header == "Yes"),
                          sep = input$sep, quote = input$quote, stringsAsFactors=FALSE)
    
    data.table::setDT(user_data)
    
    # remove missing data
    user_data <- na.omit(user_data)
    
    # return only numeric columns
    user_data <- na.omit(user_data[, sapply(user_data, is.numeric)])
    
    # and remove columns with zero variance
    user_data <- user_data[, !sapply(user_data, function(x) min(x) ==  max(x))]
    
    r$user_data <- user_data
    return(user_data)
  })
  
  output$upload_preview <- renderTable({
    req(user_data())
    head(user_data())
  })

}
    
## To be copied in the UI
# mod_data_upload_ui("data_upload_ui_1")
    
## To be copied in the server
# callModule(mod_data_upload_server, "data_upload_ui_1")
 
