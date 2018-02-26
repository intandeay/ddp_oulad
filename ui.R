#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
studInfo <- read.csv("studentInfo.csv")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Open University Learning Analytics Dataset Exploration"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      h3("Parameter Selection"),
      h4("General Passing Rate"),
      
      sliderInput('sampleSize', 'Choose Sample Size', min=500, max=nrow(studInfo),
                  value=min(500, nrow(studInfo)), step=100, round=0),
      
      selectInput("groupby", "Choose a Parameter to Group By:",
                  list(`Gender` = "gender",
                       `Region` = "region",
                       `Highest Education` = "highest_education",
                       `IMD Band` = "imd_band",
                       `Age Band` = "age_band",
                       `No. of Previous Attempts` = "num_of_prev_attempts",
                       `Disability` = "disability"
                  ),
                  selected = "highest_education"
      ),
      
      selectInput("par1", "Choose Another Parameter:",
                  list(`Gender` = "gender",
                       `Region` = "region",
                       `Highest Education` = "highest_education",
                       `IMD Band` = "imd_band",
                       `Age Band` = "age_band",
                       `No. of Previous Attempts` = "num_of_prev_attempts",
                       `Disability` = "disability"
                  )
      ),
      
      h4("Course-Based Passing Result"),
      selectInput("module", "Choose a module:",
                  list(`AAA` = "AAA",
                       `BBB` = "BBB",
                       `CCC` = "CCC",
                       `DDD` = "DDD",
                       `EEE` = "EEE",
                       `FFF` = "FFF",
                       `GGG` = "GGG"
                  )
      ),
      selectInput("par2", "Choose a Parameter:",
                  list(`Gender` = "gender",
                       `Region` = "region",
                       `Highest Education` = "highest_education",
                       `IMD Band` = "imd_band",
                       `Age Band` = "age_band",
                       `No. of Previous Attempts` = "num_of_prev_attempts",
                       `Disability` = "disability"
                  ),
                  selected = "region"
      )
      #actionButton("summary", "Show Summary")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      tabsetPanel(type = "tabs",
                  tabPanel("General Passing Rate", br(), 
                           p("This application is based on Open University Learning Dataset. The dataset is taken from:"),
                           a("https://archive.ics.uci.edu/ml/datasets/Open+University+Learning+Analytics+dataset#"),
                           p("It contains data about courses, students and their interactions with Virtual Learning Environment (VLE) for seven selected courses (called modules)."),
                           p("This application reads the studentInfo.csv, which stores the information of final result of the assessment from the seven courses."),
                           p("This tab is basically showing the relationship between number of students passing the assessment from the course and two other variables, taken from some random samples which user specifies the amount on the left."),
                           p("Student is considered passed if his/her final result is either passed or distinction."),
                           p("Directions: "),
                           p("1. Select number of samples you want on the left panel "),
                           p("2. Select a variable to group"),
                           p("3. Select another parameter"),
                           plotOutput("plot1"),
                           br(),
                           textOutput("summaryTitle"),
                           textOutput("numberPassed"),
                           verbatimTextOutput("summary"),
                           tags$head(tags$style("#summary{font-size:10px}"))
                           ),
                  tabPanel("Course-Based Passing Result", br(), 
                           p("This application is based on Open University Learning Dataset. The dataset is taken from:"),
                           a("https://archive.ics.uci.edu/ml/datasets/Open+University+Learning+Analytics+dataset#"),
                           p("It contains data about courses, students and their interactions with Virtual Learning Environment (VLE) for seven selected courses (called modules)."),
                           p("This application reads the studentInfo.csv, which stores the information of final result of the assessment from the seven courses."),
                           p("This tab is showing the relationship between final result of the assessment and a variable picked by user from a specific course."),
                           p("Directions: "),
                           p("1. Select a course you want to explore"),
                           p("2. Select a variable"),
                           plotOutput("plot2")
                           ),
                  tabPanel("Variable Description", br(),
                           p("code_module - an identification code for a module on which the student is registered."),
                           p("code_presentation : the identification code of the presentation during which the student is registered on the module."),
                           p("id_student - a unique identification number for the student."),
                           p("gender - the student's gender."),
                           p("region - identifies the geographic region, where the student lived while taking the module:presentation."),
                           p("highest_education - highest student education level on entry to the module presentation."),
                           p("imd_band - specifies the Index of Multiple Depravation band of the place where the student lived during the module:presentation."),
                           p("age_band - band of the student's age."),
                           p("num_of_prev_attempts - the number times the student has attempted this module."),
                           p("studied_credits - the total number of credits for the modules the student is currently studying."),
                           p("disability - indicates whether the student has declared a disability."),
                           p("final_result - student's final result in the module-presentation.")
                           )
      )
   
    )
  )
  )
)
