#' Public financing of healthcare and other variables.
#'
#' Country-level changes in the financing of healthcare and related variables over
#' time. Data is a merged version of all datasets available for download at
#' \url{https://ourworldindata.org/financing-healthcare/}. For details regarding the
#' extraction and formation of this data frame, please refer to the
#' \href{https://github.com/drsimonj/ourworldindata/blob/master/R/data_prep/financing_healthcare.R}{data
#' prep script}
#'
#' @format A data frame with 36,873 rows and 17 variables:
#' \describe{
#'   \item{year}{Year}
#'   \item{country}{Country}
#'   \item{continent}{Continent}
#'   \item{health_exp_public}{Public Health Expenditure as percent of GDP}
#'   \item{health_insurance}{Health Insurance coverage (percent of labour
#'   force)}
#'   \item{nhs_exp}{National Health Service (NHS) expenditure as percent of GDP}
#'   \item{health_exp_private}{Health Expenditure, total  (% of GDP) of private
#'   services (US only)}
#'   \item{health_insurance_govt}{Health Insurance Coverage by government
#'   programs (US only)}
#'   \item{health_insurance_private}{Health Insurance Coverage by private
#'   programs (US only). Not mutually exclusive from health_insurance_govt}
#'   \item{health_insurance_any}{Health Insurance Coverage by any program (US
#'   only)}
#'   \item{health_exp_total}{Total Healthcare expenditure by country (% of
#'   corresponding national GDP)}
#'   \item{health_exp_public_percent}{Public expenditure on healthcare as
#'   percent of total healthcareexpenditure}
#'   \item{health_exp_oop_percent}{Out-of-pocket expenditure on healthcare as
#'   percent of total healthcare expenditure. 'Out-of-pocket' refers to
#'   directoutlays made by households, including gratuities and in-kind
#'   payments, to healthcare providers}
#'   \item{no_health_insurance}{Percentage of persons without health insurance
#'   (US only)}
#'   \item{gdp}{Gross domestic product. Description by the World Bank: "GDP per
#'   capita based on purchasing power parity (PPP). PPP GDP is gross domestic
#'   product converted to international dollars using purchasing power parity
#'   rates. An international dollar has the same purchasing power over GDP as
#'   the U.S. dollar has in the United States. GDP at purchaser's prices is the
#'   sum of gross value added by all resident producers in the economy plus any
#'   product taxes and minus any subsidies not included in the value of the
#'   products. It is calculated without making deductions for depreciation of
#'   fabricated assets or for depletion and degradation of natural resources.
#'   Data are in constant 2011 international dollars.}
#'   \item{life_expectancy}{Life expectancy at birth, total (years). Indicates
#'   the number of years a newborn infant would live if prevailing patterns of
#'   mortality at the time of its birth were to stay the same throughout its
#'   life.}
#'   \item{child_mort}{Child Mortality (0-5 year-olds dying per 1,000 born). The
#'   under 5 mortality rate is the probability of a child born in a specific
#'   year dying before reaching the age of five if subject to current
#'   age-specific mortality rates.}
#'
#' }
#' @source \url{https://ourworldindata.org/financing-healthcare/}
"financing_healthcare"
