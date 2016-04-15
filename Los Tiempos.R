library(dplyr)
library(rvest)
library(ggmap)
library(leaflet)
library(RColorBrewer)
library(httr)
library(stringr)
library(RODBC)

url <- read_html("http://www.lostiempos.com/")

Noticia <- html_nodes(url,"td")
Noticia <- as.character(Noticia)
Noticia <- sub(".*?views-field-title(.*?)</a></div></span>.*", "\\1", Noticia)
Noticia <- sub(".*?href=\"(.*?)\">.*", "\\1", Noticia)
Noticia <- paste("http://www.lostiempos.com",Noticia[substr(Noticia,1,1) == "/"],sep = "")

T <- c(id = NULL, Link = NULL, Titulo = NULL, Autor  = NULL, Fecha = NULL, Texto = NULL, Largo = NULL)

for (i in 1:length(Noticia))
    
    {
      url_d <- read_html(Noticia[i])
      
      Titulo <- html_nodes(url_d,"h1")
      Titulo <- sub(".*?>\n          (.*?)        </h1>.*", "\\1", Titulo)
      
      Autor <- html_nodes(url_d,"div.autor")
      Autor <- as.character(Autor)
      Autor <- sub(".*?a href=(.*?)</a>.*", "\\1", Autor)

      Fecha <- html_nodes(url_d,"div.date-publish")
      Fecha <- as.character(Fecha)
      Fecha <- sub(".*?Publicado el (.*?)    </div>.*", "\\1", Fecha)
      
      Texto <- html_nodes(url_d,"div.field-item")
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
