R Notebook
================

# Overview

This project is designed to clean, combine and analyse data from the
infamous dirty data set from the Boing Boing Halloween Candy surveys
(2015 - 2017).

The project is structured such that the raw data is processed via a data
cleaning and wrangling script, joined with data from other years before
being analysed to answer a number of set of questions within an analysis
file.

# Packages

The following packages have been used in this project:  
- tidyverse: Reading in cleaned data, data wrangling functions and use
of the pipe operator (%\>%)  
- here: Relative file references for reproducibility from other users  
- readxl: reading in data from Excel file extensions  
- janitor: Cleaning column names

# Data Cleaning

There are three data input files which make up the total combined
dataset. Each data includes responses to survey questions including
respondent details and responses to a number of questions. The three
data sets used as inputs to this project are:

1.  boing-boing-candy-2015.xlsx - survey results from 2015
2.  boing-boing-candy-2016.xlsx - survey results from 2016
3.  boing-boing-candy-2017.xlsx - survey results from 2017

The data cleaning script (“clean_data.R”) converts each data set into a
standard format (renaming / creating column names where applicable),
removes unnecessary columns, recodes the candy and country names against
a list of expected outputs and finally combines the dataset into one
file and outputs as a .csv file.

The data is now ready for analysis!

# Data Analysis

The cleaned data is read into the analysis file (“data_analysis.Rmd”)
and analysis is undertaken, using mostly dplyr functions, to answer the
following questions:

1.  What is the total number of candy ratings given across the three
    years?
2.  What was the average age of people who are going out trick or
    treating?
3.  What was the average age of people who are not going trick or
    treating?
4.  For each of joy, despair and meh, which candy bar received the most
    of these ratings?
5.  How many people rated Starburst as despair?

For the next set of questions a rating system was introduced and the
following questions were answered:

6.  What was the most popular candy bar by this rating system for each
    gender in the dataset ?
7.  What was the most popular candy bar in each year?
8.  What was the most popular candy bar by this rating for people in US,
    Canada, UK, and all other countries?

The outputs of these questions are located in the analysis file along
with commentary on any assumptions made to arrive at the answer.

# Functions

A couple of bespoke functions were developed during the cleaning process
which sought to standardise a method of converting candy and country
names to “standardised” values. These functions are:

1.  clean_candy_names()
2.  clean_country_names()

Both functions accept a dataframe as an argument and behave in more or
less the same way. The functions undertake some rudimentary data
cleansing methods of the appropriate column values to prepare the data
for the further processing. The values in the column are then recoded by
checking if the column value matches a list of accepted name/countries.
These functions overwrite the “dirty” column with the cleaned column and
output the entire dataframe.
