
# flip_q_score ------------------------------------------------------------

flip_scores <- function(df, questions) {
  
  df %>% 
    mutate(score = if_else(question_no %in% questions, 10 - score, score))

}