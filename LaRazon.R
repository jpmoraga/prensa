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
Noticia <- sub(".*?href=\"(.*?)\">.*", "\\1", Noticia)
Noticia <- Noticia[substr(Noticia,1,10) != "<h2 class="]
Noticia <- paste("http://www.la-razon.com",Noticia[substr(Noticia,1,10) != "<h2 class="],sep = "")

T <- c(id = NULL, Link = NULL, Titulo = NULL, Autor  = NULL, Fecha = NULL, Texto = NULL, Largo = NULL)

for (i in 1:length(Noticia))
  
{
  url_d <- read_html(Noticia[1])
  
  Titulo <- html_nodes(url_d,"h2.headline.headline-regular")
  Titulo <- as.character(Titulo)
  Titulo <- sub(".*?>(.*?)</h2>.*", "\\1", Titulo)
  
  Autor <- html_nodes(url_d,"span.meta-author")
  Autor <- as.character(Autor)
  Autor <- sub(".*?>(.*?)</span>.*", "\\1", Autor)
  
  Hora <- html_nodes(url_d,"span.meta-timestamp")
  Hora <- as.character(Hora)
  Hora <- sub(".*?>(.*?)</span>.*", "\\1", Hora)
  
  Fecha <- html_nodes(url_d,"span.meta-datestamp")
  Fecha <- as.character(Fecha)
  Fecha <- sub(".*?>(.*?)</span>.*", "\\1", Fecha)
  
  Texto <- html_nodes(url_d,"p.mce")
  Texto <- Texto[2]
  Texto <- as.character(Texto)
  Texto <- sub(".*?content:encoded(.*?)</div>.*", "\\1", Texto)
  Texto <- str_trim(Texto,c("both"))
  
  T1 <- c(i,Noticia[i],Titulo,Autor,Fecha,Texto,nchar(Texto))
  T <- rbind(T,T1)
  
  i = i + 1
}

Base <- data.frame(T)

ch <- odbcConnect("Prensa")
sqlSave(ch, Base, tablename = "LosTiempos", append = TRUE, rownames = FALSE, colnames = TRUE)