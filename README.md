# README: House Price Prediction Project

### Project Title:
House Price Prediction Using Regression in R

### Description
This project analyzes housing price data and implements both linear and multiple regression models to predict housing prices based on variables such as square footage and lot area. Ridge regression was used to improve model performance by minimizing overfitting.

### Key Features

Simple Linear Regression: Relationship between square footage (GrLivArea) and sale price.

Multiple Regression: Incorporates LotArea and additional features to improve model accuracy.

Ridge Regression: Regularization technique used to prevent overfitting, resulting in a 10% improvement in model accuracy.

### Tools & Libraries Used
Programming Language: R

Libraries: ggplot2, dplyr, glmnet, broom

### Files
HousePricePrediction.R: Main script for building and evaluating regression models.

train.csv: Training dataset used for analysis.

README.md: This documentation.

### How to Run
Clone the repository and load the train.csv file.

Open and run HousePricePrediction.R in RStudio or an R environment.

The script will display plots and model summaries.
