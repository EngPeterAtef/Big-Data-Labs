#! /usr/bin/env Rscript

# reducer.R - Wordcount program in R
# script for Reducer (R-Hadoop integration)

trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)

splitLine <- function(line) {
  val <- unlist(strsplit(line, "\t")) #split the line on tab
  list(word = val[1], count = as.integer(val[2]))
}
#the environnment in R is a hash table
env <- new.env(hash = TRUE)

con <- file("stdin", open = "r")
while (length(line <- readLines(con, n = 1, warn = FALSE)) > 0) {
  line <- trimWhiteSpace(line)
  split <- splitLine(line)
  word <- split$word
  count <- split$count
  # lo al word mawgoda fel environment hat al value bta3tha we zawdha be 1
  if (exists(word, envir = env, inherits = FALSE)) {
      oldcount <- get(word, envir = env)
      assign(word, oldcount + count, envir = env)
  }
  # lw msh mawgoda initialize the word with the count from the line
  else assign(word, count, envir = env)
}
close(con)

for (w in ls(env, all = TRUE))
  cat(w, "\t", get(w, envir = env), "\n", sep = "")
