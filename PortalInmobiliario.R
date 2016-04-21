
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

Propiedades <- c(NULL,NULL,NULL,NULL,NULL)

for(i in 1:4)
  
  
{
  
  
  url <- read_html(paste("http://www.portalinmobiliario.com/venta/departamento/las-condes-metropolitana?ca=3&ts=1&mn=2&or=&sf=1&sp=0&at=0&pg=",i,sep = ""))
  
  TipoProp1 <- html_nodes(url,"div.col-sm-6.product-item-summary")
  TipoProp <- as.character(TipoProp1)
  TipoProp <- sub(".*?<span class=\"product-type-title\">(.*?)</p>&#13.*", "\\1", TipoProp)
  TipoProp <- sub("</span>","",TipoProp)
  
  
  Codigo <- html_nodes(TipoProp1,"h4")
  Codigo <- as.character(Codigo)
  Codigo <- sub(".*?<h4 data-pid=(.*?)\" data-gid=.*", "\\1", Codigo)
  Codigo <- substr(Codigo,2,7)
  
  Link <- html_nodes(TipoProp1,"a")
  Link <- as.character(Link)
  Link <- sub(".*?<a href=(.*?)>.*", "\\1", Link)
  Link <- sub(substr(Link,1,1),"www.portalinmobiliario.com", Link)
  Link <- stri_sub(Link,1,-2)
  
  DB <- html_nodes(TipoProp1,"span.label.label-default")
  DB <- as.character(DB)
  DB <- sub(".*?>(.*?)</span>.*", "\\1", DB)
  
  Sup <- html_nodes(url,"div.col-sm-9.product-item-data")
  Sup <- html_nodes(Sup,"p.product-property")
  Sup <- html_nodes(Sup,"span.product-property-value")
  Sup <- as.character(Sup)
  Sup <- subset(Sup,substr(Sup,35,40) == "e\" rel")
  Sup <- sub(".*?>(.*?) mÂ²</span>.*", "\\1", Sup)
  
  
  Propiedades1 <- cbind(TipoProp,Codigo,DB,Sup,Link)
  
  Propiedades <- rbind(Propiedades,Propiedades1)
  
  i = i + 1
  
}


Propiedades <- as.data.frame(Propiedades)

Propiedades <- subset(Propiedades,Propiedades$TipoProp != "Proyecto, Venta, Departamento")

x <- Propiedades[,5]

x <- as.character(x)

Detalle <- c(NULL,NULL,NULL,NULL)

for(j in 1:length(x))
  
  {

  y <- read_html(paste("http://",x[j],sep = ""))

  Precio_CLP <- html_nodes(y,"p.price")
  Precio_CLP <- as.character(Precio_CLP)
  Precio_CLP <- sub(".*?>(.*?)</p>.*", "\\1", Precio_CLP)

  Precio_UF <- html_nodes(y,"p.price-ref")
  Precio_UF <- as.character(Precio_UF)
  Precio_UF <- sub(".*?>(.*?)</p>.*", "\\1", Precio_UF)

  Fecha_Cod <- html_nodes(y,"div.content-panel.small-content-panel")
  Fecha_Cod <- as.character(Fecha_Cod)

  Codigo1 <- sub(".*?digo: (.*?) </strong>.*", "\\1", Fecha_Cod)
  Fecha <- sub(".*?Publicada: (.*?)</strong>.*", "\\1", Fecha_Cod)

  Detalle1 <- cbind(Codigo1,Fecha,Precio_CLP,Precio_UF)
  
  Detalle <- rbind(Detalle,Detalle1)
  
  j = j + 1
  
  }
