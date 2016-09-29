#' Child Mortality rates and other variables
#'
#' Country-level changes in child mortality rates and related variables over
#' time. Data combined from a number of available data sets. For details
#' regarding the extraction and formation of this data set, please refer to the
#' \href{https://github.com/drsimonj/ourworldindata/blob/master/R/data_prep/prep_childmortality.R}{data
#' prep script}
#'
#' @format A data frame with 37,890 rows and 8 variables:
#' \describe{
#'   \item{year}{Year}
#'   \item{country}{Country}
#'   \item{continent}{Continent}
#'   \item{population}{Total population}
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
#'   \item{poverty}{Poverty headcount ratio at $1.90 a day, or the percentage of
#'   the population living on less than $1.90 a day at 2011 international
#'   prices.}
#' }
#' @source \url{https://ourworldindata.org/child-mortality}
"childmortality"
