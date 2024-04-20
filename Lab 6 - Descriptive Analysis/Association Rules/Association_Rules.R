if (FALSE) {
  "
   Stud1:-
   Name: Peter Atef Fathi
    ID: 9202395
    Section: 1
    B.N: 18
    Stud2:-
   Name: Beshoy Morad
    ID: 9202405
    Section: 1
    B.N: 19
   "
}
# Install the arules package
# install.packages("arules")

# Install the arulesViz package
# install.packages("arulesViz")

# 1. First of all, start by cleaning the workspace and setting the working directory.

# set the working directory
setwd("D:/CMP/fourth_year/second semester/Big Data/Big-Data-Labs/Lab 6 - Descriptive Analysis/Association Rules")

# cleaning the workspace
rm(list = ls())

# 2. Load the libraries arules and arulesViz
library(arules)
library(arulesViz)

# 3. Load the transactions in the file AssociationRules.csv using the function read.transactions.
# Make sure you don’t include the header line in the dataset.
# Load the data
data <- read.transactions("AssociationRules.csv", sep = " ", header = FALSE)

# 4. Display the transactions in a readable format using the function inspect. Display only the first 100 transactions.
# Display the transactions
inspect(data[1:100])

# 5. What are the most frequent two items in the dataset? What are their frequencies?
# Hint: use the function itemFrequency or use the function summary.
# Display the most frequent two items
itemFrequency(data, type = "absolute")
# or
summary(data)

# most frequent items are:
# 1-item13: 4948
# 2-item5: 3699

# 6. Plot the 5 most frequent items of the transactions using the function itemFrequencyPlot.
# Plot the 5 most frequent items
itemFrequencyPlot(data, topN = 5)

# 7. Generate the association rules from the transactions using the apriori algorithm.
# Set the minimum support = 0.01, minimum confidence = 0.5, minimum cardinality (number of items in the rule) = 2.
# Use the function apriori
# Generate the association rules
rules <- apriori(data, parameter = list(support = 0.01, confidence = 0.5, minlen = 2))
print(rules)

# 8. Now, sort the generated rules by support. Search the function sort found in the arules package. Show only the first 6 rules.
# Sort the rules by support
print("Rules sorted by support")
sorted_rules_by_support <- sort(rules, by = "support", descreasing = TRUE)
inspect(sorted_rules_by_support[1:6])

# 9. Sort the generated rules by confidence. Show only the first 6 rules.
# Sort the rules by confidence
print("Rules sorted by confidence")
sorted_rules_by_confidence <- sort(rules, by = "confidence", descreasing = TRUE)
inspect(sorted_rules_by_confidence[1:6])

# 10. Sort the generated rules by lift. Show only the first 6 rules.
# Sort the rules by lift
print("Rules sorted by lift")
sorted_rules_by_lift <- sort(rules, by = "lift", descreasing = TRUE)
inspect(sorted_rules_by_lift[1:6])

# 11. Plot the generated rules with support as x-axis, confidence as y-axis and lift as shading.
# Use the function plot in arules package.
# Plot the rules
plot(rules, measure = c("support", "confidence"), shading = "lift", jitter = 0)

# 12. Based on (8-11), Can you tell now what are the most interesting rules that are really
# useful and provide a real business value and an insight to the concerned corporate?

# SOLUTION:
# the most interesting rules are the ones with high lift, high confidence, and high support
# the rules that have high lift values indicate that the antecedent and consequent are dependent on each other
# the rules that have high confidence values indicate that the consequent is highly likely to occur when the antecedent occurs
# the rules that have high support values indicate that the rule is applicable to a large number of transactions
# the rules that have high lift, confidence, and support values are the most interesting rules that provide real business value and insights to the concerned corporate
# sort based on lift then confidence then support
sorted_rules <- sort(rules, by = c("lift", "confidence", "support"), descreasing = TRUE)
inspect(sorted_rules[1:6])

if (FALSE) {
  "
  The most interesting rules are:
    lhs                         rhs      support confidence coverage lift     count
[1] {item15, item30, item56} => {item49} 0.0101  0.7709924  0.0131   19.42046 101
[2] {item30, item56, item84} => {item49} 0.0100  0.7407407  0.0135   18.65846 100
[3] {item15, item30, item49} => {item56} 0.0101  0.9619048  0.0105   16.58456 101
[4] {item15, item56}         => {item49} 0.0101  0.6121212  0.0165   15.41867 101
[5] {item15, item49}         => {item56} 0.0101  0.8632479  0.0117   14.88358 101
[6] {item30, item49, item84} => {item56} 0.0100  0.8000000  0.0125   13.79310 100
 "
}
