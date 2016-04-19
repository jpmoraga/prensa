#################################NOTICIAS##############################################

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

url1 <- xmlParse("http://www.elmostrador.cl/feed/")

Titulo <- xmlToDataFrame(getNodeSet(url1, "//channel/item/title"))
Link <- xmlToDataFrame(getNodeSet(url1, "//channel/item/link"))
Fecha <- xmlToDataFrame(getNodeSet(url1, "//channel/item/pubDate"))

Noticia <- cbind(Id = seq.int(nrow(Titulo)),Titulo,Link,Fecha)

T <- c(id = NULL, Texto = NULL)

for (i in 1:length(as.character(Link)))
  
{
  url_d <- read_html(as.character(Link[i,]))
  
  Texto <- html_nodes(url_d,"div.col-xs-12.col-sm-8.col-md-10.cuerpo-noticia")
  Texto <- html_nodes(Texto,"p")
  Texto <- as.character(Texto)
  
  T1 <- c(Id = i, Texto)
  T <- rbind(T,T1)
  
  i = i + 1
}

Base_N <- data.frame(T)

BaseTextos_N <- T

###########################################MERCADOS##########################################

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

url1 <- xmlParse("http://www.elmostrador.cl/mercados/feed/")

Titulo <- xmlToDataFrame(getNodeSet(url1, "//channel/item/title"))
Link <- xmlToDataFrame(getNodeSet(url1, "//channel/item/link"))
Fecha <- xmlToDataFrame(getNodeSet(url1, "//channel/item/pubDate"))

Noticia <- cbind(Id = seq.int(nrow(Titulo)),Titulo,Link,Fecha)

T <- c(id = NULL, Texto = NULL)

for (i in 1:length(as.character(Link)))
  
{
  url_d <- read_html(as.character(Link[i,]))
  
  Texto <- html_nodes(url_d,"div.col-xs-12.col-sm-8.col-md-10.cuerpo-noticia")
  Texto <- html_nodes(Texto,"p")
  Texto <- as.character(Texto)
  
  T1 <- c(Id = i, Texto)
  T <- rbind(T,T1)
  
  i = i + 1
}

Base_M <- data.frame(T)

BaseTextos_M <- T

###########################################TV##########################################

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

url1 <- xmlParse("http://www.elmostrador.cl/tv/feed/")

Titulo <- xmlToDataFrame(getNodeSet(url1, "//channel/item/title"))
Link <- xmlToDataFrame(getNodeSet(url1, "//channel/item/link"))
Fecha <- xmlToDataFrame(getNodeSet(url1, "//channel/item/pubDate"))

Noticia <- cbind(Id = seq.int(nrow(Titulo)),Titulo,Link,Fecha)

T <- c(id = NULL, Texto = NULL)

for (i in 1:length(as.character(Link)))
  
{
  url_d <- read_html(as.character(Link[i,]))
  
  Texto <- html_nodes(url_d,"div.col-xs-12.col-sm-8.col-md-10.cuerpo-noticia")
  Texto <- html_nodes(Texto,"p")
  Texto <- as.character(Texto)
  
  T1 <- c(Id = i, Texto)
  T <- rbind(T,T1)
  
  i = i + 1
}

Base_TV <- data.frame(T)

BaseTextos_TV <- T

###########################################CULTURA##########################################

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

url1 <- xmlParse("http://www.elmostrador.cl/cultura/feed/")

Titulo <- xmlToDataFrame(getNodeSet(url1, "//channel/item/title"))
Link <- xmlToDataFrame(getNodeSet(url1, "//channel/item/link"))
Fecha <- xmlToDataFrame(getNodeSet(url1, "//channel/item/pubDate"))

Noticia <- cbind(Id = seq.int(nrow(Titulo)),Titulo,Link,Fecha)

T <- c(id = NULL, Texto = NULL)

for (i in 1:length(as.character(Link)))
  
{
  url_d <- read_html(as.character(Link[i,]))
  
  Texto <- html_nodes(url_d,"div.col-xs-12.col-sm-8.col-md-10.cuerpo-noticia")
  Texto <- html_nodes(Texto,"p")
  Texto <- as.character(Texto)
  
  T1 <- c(Id = i, Texto)
  T <- rbind(T,T1)
  
  i = i + 1
}

Base_C <- data.frame(T)

BaseTextos_C <- T

###########################################DEPORTES##########################################

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

url1 <- xmlParse("http://www.elmostrador.cl/deportes/feed/")

Titulo <- xmlToDataFrame(getNodeSet(url1, "//channel/item/title"))
Link <- xmlToDataFrame(getNodeSet(url1, "//channel/item/link"))
Fecha <- xmlToDataFrame(getNodeSet(url1, "//channel/item/pubDate"))

Noticia <- cbind(Id = seq.int(nrow(Titulo)),Titulo,Link,Fecha)

T <- c(id = NULL, Texto = NULL)

for (i in 1:length(as.character(Link)))
  
{
  url_d <- read_html(as.character(Link[i,]))
  
  Texto <- html_nodes(url_d,"div.col-xs-12.col-sm-8.col-md-10.cuerpo-noticia")
  Texto <- html_nodes(Texto,"p")
  Texto <- as.character(Texto)
  
  T1 <- c(Id = i, Texto)
  T <- rbind(T,T1)
  
  i = i + 1
}

Base_D <- data.frame(T)

BaseTextos_D <- T
