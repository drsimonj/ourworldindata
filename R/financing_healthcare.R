#' Public financing of healthcare and other variables.
#'
#' Country-level changes in the financing of healthcare and related variables over
#' time. Data is a merged version of all datasets available for download at
#' \url{https://ourworldindata.org/financing-healthcare/}. For details regarding the
#' extraction and formation of this data frame, please refer to the
#' \href{https://github.com/drsimonj/ourworldindata/blob/master/R/data_prep/financing_healthcare.R}{data
#' prep script}
#'
#' @format A data frame with XXX rows and XX variables:
#' \describe{
#'   \item{year}{Year}
#'   \item{country}{Country}
#'   \item{continent}{Continent}
#'   \item{health_exp}{Public Health Expenditure as percent of GDP}
#'   \item{health_insurance}{Health Insurance coverage (percent of labour
#'   force)}
#'   \item{nhs_exp}{National Health Service (NHS) expenditure as percent of GDP}
#'   \item{health_exp_private}{Health Expenditure, total  (% of GDP) of private
#'   services (US only)}
#'   \item{health_exp_public}{Health Expenditure, total  (% of GDP) of public
#'   services (US only)}
#' }
#' @source \url{https://ourworldindata.org/financing-healthcare/}
"financing_healthcare"
