library(shiny)

shinyServer(function(input, output) {
  #prepare data
  
  date <- reactive(ROCdate(input$lec_date))
  
  oldTable <- reactive({
    return(old_form(input$lec_number, input$lec_name, date(), filtered(input$atten, member)))
  })
  
  newTable <- reactive({
    return(new_form(input$lec_number, input$lec_name, date(), filtered(input$lec_time, timing), filtered(input$atten, member)))
  })
  
  #output data  
  output$old <- renderTable(oldTable(), include.rownames=FALSE)
  
  output$new <- renderTable(newTable(), include.rownames=FALSE)
  
  output$oldlink <- downloadHandler(
    filename = function(){
      paste(date(),"old.csv", sep="")
    }, 
    content = function(file) {
      write.csv(oldTable(), file, row.names=FALSE, fileEncoding="big5")
    }
  )
  
  output$newlink <- downloadHandler(
    filename = function(){
      paste(date(),"new.csv", sep="")
    }, 
    content = function(file) {
      write.csv(newTable(), file, row.names=FALSE, fileEncoding="big5")
    }
  )
  
})
