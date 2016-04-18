library(dplyr)
library(rvest)
library(ggmap)
library(leaflet)
library(RColorBrewer)
library(httr)
library(stringr)
library(RODBC)
library(sqldf)

url <- read_html("http://ellibero.cl/ultimo-minuto/")

Noticia <- html_nodes(url,"div.cols.um-historico")
Noticia <- as.character(Noticia)
Noticia <- strsplit(Noticia, "class=\"fecha\">")
Noticia <- Noticia[[1]]

Hora <- substr(Noticia,1,23)
Link <- sub(".*?<a href=\"(.*?)\">.*", "\\1", Noticia)
Titulo <- sub(".*?<h2>(.*?)</h2>.*", "\\1", Noticia)

Noticia <- cbind(Hora,Link,Titulo)
Noticia <- cbind(Id = seq.int(nrow(Noticia)), Pag = "P1" ,Noticia)

for (i in 2:length(Link))
  
{
  url_d <- read_html(Link[i])
  
  Texto <- html_nodes(url_d,"div.single-content.content")
  Texto <- as.character(Texto)
  Texto <- sub(".*?class=\"single-content content\">(.*?)\n\t\t\t\t</div>.*", "\\1", Texto)
  Texto <- sub(".*?\t<p>(.*?)</p>\n&#.*", "\\1", Texto)
  
  T1 <- c(Id = i,Texto)
  T <- rbind(T,T1)
  
  i = i + 1
}

BaseFinal <- merge(x = Noticia, y = T, by = "Id")
names(BaseFinal)[5]<-paste("Texto")


###################################################################################

Base <- c(Id = NULL, Pag = NULL, Hora = NULL, Link = NULL, Texto = NULL)

for (j in 2:466)
  
{

url <- read_html(paste("http://ellibero.cl/ultimo-minuto/page/",2,sep = ""))

Noticia <- html_nodes(url,"div.cols.um-historico")
Noticia <- as.character(Noticia)
Noticia <- strsplit(Noticia, "class=\"fecha\">")
Noticia <- Noticia[[1]]

Hora <- substr(Noticia,1,23)
Link <- sub(".*?<a href=\"(.*?)\">.*", "\\1", Noticia)
Titulo <- sub(".*?<h2>(.*?)</h2>.*", "\\1", Noticia)

Noticia <- cbind(Hora,Link,Titulo)
Noticia <- cbind(Id = seq.int(nrow(Noticia)), Pag = paste("P",2,sep = "") ,Noticia)

T <- c(Id = NULL, Texto = NULL)

    for (i in 2:length(Link))
  
    {
      url_d <- read_html(Link[i])
  
      Texto <- html_nodes(url_d,"div.single-content.content")
      Texto <- as.character(Texto)
      Texto <- sub(".*?class=\"single-content content\">(.*?)\n\t\t\t\t</div>.*", "\\1", Texto)
      Texto <- sub(".*?\t<p>(.*?)</p>\n&#.*", "\\1", Texto)
    
      T1 <- c(Id = i,Texto)
      T <- rbind(T,T1)
  
      i = i + 1
    }

BaseFinal1 <- merge(x = Noticia, y = T, by = "Id")
names(BaseFinal1)[5]<-paste("Texto")

Base <- rbind(Base, BaseFinal1)

j = j + 1

}

BaseF <- rbind(BaseFinal,Base)

