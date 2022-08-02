
# Load in libraries -------------------------------------------------------

library(tidyverse)
library(janitor)

# Read in data ------------------------------------------------------------

cake_ingredients <- read_csv("raw_data/cake-ingredients-1961.csv")
ingredient_codes <- read_csv("raw_data/cake_ingredient_code.csv")

# Clean data --------------------------------------------------------------

cake_ingredients %>%
  # create 'long' dataset so all ingredients are in a single column
  pivot_longer(!Cake, names_to = "ingredient_code") %>% 
  # remove all NAs from dataset
  drop_na() %>% 
  # join ingredient code data set to the cake ingredients data set
  left_join(ingredient_codes, by = c("ingredient_code" = "code")) %>% 
  clean_names() %>% 
  select(cake, ingredient, value, measure) %>% 
  write_csv("clean_data/clean_data.csv")
