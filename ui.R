library(shiny)

shinyUI(fluidPage(
    titlePanel("Create two csv files"),
    sidebarLayout(
      sidebarPanel(
        textInput("lec_number", "課程編號", ""),
        textInput("lec_name", "課程名稱", ""),
        dateInput("lec_date", "課程日期", ""),
        selectInput("lec_time", "課程時段", choices=timing_choice),
        selectInput("atten", "參加", multiple= TRUE, choices = member_choice, selected = member_choice),
        downloadButton("oldlink", "Download old form"), 
        br(),
        downloadButton("newlink", "Download new form")
        ),
      mainPanel(
        tableOutput("old"), 
        tableOutput("new")
        )
      )
  )
)