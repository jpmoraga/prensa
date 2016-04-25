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

Noticia <- html_nodes(url,"div.viewport")
Noticia <- html_nodes(Noticia,"ul")
Noticia <- html_nodes(Noticia,"li")



LT <- html_nodes(Noticia,"p")
LT <- as.character(LT)
LT <- strsplit(LT,"title=")

N <- c(NULL,NULL,NULL)

for (i in 1:12)
  
{
  Link <- LT[[i]][1]
  Link <- strsplit(Link,'<a href=\"')
  Link <- Link[[1]][2]
  
    if (substr(Link,1,1) == "/") 
    {
     Link <- paste("http://www.pulso.cl",Link,sep = "")
    }

  Link <- strsplit(Link,'\"')
  Link <- Link[[1]][1]
  
  Titulo <- LT[[i]][2]
  Titulo <- sub(".*?>(.*?)</a>\n</p>.*", "\\1", Titulo)
  
  
  N1 <- cbind(i,Link,Titulo)
  
  N <- rbind(N,N1)
  
  i = i + 1
  
}

N <- as.data.frame(N)

D <- c(NULL,NULL,NULL)
T <- c(NULL,NULL)

for(j in 1:length(N$Link))
  
    {
    
    url_d <- read_html(as.character(N$Link[j]))
    
    Resumen <- html_nodes(url_d,"div.span-16.articleContent.border")
    Resumen <- html_nodes(Resumen,"em")
    Resumen <- as.character(Resumen)
    Resumen <- sub(".*?>(.*?)<p></p></p>\n</em>.*", "\\1", Resumen)
    
    Datos <- html_nodes(url_d,"div.span-16.articleContent.border")
    Datos <- html_nodes(Datos,"em")
    Datos <- as.character(Datos)
    Datos <- sub(".*?>(.*?)<p></p></p>\n</em>.*", "\\1", Datos)
    
    Texto <- html_nodes(url_d,"div.span-16.articleContent.border")
    Texto <- html_nodes(Texto,"p")
    Texto <- as.character(Texto)
    Texto <- sub("<p>","",Texto)
    Texto <- sub("</p>","",Texto)
    
    D1 <- cbind(j,Datos,Resumen)
    D <- rbind(D,D1)
    
    T1 <- cbind(j,Texto)
    T <- rbind(T,T1)
    
    j = j + 1
    
    }

D <- as.data.frame(D)
T <- as.data.frame(T)