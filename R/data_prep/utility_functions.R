# Function to nest duplicated columns after multiple data frames are merged.
#
# Args:
#   df Data frame of joined data frames with duplicated columns.
#   suffixes Character string to match suffixes. E.g., the default "\\.[xy]"
#            finds any columnsending with .x or .y
nest_duplicated <- function(df, suffixes = "\\.[xy]") {
  #library(tidyverse)
  #library(stringr)

  multi_suffix <- stringr::str_c("(", suffixes, ")+")

  # Search string to match any duplicated variables
  search_string <- df %>%
                     dplyr::select(dplyr::matches(suffixes)) %>%
                     names() %>%
                     stringr::str_replace_all(suffixes, "") %>%
                     #stringr::str_replace(multi_suffix, "") %>%
                     unique() %>%
                     stringr::str_c(collapse = "|") %>%
                     stringr::str_c("(", ., ")($|", suffixes, ")")

  # Gather duplicated variables and convert names to stems
  df <- df %>%
          tidyr::gather(variable, value, dplyr::matches(search_string)) %>%
          dplyr::mutate(variable = stringr::str_replace_all(variable, suffixes, ""))
          #dplyr::mutate(variable = stringr::str_replace(variable, multi_suffix, ""))

  # Group by all columns except value to convert duplicated rows into list, then
  # spread by variable (var)
  dots <- names(df)[!stringr::str_detect(names(df), "value")] %>% purrr::map(as.symbol)
  df %>%
    dplyr::group_by_(.dots = dots) %>%
    dplyr::summarise(new = list(value)) %>%
    tidyr::spread(variable, new) %>%
    dplyr::ungroup()
}

# Function to compute mean of vector, but returning NA when all values are NA
#
# Args:
#   x Vector of potentially all missing values
na_mean <- function(x) {
  if (all(is.na(x)))
    return(NA)

  mean(x, na.rm = TRUE)
}

