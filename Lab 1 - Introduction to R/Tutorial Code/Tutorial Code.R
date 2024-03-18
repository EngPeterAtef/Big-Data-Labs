  #Lab 1 Introduction to R Language
  #--------------------------------------------------------------------------------#

  # library("swirl")
  # swirl()

  #clean environment and remove all variables in the global environment. 
  rm(list=ls())
  #display work items
  ls()
  str = "the first variable"
  #display work items
  ls()
  #get working directory
  getwd()
  #set working directory
  setwd("D:/CMP/fourth_year/second semester/Big Data/Labs/Big-Data-Labs/Lab 1 - Introduction to R/Tutorial Code")  #Replace this working directory with the directory containing the R file.
  #get working directory
  getwd()
  #--------------------------------------------------------------------------------#
  #Getting Started#
  str <- "Hello World1"
  str = "Hello world2"
  "hello world3" -> str
  print(str)
  str2 <- str
  str <- "hello "
  str[0] <- "o" #the first place is the datatype
  str[1] <- "o"
  #--------------------------------------------------------------------------------#
  #Comments#
  #This is a single line comment in R.
  #R does not support multi-line comments but you can perform a trick which is something as follows
  if(FALSE) {
    "This is a demo for multi-line comments and it should be put inside either a 
        single OR double quote"
  }
  #--------------------------------------------------------------------------------#
  #In contrast to other programming languages like C and java in R, the variables are not 
  #declared as some data type. The variables are assigned with R-Objects and the data type 
  #of the R-object becomes the data type of the variable. 
  
  #There are many types of R-objects. The frequently used ones are:
  #Vectors, Lists, Matrices, Arrays, Factors, Data Frames.
  
  #vectors in R
  #There are six data types of these atomic vectors:
  v1 <- c(1,2,3,4.5,2,3) #numeric
  #numbers in R = numberic
  v2 <- c("tree","street","car") #character
  #indexing start from 1 as v2[0] holds the datatype of this vector
  v3 <- c(TRUE , FALSE ,TRUE) #logical
  
  v4 <- c(23L, 192L, 0L) #integer
  #L for interger
  v5 <- c(3+2i, 4-5i, -2i) #complex
  v6 <- charToRaw("Hello") #raw
  #charToRaw btrg3 al asci bta3 kol character inside the string we bykon al datatype bta3 al arkam ali gwa raw object
  v7 <- c(6,"data", 22.5, TRUE,v1)
  #Question: v7 <- c("data", 22.5, TRUE) What will be the type of v7?
  typeof(v7)
  #we can see that the data type of v7 is character hay3ni hwa by3ml cast le kol al elements and this case 7awlhom string
  
  #Get the length of a vector
  length(v3)
  #Extracting elements
  #(1)
  
  #Positive integers return elements at the specified positions (even if duplicate):
  #=================================================================================
  v1 <- c(10, 20, 30, 40, 50, 60)
  v1[2]#1 indexed
  v1[c(2,4)] # it will not return a range but it will return the index 2 and 4
  v1[c(4,4)] #it will return the index 4 twice
  v1[2:5] #this indexing range from 2 to 5 and 5 including
  v1[5:2] #it will return the same range as the privous line bs bel 3ks ya3ni hyrg3 5,4,3,2
  v1[c(2.2,3.6)]  #Real numbers are silently truncated to integers so it could be used as indecies.
  #(2)
  #Negative integers omit (remove) elements at the specified positions:
  #============================================================
  v1 <- v1[-3] 
  v1 #that will remove the element of index 3 and return a new vector without this element bs hia m4 bt8yr inplace
  temp = v1[-c(2,1)] #it will remove the index 2 and 1
  v1
  #note that it doesn't change in place
  temp
   
  #(3)
  #Logical Vectors
  #=================
  v1 <- c(1,2,3,4.5,3,2)
  #it will return vector of the same size contains bool: true when condition is true and false otherwire (like python)
  v1>2 
  v1==2
  v1!=2
  v1[v1>2] #that will return the elements ali rg3t true
  2%in%v1 #check if 2 in v1
  9%in%v1 #check 9 in v1
  #If the logical vector is shorter than the vector being subsetted,
  #it will be recycled to be the same length.
  v1[v3] #hykrr v3 l7d ma yb2a nfs al length bta3 v1 
  # ya3ni hyb2a v1[TRUE FALSE  TRUE TRUE FALSE  TRUE]
  # v3 = TRUE FALSE  TRUE
  v2[v3] #hna m4 hykrr al atnan nfs al length
  # what if the length of V1 less than V3, it will truncate V3 and use from V3 the length of V1
  #(4) Sorting vectors and displaying information
  #=============================================
  #Sort elements.
  sorted_v1 = sort(v1)    #it doesn't sort in place
  #note that al variable
  sort(v1, decreasing = TRUE)  #Seek help for sort.int for example 
  #Display vectors' information (al environment)
  str(v1)
  #Display summary of vectors (mean, median, min, max, 1st and 3rd quartiles)
  summary(v1)
  #(5)Assignment and vector manipulation
  v4 <- v1[c(2,4)]
  v1[3] -> v5
  v6 = v4 + 2
  v7 <- v1+v4  #broadcasting the small vector to the long vector
  #hykrr V4 l7d ma yb2a nfs al length bta3 V1
  v7
  #--------------------------------------------------------------------------------#
  #(5)Factors
  #============================================
  f <- factor(v1)
  f #it holds al vector we al unique elements inside it (levels)
  v8 <- c(v2, "car", "plane")
  factor(v8)
  
  #(6)lists
  #============================================
  list1 <- list(2,'car',TRUE)
  #al list by4el data types mot5lfs 3adi we kol element gwaha bykon vector we gwah al element da
  list1
  list1[[2]] #that returns the vector in this index
  typeof(list1[[2]])
  #Notice the difference
  list2 <- c(2,'car',TRUE)
  list2 #vector not list
  l <- list(v1,v2)
  l
  summary(l[[1]])
  str(l)
  l[1] #that return sub-list of the big list ya3ni list gwaha ali fel index 1
  l[2] 
  l[[1]] #that returns the vector in this index
  l[[2]][2] #that access the vector and return the element
  #Structured Data Types
  #============================================
  #(7) Matrix 
  #============
  cells <- seq(10,80,by=10) #de tare2a a3ml beha vector mn sequence numbers seq(start,end,by=step)
  rnames <- c("R1", "R2","R3") #row names
  cnames <- c("C1", "C2","C3") #column names
  mymatrix <- matrix(cells, nrow = 3, ncol = 3, byrow =TRUE, dimnames = list(rnames, cnames))
  if(FALSE){
    "
    Warning message:
In matrix(cells, nrow = 3, ncol = 3, byrow = TRUE, dimnames = list(rnames,  :
  data length [8] is not a sub-multiple or multiple of the number of rows [3]
    =>this warning 34an al matrix al mafrod ykon feha 9 elements wel data ali a7na ba3tnha 8 bs 34an al sequence feh 8
    we hwa hykrr al data l7d ma ymla la matrix
    "
  }
  mymatrix
  #second column => index
  mymatrix[,2]
  #or equivalently => name
  mymatrix[,"C2"]
  #second and third column
  mymatrix[,c("C2","C3")]
  #first row
  mymatrix[1,]
  #all matrix except second row=>lma a3ml fel mamtrix minus 7aga by4lha bardo zai al vector bs m4 inplace
  mymatrix[-2,]
  mymatrix
  #first row and all columns without the first the 3rd column
  mymatrix[1,-3]
  #--------------------------------------------------------------------------------#
  #(8) IMPORTANT: Data Frames
  #============================
  d <- c(1,2,3,4,4,4)
  e <- c("red", "white", "red", NA,"red","red")
  f <- c(TRUE,TRUE,TRUE,FALSE,FALSE,NA)
  # we pass to the data frame columns of data we lo ma2oltlo4 asma2 al columns bya4od nfs ama2 al vectros ali na mdhalo 
  mydata <- data.frame(d,e,f)
  mydata
  colnames(mydata) <- c("ID","Color","Passed") # variable names
  mydata
  
  # identify elements in data frames 
  mydata[1,] #extract first row of the data frame
  mydata[2] #extract the second column
  mydata[2:3] # columns 2,3 of data frame
  mydata[c("ID","Color")] # columns ID and color from data frame
  
  mydata$ID # variable ID in the data frame
  mydata$Passed # variable Passed in the data frame
  
  #Subsetting the dataframe based on one or more conditions.
  subdfm<- subset(mydata, ID <= 3, select=c(ID,Color))
  subdfm
  
  subdfm<- subset(mydata, ID <= 3 & Color == 'red', select=c(ID,Color))
  subdfm
  #Can we write it in another way?
  mydata[mydata$ID <= 3, c('ID', 'Color')]
  with(mydata, mydata[ID<=3, c('ID','Color')])
  
  #(9) IMPORTANT: Tables = frequency array/co-occurence matrix
  #=======================
  #Create contingency table
  t<- table(mydata$ID)
  t
  table(mydata$Color, mydata$Passed)
  table(mydata$Color, mydata$Passed, mydata$ID)
  #(10)
  #===============================================================
  #Testing arguments whether they belong to a certain class or not
  is.matrix(mymatrix)
  is.list(mymatrix)
  is.matrix(list1)
  is.list(list1)
  #Attempting to turn arguments into certain classes
  mymatrix
  vectorizedMatrix <- as.vector(mymatrix) #ba7wl mn al matrix le vector we by5liha by column by defualt
  vectorizedMatrix
  
  #(11)
  #Importing data from csv files and reading data into a data frame
  #================================================================
  dfm <- read.csv("forestfires.csv")
  dfm$X
  #get dimensions of data frame
  dim(dfm)
  nrow(dfm)
  ncol(dfm)
  #visualize some of the data
  head(dfm) #first 6 columns
  tail(dfm)#last 6 columns
  summary(dfm)
  table(dfm$month)
  table(dfm$month, dfm$day)
  #--------------------------------------------------------------------------------#
  #examples of importing files 
  #text files 
  dftxt <- read.table("testfile.txt",header = FALSE,sep=" ")
  dftxt
  #from csv file 
  dfcsv <- read.csv("csvone.csv",header = TRUE)
  dfcsv
  #--------------------------------------------------------------------------------#
  #(12)Graphical and Statistical Functions
  #=======================================
  #Graphical functions 
  v1 <- c(1,2,3,3.6,4.5,2,3) #numeric
  plot(v1, type="b")  #Check the type of plot
  #There are many plots that can be drawn: pie chart, bar plot, box and whisker plot. 
  #Check them. 
  hist(v1)
  #Statistical functions
  mean(v1)
  median(v1)
  sd(v1)
  var(v1)
  #--------------------------------------------------------------------------------#
  #(13)Functions
  #=============
  #Function to calculate the Euclidean distance between two 2D points.
  euclideanDistance <- function(x,y) sqrt((x[1] - x[2])^2 + (y[1] - y[2])^2)
  euclideanDistance(c(2,3), c(4,5))
  #--------------------------------------------------------------------------------#
  #(14) Flow control statements
  #=============================
  names <- c('Ali', 'Hussein', 'Ahmed')
  if ('Ali' %in% names) {
    print('Ali exists')
  } else if ('Hussein' %in% names) {  #Note that you should write the closing braces together with else if keyword on the same line
    print('Hussein exists')
  } else { 
    print('Neither Ali nor Hussein exists')
  }
  
  for (name in names)
    print(name)
  #--------------------------------------------------------------------------------#
  #(15)String Manipulation
  #=======================
  paste(names[1], names[2], names[3]) #concatinate string with each other separated by space
  paste(names[1], names[2], names[3],  sep= "+")
  toupper(names[1])
  tolower(names[2])
  
  