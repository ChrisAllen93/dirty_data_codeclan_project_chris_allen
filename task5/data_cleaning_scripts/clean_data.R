

# Load in libraries -------------------------------------------------------

library(tidyverse)
library(janitor)


# Read in data ------------------------------------------------------------

rwa_raw <- read_csv("raw_data/rwa.csv") %>% clean_names()


# Clean data --------------------------------------------------------------

# Re-code gender, hand, urban and education columns
rwa_recoded <- rwa_raw %>% 
  mutate(id = row_number(),
         gender = case_when(
           gender == 1 ~ "Male",
           gender == 2 ~ "Female",
           gender == 3 ~ "Other"
         ),
         hand = case_when(
           hand == 1 ~ "Right",
           hand == 2 ~ "Left",
           hand == 3 ~ "Both"
         ),
         urban = case_when(
           urban == 1 ~ "Rural",
           urban == 2 ~ "Suburban",
           urban == 3 ~ "Urban"
         ),
         education_level = case_when(
           education == 1 ~ "Less than high school",
           education == 2 ~ "High School",
           education == 3 ~ "University degree",
           education == 4 ~ "Graduate degree"
         )
  )

# Clean / Wrangle data
rwa_clean <- rwa_recoded %>%
  filter(surveyaccurate == 1) %>% 
  select(id, starts_with(c("q", "e")), testelapse, education, urban, gender, 
         age, hand, familysize) %>%
  pivot_longer(q1:e22, names_to = "category", values_to = "value") %>% 
  separate(category, c("category", "question_no"), sep = 1) %>% 
  mutate(question_no = as.integer(question_no)) %>% 
  pivot_wider(names_from = category, values_from = value) %>% 
  rename(q_score = q, elapsed_time = e) %>% 
  select(id, question_no, q_score, elapsed_time, testelapse, everything())


# calculate RWA score for each participant - RWA score is defined as the mean
# score from questions 3 - 22 of which a subset of these questions' scores need
# to be flipped first.

# define which question numbers are to be flipped
scores_to_flip <- c(4, 6, 8, 9, 11, 13, 15, 18, 20, 21)

rwa_scores <- rwa_clean %>%
  # flip scores if question number matches value in scores_to_flip vector
  mutate(q_score = if_else(question_no %in% scores_to_flip, 10 - q_score , 
                           q_score), .after = q_score) %>%
  group_by(id) %>%
  # only select questions relevant to RWA score
  filter(question_no >= 3 & question_no <= 22) %>%   
  # calculate RWA score
  summarise(rwa_score = mean(q_score))

# join RWA score to cleaned dataset and remove question scores / times, and 
# output as clean data file
rwa_clean %>%
  select(-(question_no:elapsed_time)) %>% 
  distinct() %>% 
  inner_join(rwa_scores, by = "id") %>% 
  relocate(rwa_score, .before = testelapse) %>% 
  write_csv("clean_data/clean_data.csv")













