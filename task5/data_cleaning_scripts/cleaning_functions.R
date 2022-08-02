
# flip_q_score ------------------------------------------------------------

flip_q_score <- function(df, questions) {
  
  for (q in questions) {
    new_name <- paste0(q, "f")
    df[q] = 10 -  df[q]
  }
  
  df
}
