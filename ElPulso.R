
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

N <- c(NULL,NULL,NULL)

for (i in 1:4)
  
    {
    Link <- LT[[i]][1]
    Link <- strsplit(Link,'<a href=\"')
    Link <- Link[[1]][2]
    Link <- paste("http://www.pulso.cl",Link,sep = "")

    Titulo <- LT[[i]][2]
    Titulo <- sub(".*?>(.*?)</a>\n</h1>.*", "\\1", Titulo)
    

    N1 <- cbind(i,Link,Titulo)
    
    N <- rbind(N,N1)
    
    i = i + 1
    
}

Resumen <- html_nodes(Noticia,"p")
Resumen <- sub(".*?<p>(.*?)</p>.*", "\\1", Resumen)

Base <- cbind(N,Resumen)