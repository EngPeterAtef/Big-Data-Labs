# Logit
# set working directory
setwd("D:/CMP/fourth_year/second semester/Big Data/Big-Data-Labs/Lab 5 - Predictive Analysis II/Logistic Regression Requirement")
rm(list = ls())
getwd()

# Please Answer all the questions
# ===============================
# Logistic Regression, also known as Logit,
# is typically used in models where the dependent
# variables have a binary outcome (True/False, which is coded with 1/0).
# You model the log odds of the outcome
# as a linear combination of predictor variables).

# [Terminology]:
# 0- logit = logistic regression
# 1- output variable = outcome = response variable = dependent variable
# 2- input variables (features) = predictor variables = explanatory variables = drivers = independent variables
# 3- residual: the true value - the predicted value
# 4- fit = train the model
# 5- odds of an event: the likelihood of that event to happen. (anologous to probability but not the same)
# 6- odds ratio = p/(1-p) --> the prob. to occur / the prob to not occur
#                             for example: p = 0.2, 1-p = 0.8 --> odds ratio is 1 to 4
# 7- log odds ratio: log(odds ratio) = log(p/(1-p)) = y = sum_over_i(coeff_i * feature_i), i = 0 to n
# 8- the prob. p from log odds ratio p = 1 / (1 + e^-y) --> sigmoid function


# [Data Description]:
# the marketing campaign team wants to send
# special offers to those respondents with the highest probability of purchase.
# the response variable is purchase or no purchase
# given customer income and age and product price
Mydata <- read.csv("survey.csv", header = TRUE, sep = ",")


# [1] Explore data
table(Mydata$MYDEPV) # the outcome variable
# purchase or no purchase
with(Mydata, table(Price, MYDEPV))
summary(Mydata$Age)
cor.mat <- cor(Mydata[, -1]) # the input variables
cor.mat # Note: The general rule is not to include variables in your model that are
# too highly correlated with other predictors.
# corr 0: independent, corr 1: highly correlated, corr -1: highly correlated in inverse direction

# (Q1) Write the variable pairs that are not correlated at all to each other.
if (FALSE) {
  "
          Price     Income        Age
  Price      1 0.00000000 0.00000000
  Income     0 1.00000000 0.09612083
  Age        0 0.09612083 1.00000000
  "
  # Variables that are not correlated at all to each other are:
  # Price and Income
  # Price and Age
}

# (Q2) Are there any highly correlated variables in this dataset?
# There are no highly correlated variables in this dataset because the correlation values are not close to 1 or -1.

# [2] Test a model with 3 variables Price, Income and Age
mylogit <- glm(MYDEPV ~ Income + Age + as.factor(Price),
  data = Mydata, family = binomial(link = "logit"),
  na.action = na.pass
) # as.factor(Price) : to deal with price as categorical feature
summary(mylogit)
# Additional information:
# ==================
# Read this: http://www.theanalysisfactor.com/r-glm-model-fit/
# Deviance: Deviance is a measure of the "badness" of fit (trained model) of a generalized linear model
#      the smaller the better
# Null Deviance shows how well the response variable is predicted by a model that includes only the intercept
# Residual Deviance: after including the weighted predictors to the intercept
# The quantity: 1 - (Residual deviance/Null deviance)
#      is  called "pseudo-R-squared"; you use it to evaluate "goodness" of fit
# AIC: provides a method for assessing the quality of your model through comparison of related models.
#      it's useful for comparing models, but isn't interpretable on its own.
#      the smaller the better
# Fisher Scoring: This doesn't really tell you a lot of what you need to know,
#      other than the fact that the model did indeed converge, and had no trouble doing it.
# ===== End of additional information =======

# Notice how the price in coefficient section is divided into 2 entries:
# as.factor(Price)20, as.factor(Price)30
if (FALSE) {
  "
   Coefficients:
                   Estimate Std. Error z value Pr(>|z|)
(Intercept)        -6.02116    0.53244 -11.309  < 2e-16 ***
Income              0.12876    0.00923  13.950  < 2e-16 ***
Age                 0.03506    0.01179   2.974  0.00294 **
as.factor(Price)20 -0.74418    0.26439  -2.815  0.00488 **
as.factor(Price)30 -2.21028    0.31108  -7.105  1.2e-12 ***
---
   "
}
# (Q3): How many categories are there for the Price variable?
# There are 3 categories for the Price variable: 10, 20, and 30.
# (Q4): Why is it divided into two entries only in the model?
# The Price variable is divided into two entries because it is a categorical variable.
# for n = 3 categories, you need n-1 dummy variables to represent the categories.
# so we have 2 dummy variables for the Price variable.

# Review the "Estimate" column. For every one unit change in Income (while other variables are constants),
# the log odd ratio of Purchase (not the probability) increases by 0.12876 (the coefficients)

# [3] ROC Curve
if (!require("ROCR")) {
  install.packages("ROCR")
  library(ROCR)
}
#### NOTE: For this part, you need to search and read about the ROC curve.
pred <- predict(mylogit, type = "response") # this returns the probability scores on the training data
predObj <- prediction(pred, Mydata$MYDEPV) # prediction object needed by ROCR

