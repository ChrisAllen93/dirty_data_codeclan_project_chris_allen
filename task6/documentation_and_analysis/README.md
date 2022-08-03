Task 6 - Dog owners survey
================

# Overview

This project is designed to clean, manipulate and analyse data related
to dog survey data including owners and dogs personal data.

The project is structured such that the raw data is processed via a data
cleaning and wrangling script before being analysed to answer a number
of set of questions within an analysis file.

# Packages

The following packages have been used in this project:  
- tidyverse: Reading in raw data, data wrangling functions and use of
the pipe operator (%\>%)  
- here: Relative file references for reproducibility from other users  
- janitor: Cleaning column names

# Data Cleaning

The raw data set is process via a data cleaning script (“clean_data.R”)
which prepares the data for analysis. The script takes the raw data,
recodes a number of columns (relevant to answering the analysis
questions) and outputs the cleaned data set as a .csv file into the
clean_data folder, ready for analysis.

### Key assumptions

The following assumptions were made to aid the preparation of the data
for analysis:  
1. For rows in the raw data set where multiple dog details were
contained, it is assumed the order of the values within the field
correspond with the order of data in other fields of the same row.

| Size  | Gender |  Age  |
|:-----:|:------:|:-----:|
| S,L,L | M,M,F  | 3,3,5 |

Corresponds to three dogs with the following information:

| Size | Gender | Age |
|:----:|:------:|:---:|
|  S   |   M    |  3  |
|  L   |   M    |  3  |
|  L   |   F    |  5  |

2.  For rows in the raw data set where multiple dog details were
    contained, the food expenses value is split evenly between each dog
    of the same owner, i.e. if an owner has stated they spend £100 on
    dog food, and they have 3 dogs’ details in the row, then it is
    assumed that £33.33 (£100 / 3) is spent on each dog.

# Data Analysis

The cleaned data is read into the analysis file (“data_analysis.Rmd”)
and analysis is undertaken, using mostly dplyr functions, to answer the
following questions:

1.  The client only counts a valid email address as one ending in
    ‘.com’. How many survey results have a valid email address?
2.  What’s the average amount spent on dog food for each dog size?
3.  For owners whose surname starts with a letter in the second half of
    the alphabet (N onwards) what is the average age of their dog?
4.  The dog_age column is the age in dog years. If the conversion is 1
    human year = 6 dog years, then what is the average human age for
    dogs of each gender?
5.  Create a plot of results of question 4.

The outputs of these questions are located in the analysis file along
with commentary on any assumptions made to arrive at the answer.
