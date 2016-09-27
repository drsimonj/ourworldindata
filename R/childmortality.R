#' Child Mortality rates and other variables
#'
#' Child Mortality rates (0-5 year-olds dying per 1,000 born) vs. other
#' variables. Data combined from a number of available data sets.
#'
#' @format A data frame with 33,461 rows and 6 variables:
#' \describe{
#'   \item{year}{Year}
#'   \item{country}{Country}
#'   \item{continent}{Continent}
#'   \item{child_mort}{Child Mortality (0-5 year-olds dying per 1,000 born). The
#'   under 5 mortality rate is the probability of a child born in a specific
#'   year dying before reaching the age of five if subject to current
#'   age-specific mortality rates.}
#'   \item{health_exp}{Total healthcare expenditure per capita (PPP). Per capita
#'   health expenditure is measured in PPP-adjusted dollars to adjust for price
#'   differences across countries. It covers the provision of health services
#'   (preventive and curative), family planning activities, nutrition activities,
#'   andemergency aid designated for health but does not include provision of
#'   water and sanitation.}
#'   \item{education}{Average years of schooling of the population aged 15 and
#'   over.}
#' }
#' @source \url{https://ourworldindata.org/child-mortality}
"childmortality"
