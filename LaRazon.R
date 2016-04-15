library(dplyr)
library(rvest)
library(ggmap)
library(leaflet)
library(RColorBrewer)
library(httr)
library(stringr)
library(RODBC)

url <- read_html("http://www.la-razon.com/")

Noticia <- html_nodes(url,"h2")
Noticia <- as.character(Noticia)
Noticia <- sub(".*?href=(.*?)\">.*", "\\1", Noticia)
Noticia <- Noticia[substr(Noticia,1,10) != "<h2 class="]
Noticia <- paste("http://www.la-razon.com",Noticia[substr(Noticia,1,10) != "<h2 class="],sep = "")