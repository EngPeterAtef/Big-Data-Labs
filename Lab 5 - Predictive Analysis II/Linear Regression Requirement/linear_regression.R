# set working directory
setwd("D:/CMP/fourth_year/second semester/Big Data/Big-Data-Labs/Lab 5 - Predictive Analysis II/Linear Regression Requirement")
rm(list = ls())
getwd()
# =============================Part(1)=====================================
x <- runif(100, 0, 10) # 100 draws between 0 & 10

# (Q1) Try changing the value of standard deviation (sd) in the next command
# How do the data points change for different values of standard deviation? Answer in documents
y <- 5 + 6 * x + rnorm(100, sd = 2) # default values for rnorm (mean = 0 and sigma = 1)

# Plot it
plot(x, y)

# OLS model
# OLS : Ordinary Least Squares
model1 <- lm(y ~ x)
# Learn about this object by saying ?lm and str(d)

# Compact model results
print(model1)

# (Q2) How are the coefficients of the linear model affected by changing the value
# of standard deviation in Q1?

# Regression diagnostics --
ypred <- predict(model1) # use the trained model to predict the same training data
# Learn about predict by saying ?predict.lm

par(mfrow = c(1, 1))
plot(y, y, type = "l", xlab = "true y", ylab = "predicted y") # ploting the ideal line
points(y, ypred) # plotting the predicted points
# the nearer to the ideal line the better

# Detailed model results
d1 <- summary(model1)
d1
print(model1)

# (Q3) How is the value of R-squared affected by changing the value
# of standard deviation in Q1?

# Learn about this object by saying ?summary.lm and by saying str(d1)
cat(
    "OLS gave slope of ", d1$coefficients[2, 1],
    "and an R-sqr of ", d1$r.squared, "\n"
)

# Graphic dignostic (cont.)
par(mfrow = c(1, 1)) # parameters for the next plot
plot(model1, 1) # plot one diagnostic graphs

# (Q4)What do you conclude about the residual plot? Is it a good residual plot?
# ========================End of Part(1)==============================================

# ========================Part(2)=====================================================
# Training a linear regression model
x1 <- runif(100)
# introduce a slight nonlinearity
# (A)
non_linear_term_coeff <- 10
y1 <- 5 + 6 * x1 + non_linear_term_coeff * x1 * x1 + rnorm(100)
plot(x1, y1)
model <- lm(y1 ~ x1)

summary(model)

# Creating a test set (test vector)
# EDIT: We renamed the variable as x1 instead of xtest (in previous versions)
# becaues the lm function searches in the formula for variables named
# with x1 and not any other name.
# So, if you used xtest, the lm function will not know what is xtest and
# a random plot will be generated.

x1 <- runif(100) # test vector
# (B)
ytrue <- 5 + 6 * x1 + non_linear_term_coeff * x1 * x1 + rnorm(100) # same equation of y1 but on xtest to get true y for xtest

ypred <- predict(model, data.frame(x1))

par(mfrow = c(1, 1))
plot(ytrue, ytrue, type = "l", xlab = "true y", ylab = "predicted y")
points(ytrue, ypred)

# graphic dignostic (cont.)
par(mfrow = c(1, 1)) # parameters for the next plot
plot(model, 1) # plot the diagnostic graphs

# (Q5)What do you conclude about the residual plot? Is it a good residual plot?

# (Q6)Now, change the coefficient of the non-linear term in the original model for (A) training
# and (B) testing to a large value instead. What do you notice about the residual plot?
# ===============================End of Part(2)=============================================

# =================================Part(3)==================================================
# (Q7) Import the dataset LungCapData.tsv. What are the variables in this dataset?
LungCapData <- read.table("LungCapData.tsv", header = TRUE, sep = "\t")

# (Q8) Draw a scatter plot of Age (x-axis) vs. LungCap (y-axis). Label x-axis "Age" and y-axis "LungCap"
plot(LungCapData$Age, LungCapData$LungCap, xlab = "Age", ylab = "LungCap")
# (Q9) Draw a pair-wise scatter plot between Lung Capacity, Age and Height.
# Check the slides for how to plot a pair-wise scatterplot
pairs(LungCapData[, c("LungCap", "Age", "Height")])

# (Q10) Calculate correlation between Age and LungCap, and between Height and LungCap.
# Hint: You can use the function cor
age_lung <- cor(LungCapData$Age, LungCapData$LungCap)

# (Q11) Which of the two input variables (Age, Height) are more correlated to the
# dependent variable (LungCap)?
height_lung <- cor(LungCapData$Height, LungCapData$LungCap)
# compare the two values of correlation
if (age_lung > height_lung) {
    print("Age is more correlated to LungCap")
} else {
    print("Height is more correlated to LungCap")
}
# Height is more correlated to LungCap

# (Q12) Do you think the two variables (Height and LungCap) are correlated ? why ?
height_lung
# The correlation between Height and LungCap is 0.9121873 which is a high correlation.
# This means that the two variables are correlated.

# (Q13) Fit a liner regression model where the dependent variable is LungCap
# and use all other variables as the independent variables
model <- lm(LungCap ~ ., data = LungCapData)

