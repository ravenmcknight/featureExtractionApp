#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      #tags$head(HTML('https://fonts.googleapis.com/css2?family=Karla:wght@300&display=swap')),
      tags$head(HTML('<style>* {font-size: 100%; font-family: Karla;}</style>')),
      fluidRow(
        column(1),
        column(4,
               h2("Feature Extraction Methods"),
               HTML(paste("<p>")),
               HTML(paste("bop")),
               HTML(paste("<boop")),
               br(),
               tabsetPanel(id = "selected_tab", type = "tabs", selected = "dataset",
                           tabPanel("Data Upload", value = "data_upload",
                                    br(),
                                    mod_data_upload_ui("data_upload_ui_1")
                           ), # end tabPanel
                           
                           tabPanel("Prep Data", value = "data_pre",
                                    br(),
                                    mod_data_prep_ui("data_prep_ui_1")
                                   ), # end tabPanel
                           
                           # next working session: what is the point of making all these modules seperate?
                           # maybe there should just be two modules: one to prep the data, and one to plot it? 
                           # how does seperating those out really beenfit me?
                           # is there a point to using golem if we're not using lots of modules?
                           
                           tabPanel("Extract Features!", value = "extract", 
                                    br(),
                                    mod_extract_features_ui("extract_features_ui_1")
                                  ) # end tabPanel
                           
                                    
        )
        
        
        ), # end column
        column(7, 
               conditionalPanel(
                 condition = "input['extract_features_ui_1-method'] == 'pca'",
                 mod_vis_ui("vis_ui_1")
                 ) # end conditional panel
        ) # end column
    ) # end fluidRow
  ) # end fluidPage
  ) # end tagList
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'featureExtractionApp'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
    
  )
}

