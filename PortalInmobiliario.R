
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
library(stringi)

Propiedades <- c(NULL,NULL,NULL)

for(i in 1:2)
  
  
{
  

url <- read_html(paste("http://www.portalinmobiliario.com/venta/departamento/las-condes-metropolitana?ca=3&ts=1&mn=2&or=&sf=1&sp=0&at=0&pg=",i,sep = ""))

TipoProp1 <- html_nodes(url,"div.col-sm-6.product-item-summary")
TipoProp <- as.character(TipoProp1)
TipoProp <- sub(".*?<span class=\"product-type-title\">(.*?)</p>&#13.*", "\\1", TipoProp)
TipoProp <- sub("</span>","",TipoProp)


Codigo <- html_nodes(TipoProp1,"h4")
Codigo <- as.character(Codigo)
Codigo <- sub(".*?<h4 data-pid=(.*?)\" data-gid=.*", "\\1", Codigo)
Codigo <- substr(Codigo,1,7)

Link <- html_nodes(TipoProp1,"a")
Link <- as.character(Link)
Link <- sub(".*?<a href=(.*?)>.*", "\\1", Link)
Link <- sub(substr(Link,1,1),"www.portalinmobiliario.com", Link)
Link <- stri_sub(Link,1,-2)

Propiedades1 <- cbind(TipoProp,Codigo,Link)

Propiedades <- rbind(Propiedades,Propiedades1)

i = i + 1

}

