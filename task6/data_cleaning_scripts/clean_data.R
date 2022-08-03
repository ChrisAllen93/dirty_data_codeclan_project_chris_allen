
# Load in libraries -------------------------------------------------------

library(tidyverse)
library(janitor)

# Read in data ------------------------------------------------------------

dog_survey <- read_csv("raw_data/dog_survey.csv") %>% clean_names()

# Clean data --------------------------------------------------------------

dog_survey %>%
  # remove empty columns
  select(-(x10:x11)) %>%
  # remove duplicate rows
  distinct() %>%
  # recode data values into format that can be processed later on
  mutate(dog_gender = recode(dog_gender, "1 male and 1 female" = "m,f"),
         dog_age = recode(dog_age, "5 and 4" = "5,4")) %>% 
  # some rows have data for multiple dogs, split cells which have multiple
  mutate(dog_size = str_split(dog_size, ","),
         dog_gender = str_split(dog_gender, ","),
         dog_age = str_split(dog_age, ",")) %>%
  # create additional rows for scenarios where multiple dogs were detected
  unnest(cols = c(dog_size, dog_gender, dog_age)) %>%
  # format and standardise values in gender column
  mutate(dog_gender = str_to_lower(dog_gender),
         dog_gender = case_when(
           dog_gender %in% c("male", "m")  ~ "M",
           dog_gender %in% c("female","f", "femlae")  ~ "F"
         )) %>%
  mutate(dog_age = str_extract(dog_age, "[0-9]+"),
         dog_age = as.numeric(dog_age)) %>% 
  # standardise values in dog_size column to three categories: S, M & L
  mutate(dog_size = case_when(
    dog_size %in% c("XS", "S", "Smallish")  ~ "S",
    dog_size %in% c("M", "Medium sized")  ~ "M",
    dog_size %in% c("XL", "L", "large")  ~ "L"
  )) %>% 
  # extract numeric values from dog food expenses column
  mutate(amount_spent_on_dog_food = str_extract(amount_spent_on_dog_food,
                                                "£[0-9]+.[0-9]+|£[0-9]+"),
         amount_spent_on_dog_food = str_remove(amount_spent_on_dog_food, "£"),
         amount_spent_on_dog_food = as.numeric(amount_spent_on_dog_food)) %>% 
  # split total food expense between the number of dogs for each owner
  group_by(id) %>% 
  mutate(num_dogs = n(),
         amount_spent_on_dog_food = 
           round(amount_spent_on_dog_food / num_dogs, 2)) %>%
  select(-num_dogs) %>% 
  # write cleaned data to file
  write_csv("clean_data/clean_data.csv")