install.packages("ggplot2")
install.packages("dplyr")
install.packages("broom")
install.packages("ggpubr")
install.packages("glmnet")

library(ggplot2)
library(dplyr)
library(broom)
library(ggpubr)
library(glmnet)

housing_data = read.csv("train.csv")

head(housing_data[1:5,1:25])

# Load ggplot2
library(ggplot2)

# Plotting Sale Price and Sqaure Footage columns
ggplot(housing_data, aes(x = GrLivArea, y = SalePrice)) +
  geom_point() +
  labs(title = "Scatter Plot of Price and Square Footage", x = "Square Footage", y = "Sale Price")

# Linear relationship. As square footage goes up, so does price.

# Linear regression (simple regression)
linear = lm(GrLivArea ~ SalePrice, data = housing_data)

# Regression equation
equation = summary(linear)$coefficients

# Plot again with linear regression line
ggplot(housing_data, aes(x = SalePrice, y = GrLivArea)) +
  geom_point() +
  geom_smooth(linear = "lm", se = FALSE, color = "blue") +
  labs(title = "Scatter Plot: Price vs Square Footage with Regression Line",
       x = "Price", y = "Square Footage")

summary(linear)

plot(linear)

# Linear regression (multiple regression)

# Checking the correlation between the independent variables
cor(housing_data$GrLivArea, housing_data$LotArea)

# Check linearity
ggplot(housing_data, aes(x = LotArea, y = SalePrice)) +
  geom_point() +
  labs(title = "Scatter Plot of Sale Price and Lot Area", x = "Lot Area", y = "Sale Price")

ggplot(housing_data, aes(x = GrLivArea, y = SalePrice)) +
  geom_point() +
  labs(title = "Scatter Plot of Sale Price and Square Footage", x = "Square Footage", y = "Sale Price")

# I see a linearity in both as well as no correlation.

# Multiple regression

multi_linear = lm(SalePrice ~ GrLivArea + LotArea, data = housing_data)

summary(multi_linear)

plot(multi_linear)

# Create a new dataframe with information needed to visualize
plotting_data = expand.grid(
  GrLivArea = seq(min(housing_data$GrLivArea), max(housing_data$GrLivArea), length.out = 30),
  LotArea = c(min(housing_data$LotArea), mean(housing_data$LotArea), max(housing_data$LotArea))
)

# Make predictions based on linear model
plotting_data$predicted.y = predict.lm(multi_linear, newdata = plotting_data)


# Make Lot Area a factor
plotting_data$LotArea = as.factor(plotting_data$LotArea)

# Plot original data first
sale_plot = ggplot(housing_data, aes(x = GrLivArea, y = SalePrice)) +
  geom_point()

sale_plot

# Add regression lines

sale_plot = sale_plot +
  geom_line(data = plotting_data, aes(x = GrLivArea, y = predicted.y, color = LotArea), size = 1.25)

sale_plot

#### Attempts of improving model ####

# One thing I can do is check residuals
plot(residuals(multi_linear), pch = 16)

# Ridge regression
ridge_model = cv.glmnet(as.matrix(housing_data[, c("GrLivArea", "OverallCond")]), 
                          housing_data$SalePrice, alpha = 0)

# Print the optimal lambda (lambda.min)
cat("Optimal lambda:", ridge_model$lambda.min, "\n")

# Plot
plot(ridge_model)
