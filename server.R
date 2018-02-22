#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(lattice)


studInfo <- read.csv("studentInfo.csv")
#numberPassed <- 0

colorList <- c("darkblue", "red", "darkgreen", "gold")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  dataset <- reactive({
    return(studInfo[sample(nrow(studInfo), input$sampleSize), ])
  })
  
  output$plot1 <- renderPlot({
    
    new_df <- data.frame("isPassed" = ifelse(dataset()$final_result == "Distinction" |
                                            dataset()$final_result == "Pass", 1, 0),
                      "par1" = as.factor(dataset()[,c(input$par1)]),
                      "groupby" = as.factor(dataset()[,c(input$groupby)])
                      )
    
    sum_table <- group_by(new_df, groupby, par1) %>% summarize(isPassed = sum(isPassed))
    numberPassed <- sum(sum_table$isPassed)
    output$numberPassed <- renderText({
      paste("Total Passing Student: ", numberPassed)
    })
    p <- ggplot(sum_table, aes(par1, isPassed, fill = par1)) + geom_bar(stat = "identity")
    input_x1 <- toupper(input$par1)
    p <- p + ggtitle(paste("Total Passing Students by ", input$par1, " and ", input$groupby)) + facet_grid( . ~ groupby) + scale_x_discrete(labels = abbreviate) + theme(axis.text.x = element_text(angle = 90, hjust = 1))  + labs(y = "Total Students Passed", x = "") + guides(fill=guide_legend(title=paste("", input_x1)))
    print(p)
  })
   
  
  
  output$summaryTitle <- renderText({
    paste("Summary of ", input$sampleSize, " samples")
  })
  
  output$summary <- renderPrint({
    summary(dataset())
  })
  output$plot2 <-renderPlot({
    
    infoModule <- studInfo[studInfo$code_module == input$module,]
    count_res <- table(infoModule$final_result, infoModule[,c(input$par2)])
                                          
    par(mar=c(10.1, 4.1, 2.1, 8.1), xpd=TRUE)
    barplot(count_res, 
            main=paste("Final Result Distribution by ", input$par2, " from course ", input$module), 
            ylab = "Number of Students", las = 2,
            col=colorList
    )
    legend("topright", inset=c(-0.1,0),
           legend = rownames(count_res),
           fill = colorList
    )
  })
  
  selectedCourse <- eventReactive(input$summary, {
    sample[sample$code_module == input$module,]
  })
  
  
  
  
})
