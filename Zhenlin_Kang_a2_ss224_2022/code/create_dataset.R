library(foreign)
library(readstata13)
library(WDI)
library(base)

setwd("/Users/janine/Library/Mobile Documents/com~apple~CloudDocs/Documents/SS224/Zhenlin_Kang_a2_ss224_2022/data/input/")
# import country level preference data
country <- read.dta13("GPS_dataset_country_level/country.dta")
# import economic and geographic data
wdi.data <- WDI(country = "all", start = 2012, end = 2012, extra = "TRUE")
# import hofstede culture dimensions dataset
culture <- read.csv("hofstede_measure.csv", sep = ";")
# merge income, GDP per capita, longitude, latitude variables to preference dataset
country$income <- wdi.data$income[match(country$isocode, wdi.data$iso3c)]
country$gdppc <- wdi.data$NY.GDP.PCAP.KD[match(country$isocode, wdi.data$iso3c)]
country$longitude <- wdi.data$longitude[match(country$isocode, wdi.data$iso3c)]
country$latitude <- wdi.data$latitude[match(country$isocode, wdi.data$iso3c)]
# merge hofstede culture dimensions
country$pdi <- as.numeric(culture$pdi[match(country$isocode, culture$ctr)])
country$idv <- as.numeric(culture$idv[match(country$isocode, culture$ctr)])
country$mas <- as.numeric(culture$mas[match(country$isocode, culture$ctr)])
country$uai <- as.numeric(culture$uai[match(country$isocode, culture$ctr)])
country$ltowvs <- as.numeric(culture$ltowvs[match(country$isocode, culture$ctr)])
country$ivr <- as.numeric(culture$ivr[match(country$isocode, culture$ctr)])
write.csv(country, file = "country_econ_culture.csv")

