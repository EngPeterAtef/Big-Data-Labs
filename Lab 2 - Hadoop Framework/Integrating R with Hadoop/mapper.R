#! /usr/bin/env Rscript
setwd("/home/bigdata/Desktop/RwithHadoop")
getwd()

# mapper.R - Wordcount program in R
# script for Mapper (R-Hadoop integration)

#to remove white space at the beginning and at the end of the sentences
trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)
#split the text on pattern
#The pattern used for splitting is “[[:space:]]+”,
#which represents one or more consecutive white space characters 
#(such as spaces, tabs, or line breaks).
splitIntoWords <- function(line) unlist(strsplit(line, "[[:space:]]+"))

## **** could wo with a single readLines or in blocks
con <- file("stdin", open = "r") #open the file for reading
# con is the connection to the file (pointer to the file)
# reading the lines from the file



#readLines(con, n = 1, warn = FALSE) 
#reads one line from the input. If no more lines are available, 
#it returns an empty character vector (length 0).
#The warn = FALSE argument suppresses any warnings that might occur during reading.
while (length(line <- readLines(con, n = 1, warn = FALSE)) > 0) { #This constructs a loop that reads lines from the input (stdin) until there are no more lines left.
  line <- trimWhiteSpace(line)
  words <- splitIntoWords(line)
  ## **** can be done as cat(paste(words, "\t1\n", sep=""), sep="")
  for (w in words)
      cat(w, "\t1\n", sep="") #to print the words and 1 to the console
}
close(con)
