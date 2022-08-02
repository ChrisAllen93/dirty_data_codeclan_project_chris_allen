Task 2 - Cake Ingredients
================

# Overview

This project is designed to clean, manipulate and analyse data related
to cakes and their ingredients.

The project is structured such that the raw data is processed via a data
cleaning and wrangling script before being analysed to answer a number
of set of questions within an analysis file.

# Packages

The following packages have been used in this project:  
- tidyverse: Reading in raw data, data wrangling functions and use of
pipe (%\>%) operator  
- here: Relative file references for reproducibility from other users  
- janitor: Cleaning column names of meteorite data set

# Data Cleaning

The raw data set is processed via a data cleaning script which prepares
the data for analysis. The raw data set consists of two raw data files:

1.  cake-ingredients-1961.csv
2.  cake_ingredient_code.csv

The script (“clean_data.R”) reads in the raw data
(cake-ingredients-1961.csv), cleans column names using the janitor
package and pivots the data into the longer format. This “cleaned” data
set is then joined with the second data set (“cake_ingredient_code.csv”)
to substitute in the ingredient codes with more sensible names and
measurement scales.

The script outputs the cleaned data set as a .csv file into the
clean_data folder, ready for analysis.

# Data Analysis

The cleaned data is read into the analysis file (“data_analysis.Rmd”)
and analysis is undertaken, using mostly dplyr functions, to answer the
following questions:

1.  Which cake has the most cocoa in it?
2.  For sponge cake, how many cups of ingredients are used in total?
3.  How many ingredients are measured in teaspoons?
4.  Which cake has the most unique ingredients?
5.  Which ingredients are used only once?

The outputs of these questions are located in the analysis file along
with commentary on any assumptions made to arrive at the answer.
