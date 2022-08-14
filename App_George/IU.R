#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
#                                                                                                           #
#                                       INTERFAZ DE USUARIO                                                 #
#                                       AUTHOR: Juan Isaula                                                 #
#                                    UNIDAD DE ACTUARIA - IHSS                                              #
#                                                                                                           #
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#




# 1. Librerias ----------------
library(shinydashboard)
library(DT)
library(shiny)
library(tidyverse)
library(shinyWidgets)
# ---------------------------


# 2. Titulo, menu, y  cuerpo de la App ---------------------------------------------------------------

# 2.1. Titulo 

titulo <- dashboardHeader(title = span(img(src = "logo3.png", height = 45), 'GEORGE'),
                          titleWidth = 220)

# 2.2 Menu

menu <- dashboardSidebar(
  width = 220,
  sidebarMenu(
    menuItem('Datos',tabName = 'subdatos',icon = icon("cloud-upload")),
    menuItem('Deducciones & Devengos',tabName = 'reporte',icon = icon('table')),
    menuItem("Estimacion Prestaciones IHSS", tabName = "prestaciones",icon = icon("coins")),
    menuItem('Fidecomiso BANRURRAL', tabName = 'banco',icon = icon('money-bill-alt'))
  )
)

# 2.3 Cuerpo de App 

cuerpo <- dashboardBody(
  #setBackgroundImage(src = "firma.png",shinydashboard = TRUE),
  # 2.3.1 Items 
  tabItems(
    
    # 2.3.1.2 Item 1
    
    tabItem(
      tabName = 'subdatos',
      fluidRow(
        HTML(paste0(
          "<p>Por favor comience llenando los siguientes campos antes de cargar sus datos: <p>",
          "<ul><li> Fecha actual: es la fecha para la cual se esta generando todo su reporte. </li></ul>",
         "<ul><li> Fecha último aguinaldo </li></ul>",
         "<ul><li> Fecha último decimo cuarto </li></ul>")),
      sidebarPanel(
                   dateInput("date1",
                   label = "Fecha Actual",
                   value = Sys.Date())),
      
      sidebarPanel(
        dateInput("date2",
                  label = "Fecha ultimo decimo cuarto",
                  value = Sys.Date())
      ),
      sidebarPanel(
        dateInput("date3",
                  label = "Fecha ultimo aguinaldo",
                  value = Sys.Date())
      ),
        box(width = 12,status = 'info',solidHeader = TRUE,
            title = 'INGRESE SUS DATOS',
            style = "height:800px; overflow-y: scroll;overflow-x: scroll;",
            fileInput('target_upload', ' ',
                      accept = c(
                        'text/csv',
                        'text/comma-separated-values',
                        '.csv'
                      )),
            radioButtons("separator","Separador: ",choices = c(",",";",":"),
                         selected=",",inline=TRUE),
            DT::dataTableOutput("sample_table")
        )
      )
    ),
    
    # 2.3.1.2  Items 2 
    tabItem(tabName = 'reporte',
            fluidRow(
              valueBoxOutput(width = 4,'EmpleadosSinDuplicar'),
              
              box(width = 12,status = 'info',solidHeader = TRUE,
                  title = 'DEDUCCIONES Y DEVENGOS EMPLEADOS DEL IHSS',
                  style = "height:800px; overflow-y: scroll;overflow-x: scroll;",
                  DT::DTOutput('reporte'),
                  downloadButton('descargar','Descargar'))
            )),
    
    # 2.3.1.3 Items 3
    tabItem(tabName = "prestaciones",
            fluidRow(
              box(width = 12,status = 'info',solidHeader = TRUE,
                  title = 'DERECHOS LABORALES Y PRESTACIONES IHSS',
                  style = "height:800px; overflow-y: scroll;overflow-x: scroll;",
                  DT::DTOutput("tabla3"))
            )),
    
    # 2.3.1.4 Items 4 
    tabItem(
      tabName = "banco",
            fluidRow(
              box(width = 12,status = 'info',solidHeader = TRUE,
                  title = 'FIDECOMISO BANRURAL',
                  style = "height:800px; overflow-y: scroll;overflow-x: scroll;",
                  DT::DTOutput("fidecomiso"))
            ))
    
    
  )
)
# --------------------------------------------------------------------------------------------------

# 3. Interfaz de Usuario 


IU <-  dashboardPage(titulo, menu, cuerpo)

# 3.1 Tamaño de Archivo 

options(shiny.maxRequestSize=50*1024^2)





