rocObj <- performance(predObj, measure = "tpr", x.measure = "fpr") # creates ROC curve obj
aucObj <- performance(predObj, measure = "auc") # auc object

auc <- aucObj@y.values[[1]]
auc # the auc score: tells you how well the model predicts.
# (Q5.1) Write the value of this expression (just the number)
# 0.915272
# (Q5.2) What is the maximum value of AUC (ideal case)?
# one
# plot the roc curve
plot(rocObj, main = paste("Area under the curve:", auc))

# (Q6) What does each point in the ROC graph represent?
# In other words, what is the value that changes and drives TPR and FPR to change too
# from one point to another in the graph?
# The value that affects the TPR and FPR is the threshold value.
# The threshold value is the value that the model uses to classify the data into classes.
# We draw the ROC curve by changing the threshold value and calculating the TPR and FPR for each threshold value.
# Then we choose the best threshold value that gives the largest AUC value.

# [4] Predictions
# Prediction - 1
Price <- c(10, 20, 30)
Age <- c(mean(Mydata$Age))
Income <- c(mean(Mydata$Income))
newdata1 <- data.frame(Income, Age, Price) # Note: The predict function requires the variables to be named exactly as in the fitted model.
newdata1
newdata1$PurchaseP <- predict(mylogit, newdata = newdata1, type = "response")
newdata1
# (Q7) How is the predicted probability affected by changing only price holding all other variables constant?
if (FALSE) {
  "
   Income    Age Price PurchaseP
1 42.492 35.976    10 0.6707408
2 42.492 35.976    20 0.4918407
3 42.492 35.976    30 0.1826131
   "
  #  As the price increases, the predicted probability of purchase decreases.
  # Holding income and age constant, a higher price leads to a lower likelihood of purchase.
}

# Prediction - 2
newdata2 <- data.frame(
  Age = seq(min(Mydata$Age), max(Mydata$Age), 2),
  Income = mean(Mydata$Income), Price = 30
)
newdata2
newdata2$PurchaseP <- predict(mylogit, newdata = newdata2, type = "response")
newdata2
cbind(newdata2$Age, newdata2$PurchaseP)
plot(newdata2$Age, newdata2$PurchaseP)
# (Q8) How is the predicted probability affected by changing only age holding all other variables constant?
if (FALSE) {
  "
   Age Income Price PurchaseP
1   18 42.492    30 0.1063052
2   20 42.492    30 0.1131540
3   22 42.492    30 0.1203845
4   24 42.492    30 0.1280103
5   26 42.492    30 0.1360445
6   28 42.492    30 0.1444993
7   30 42.492    30 0.1533864
8   32 42.492    30 0.1627160
9   34 42.492    30 0.1724975
10  36 42.492    30 0.1827387
11  38 42.492    30 0.1934457
12  40 42.492    30 0.2046231
13  42 42.492    30 0.2162731
14  44 42.492    30 0.2283958
15  46 42.492    30 0.2409892
16  48 42.492    30 0.2540483
17  50 42.492    30 0.2675657
18  52 42.492    30 0.2815308
19  54 42.492    30 0.2959303
20  56 42.492    30 0.3107477
21  58 42.492    30 0.3259636
22  60 42.492    30 0.3415553
23  62 42.492    30 0.3574973
24  64 42.492    30 0.3737609
25  66 42.492    30 0.3903150
   "
}
# As the age increases, the predicted probability of purchase increases.
# Holding income and price constant, a higher age leads to a higher likelihood of purchase.

# Prediction - 3
newdata3 <- data.frame(Income = seq(20, 90, 10), Age = mean(Mydata$Age), Price = 30)
newdata3$PurchaseP <- predict(mylogit, newdata = newdata3, type = "response")
newdata3
cbind(newdata3$Income, newdata3$PurchaseP)
plot(newdata3$Income, newdata3$PurchaseP)
# (Q9) How is the predicted probability affected by changing only income holding all other variables constant?
if (FALSE) {
  "
     Income    Age Price  PurchaseP
1     20 35.976    30 0.01219091
2     30 35.976    30 0.04281102
3     40 35.976    30 0.13948050
4     50 35.976    30 0.37004640
5     60 35.976    30 0.68039246
6     70 35.976    30 0.88525564
7     80 35.976    30 0.96546923
8     90 35.976    30 0.99022745
   "
}
# As the income increases, the predicted probability of purchase increases.
# Holding age and price constant, a higher income leads to a higher likelihood of purchase.

# Prediction 4
newdata4 <- data.frame(
  Age = round(runif(10, min(Mydata$Age), max(Mydata$Age))),
  Income = round(runif(10, min(Mydata$Income), max(Mydata$Income))),
  Price = round((runif(10, 10, 30) / 10)) * 10
)
newdata4$Prob <- predict(mylogit, newdata = newdata4, type = "response")
newdata4
if (FALSE) {
  "
      Age Income Price      Prob
1   62     59    30 0.8233653
2   64     58    10 0.9756593
3   19     84    20 0.9911343
4   46     65    20 0.9614674
5   30     63    10 0.9586159
6   64     92    20 0.9993413
7   50     54    30 0.6165084
8   53     45    20 0.7083149
9   55     47    30 0.4375177
10  48     75    30 0.9572450
   "
}
