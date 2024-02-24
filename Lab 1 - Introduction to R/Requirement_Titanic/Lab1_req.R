  #The first requirement
  #--------------------------------------------------------------------------------#

  #clean environment and remove all variables in the global environment. 
  rm(list=ls())
  #get working directory
  getwd()
  #set working directory
  setwd("D:/CMP/fourth_year/second semester/Big Data/Labs/Big-Data-Labs/Lab 1 - Introduction to R/Requirement_Titanic")  #Replace this working directory with the directory containing the R file.
  #get working directory
  getwd()
  #--------------------------------------------------------------------------------#
  #Getting Started#
  #from csv file 
  dfcsv <- read.csv("titanic.csv",header = TRUE)
  #get dimensions of data frame
  dim(dfcsv)
  nrow(dfcsv)
  ncol(dfcsv)
  #the structure of the data frame. Hint: Use str()
  str(dfcsv)
  #visualize some of the data
  head(dfcsv,n = 10) #first 10 columns
  tail(dfcsv,n = 10)#last 10 columns
  
  #Show summary of all variables in the data frame
  summary(dfcsv)
  
  #Show a summary for the variable age only
  summary(dfcsv$Age)
  
  # What are the first and third quartile values for this variable? What do these values mean?
  # we can get these values from the summery also but this is another way to get the quartiles only
  quantile(dfcsv$Age, probs = c(0.25,0.75) , na.rm = TRUE )
  
  # the first quartile is 20.125 
  # the first quartile is the value under which 25% of data points are found when they are arranged in increasing order
  # or we can say that is the value that falls between the smallest value of the dataset and the median
  
  # the third quartile is 38
  # the third quartile is the value under which 75% of data points are found when they are arranged in increasing order
  # or we can say that is the value that falls between the largest value of the dataset and the median
  
  
  #Are there any missing values in the variable age? (i.e. written as <NA>)?
  anyNA(dfcsv$Age)
  #note the difference between these 2 functions anyNA returns TRUE if there exist any element inside this column has the value any and FALSE otherwise 
  #but is.na for each element in the column retun if it's na or not so output size is the col lengths
  is.na(dfcsv$Age)
  
  #What is the type of the variable embarked? Show the levels of this variable. Is that what you were expecting?
  # type   ==>> character 
  # levels ==>> ""  "C" "Q" "S"
  # not as we expected as there is an empty string in the levels
  typeof(dfcsv$Embarked)
  levels(factor(dfcsv$Embarked))
  #################################################################################
  #################################################################################
  #################################################################################
  #################################################################################
  
  # Can you conclude what’s needed at this step in the data analysis cycle?
  # we need data preprocessing 
  
  #Remove the rows containing <NA> in the age variable.
  dfcsv = subset(dfcsv, !is.na(dfcsv$Age))
  anyNA(dfcsv$Age)
  #Remove the rows containing any unexpected value in the embarked variable from the dataset
  dfcsv = subset(dfcsv, Embarked!="")
  levels(factor(dfcsv$Embarked))
  #Some variables are not very interesting and provide no real indicative value. Remove
  #columns Cabin and Ticket from the dataset.  
  dfcsv = subset(dfcsv, select = -c(Cabin,Ticket))
  head(dfcsv)  
  
  #################################################################################
  #################################################################################
  #################################################################################
  #################################################################################
  gender_table = table(dfcsv$Gender)
  gender_table
  #Plot a pie chart showing the number of males (blue) and females (red)
  pie(gender_table,col = c("red", "blue"))  
  
  #Show the number of people who survived and didn’t survive from each gender
  table2 = table(dfcsv$Gender, dfcsv$Survived)
  table2  
  #Plot a pie chart showing the number of males and females who survived only.
  survived = dfcsv[dfcsv$Survived == 1 ,]
  table3 = table(survived$Gender)
  pie(table3,col = c("red", "blue"))  
  table3  
  # What do you conclude from that?
  # it is obvious that the number of the survived females is larger , althought the number of males 
  # is bigger the number of females in total  
  # Indicate survived passengers with a blue color and un-survived passengers with a red color
  
  table4 = table(dfcsv$Survived,dfcsv$Pclass)
  table4  
  barplot(table4 , col = c("red", "blue"),)  
  
  # What do you conclude from that?
  # the ratio of survivors inversly proportional to the social class
  # lower social class have highest survivors ratio and higher social class have lowest survivors ratio
  boxplot(dfcsv$Age)
  #.What does this plot mean?
  # this graph show the upper and lower extremes values of the age
  # it also show the 1st, 3rd quartiles and median
  # it also show the outliers and their values (the points above the upper extreme)
  summary(dfcsv$Age)
  
  # Plot a density distribution for the variable age
  plot(density(dfcsv$Age))
  #Remove all columns but passenger name and whether they survived or not 
  dfcsv = subset(dfcsv, select = c("Name","Survived"))
  head(dfcsv)  
  #Export the preprocessd dataset
  write.csv(dfcsv, 'titanic_preprocessed.csv', row.names=TRUE)  
  