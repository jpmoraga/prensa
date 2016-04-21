
library(dplyr)
library(rvest)
library(ggmap)
library(leaflet)
library(RColorBrewer)
library(httr)
library(stringr)
library(RODBC)
library(sqldf)
library(XML)

url <- read_html("http://www.pulso.cl/")

Noticia <- html_nodes(url,"div.span-10.border.clearfix")
Noticia <- html_nodes(Noticia,"div.itemView")



LT <- html_nodes(Noticia,"h1")
LT <- as.character(LT)
LT <- strsplit(LT,"title=")

####LT[[1]][1]


