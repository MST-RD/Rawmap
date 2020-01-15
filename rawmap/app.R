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
            fileInput("sas", "Choose sas File"),
            #空一行
            tags$hr(),
            
            #选择框
            uiOutput("checkbox")
            
           
        ),
        
        #右边主界面
        mainPanel(
            #展示table
            dataTableOutput("table")
        )
    )
)

server <- function(input, output){

    
    #交互操作
    output$table <- renderDataTable({
        infile <- input$sas
        if (is.null(infile))
            return(NULL)
        #读入input的sas数据集
        datatable(
            if (is.null(input$datasetSelector))
            {return(NULL)}
            else{
            #提取前10行和动态展现有哪些变量被选择
            head(read_sas(infile$datapath),n=10)[,input$datasetSelector]
            }
            )
    })
    
    #动态创建个链表
    fileOptions <- reactiveValues(currentOptions=c())
    
    #动态处理，把input的sas数据集的colname与链表连接
    observeEvent(input$sas, {
        fileOptions$currentOptions = c(fileOptions$currentOptions, 
                                    colnames(read_sas(input$sas$datapath)))
    })
    
    #创建动态选择栏
    output$checkbox<-renderUI({
        checkboxGroupInput("datasetSelector","chose what you want:", 
                           choiceNames  = fileOptions$currentOptions,
                           choiceValues = fileOptions$currentOptions
        )
    })
    
    

}


# Run the application 
shinyApp(ui = ui, server = server)
