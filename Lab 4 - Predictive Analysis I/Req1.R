# set the working directory
setwd("D:/CMP/fourth_year/second semester/Big Data/Big-Data-Labs/Lab 4 - Predictive Analysis I")

# cleaning the workspace
rm(list = ls())

# Read the data
play_decision <- read.table("./nbtrain.csv", header = TRUE, sep = ",")
play_decision
summary(play_decision)