# (Q14) Show a summary of this model
d2 <- summary(model)
d2
# (Q15) What is the R-squared value here ? What does R-squared indicate?
cat("R-sqr = ", d2$r.squared, "\n")
# R-sqr is 0.8542478 which is a high value. This means that the model is a good fit.

# (Q16) Show the coefficients of the linear model. Do they make sense?
# If not, which variables don't make sense? What should you do?
cat("OLS gave slope of ", d2$coefficients)
if (FALSE) {
    "
    Coefficients:
                Estimate Std. Error t value Pr(>|t|)
    (Intercept)  -11.32249    0.47097 -24.041  < 2e-16 ***
    Age            0.16053    0.01801   8.915  < 2e-16 ***
    Height         0.26411    0.01006  26.248  < 2e-16 ***
    Smokeyes      -0.60956    0.12598  -4.839 1.60e-06 ***
    Gendermale     0.38701    0.07966   4.858 1.45e-06 ***
    Caesareanyes  -0.21422    0.09074  -2.361   0.0185 *
    ---
    "
}
# Age:
# The coefficient for age is approximately 0.16.
# It suggests that, on average, for each one-unit increase in age, the response variable increases by 0.16 (assuming other predictors are constant).
# This makes sense, as older individuals might have different outcomes compared to younger ones.
# Height:
# The coefficient for height is approximately 0.26.
# It implies that, on average, for each one-unit increase in height, the response variable increases by 0.26 (assuming other predictors are constant).
# I think it's larger than the coefficient for age because taller people might be younger and stronger and have higher lung capacity.
# Smokeyes:
# The coefficient for smokeyes is approximately -0.61.
# It suggests that individuals with “smokeyes” (presumably related to smoking) have a lower response value.
# Negative coefficients make sense if we assume that smoking negatively impacts the outcome.
# Gendermale:
# The coefficient for gendermale is approximately 0.39.
# It indicates that being male is associated with a higher response value so they have higher lung capacity.
# This aligns with Caesareanyes because being a woman is associated with having Caesarean delivery and vice versa.
# Caesareanyes:
# The coefficient for caesareanyes is approximately -0.21.
# It suggests that individuals who had a Caesarean section have a lower response value.
# This makes sense if we consider the impact of Caesarean delivery on health outcomes so they have lower lung capacity.

# (Q17) Redraw a scatter plot between Age and LungCap. Display/Overlay the linear model (a line) over it.
# Hint: Use the function abline(model, col="red").
# Note (1) : A warning will be displayed that this function will display only the first two
#           coefficients in the model. It's OK.
# Note (2) : If you are working correctly, the line will not be displayed on the plot. Why?
plot(LungCapData$Age, LungCapData$LungCap, xlab = "Age", ylab = "LungCap")
abline(model, col = "red")

# (Q18)Repeat Q13 but with these variables Age, Smoke and Cesarean as the only independent variables.
model <- lm(LungCap ~ Age + Smoke + Caesarean, data = LungCapData)
# (Q19)Repeat Q16, Q17 for the new model. What happened?
d3 <- summary(model)
d3

cat("R-sqr = ", d3$r.squared, "\n")
# it's noticed that we got a lower R-squared value than the previous model.
if (FALSE) {
    "
Coefficients:
             Estimate Std. Error t value Pr(>|t|)
(Intercept)   1.10867    0.18419   6.019 2.79e-09 ***
Age           0.55617    0.01439  38.639  < 2e-16 ***
Smokeyes     -0.64310    0.18681  -3.443 0.000609 ***
Caesareanyes -0.14603    0.13468  -1.084 0.278610
---
   "
}

cat("OLS gave slope of ", d3$coefficients)
# Age:
# The coefficient for age is approximately 0.56.
# It suggests that, on average, for each one-unit increase in age, the response variable increases by 0.56 (assuming other predictors are constant).
# This makes sense, as older individuals might have different outcomes compared to younger ones.
# Smokeyes:
# The coefficient for smokeyes is approximately -0.64.
# It suggests that individuals with “smokeyes” (presumably related to smoking) have a lower response value.
# Negative coefficients make sense as smoking negatively impacts the outcome.
# Caesareanyes:
# The coefficient for caesareanyes is approximately -0.15.
# It suggests that individuals who had a Caesarean section have a lower response value.
# This makes sense if we consider the impact of Caesarean delivery on health outcomes.
# Also, the absolute value of Caesareanyes is less than the absolute value of Smokeyes which means that the impact of smoking is more than the impact of Caesarean delivery on lung capacity.


plot(LungCapData$Age, LungCapData$LungCap, xlab = "Age", ylab = "LungCap")
# now we can see the line because we have only two coefficients
abline(model, col = "red")

# (Q20)Predict results for this regression line on the training data.
ypred <- predict(model)
# plot the predicted values
plot(LungCapData$Age, LungCapData$LungCap, xlab = "Age", ylab = "LungCap")
points(LungCapData$Age, ypred, col = "red")

# (Q21)Calculate the mean squared error (MSE)of the training data.
mse <- mean((LungCapData$LungCap - ypred)^2)
mse
