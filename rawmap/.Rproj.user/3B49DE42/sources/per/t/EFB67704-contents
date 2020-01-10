#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(haven)
library(DT)


# sas <- data.frame(read_sas("D:/vs1.sas7bdat"))

# Define UI for application that draws a histogram
ui <- fluidPage(
    titlePanel('Examples od Datatables'),
    sidebarLayout(
        sidebarPanel(
            #读入文件
            fileInput("sas", "Choose sas File",
                      multiple = TRUE),
            #空一行
            tags$hr(),
            
            #选择变量
            uiOutput("checkbox")
           
        ),
        
        #右边主界面
        mainPanel(
            #展示table
            tableOutput("mytable1")
        )
    )
)

server <- function(input, output){


    #交互操作
    output$mytable1 <- renderTable({
        #读入输入的地址
        infile <- data.frame(read_sas(input$sas))
        if (is.null(inFile))
            return(NULL)
        #提取前10行
        diamonds2 <- head(infile,n=10)
        #不知道干嘛
        datatable(diamonds2[, input$show_vars])
    })
    
    #没起作用
    output$checkbox<-renderUI({
        checkboxGroupInput("VAR","FF:", choices = diamonds2
        )
    })
    

}


# Run the application 
shinyApp(ui = ui, server = server)
