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

url1 <- xmlParse("http://www.eldeber.com.bo/rss/")

Noticia <- xmlToDataFrame(nodes = getNodeSet(url1, "//channel/item"))

T <- c(id = NULL, Titulo = NULL, Texto = NULL, Largo = NULL)

for (i in 1:length(Noticia))
  
{
  url_d <- read_html(Noticia$link[i])
  
  Titulo <- html_nodes(url_d,"h1")
  Titulo <- sub(".*?>(.*?)</h1>.*", "\\1", Titulo)
  
  Texto <- html_nodes(url_d,"div.paragraphs")
  Texto <- sub(".*?<p id=(.*?)<br/></p>\n</div>.*", "\\1", Texto)
  
  T1 <- c(i,Titulo,Texto,nchar(Texto))
  T <- rbind(T,T1)
  
  i = i + 1
}

Base <- data.frame(T)


ch <- odbcConnect("Prensa")
sqlSave(ch, Base, tablename = "ElDeber_Detalle", append = FALSE, rownames = FALSE, colnames = FALSE)
sqlSave(ch, Noticia, tablename = "ElDeber", append = FALSE, rownames = FALSE, colnames = FALSE)