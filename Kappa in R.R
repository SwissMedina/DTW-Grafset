library(tidyverse)
library(dplyr)
library(psych)
library(irr)

setwd("C:/Users/PHBELID20000/PHBern/Sägesser, Judith - Grafos2020/2_Pfaeff/10 Vergleich Beurteilung/Training MA grafset/Interrater T2") # hier Pfad festlegen, wo Datei abgelegt ist
GrafoIR <- read.csv("Bericht_Jan.csv") # Datei einlesen von Person deren Interrater berechnet werden soll



### pivot wider ###

GrafoIR<-rename(GrafoIR,Beurteilung=BuBeurteilungDurch) # Variable umbenennen (damit nicht mit Bu beginnt)

GrafoIR<-GrafoIR %>% 
  pivot_longer(cols = starts_with("Bu"),
               names_to = "Figur",
               values_to = "Jan",    # hier Name von Person einsetzen, für welche Interrater berechnet werden soll
               values_drop_na = TRUE)

View(GrafoIR)

### merge with R1 & R11###

setwd("C:/Users/PHBELID20000/PHBern/Sägesser, Judith - Grafos2020/2_Pfaeff/10 Vergleich Beurteilung/Training MA grafset")
Grafo<-read.csv("Kappa_Referenz R1R11.csv") # Datei einlesen mit Richtwerten Auswertungen Judith & Lidia
View(Grafo)


Inter <- left_join(Grafo, GrafoIR, by = c("KiCode", "Figur"))  # Dateien mit Richtwerten Ju&Li mit Ratings von beurteilenden Person zusammenführen
View(Inter)


Inter <- subset(Inter[-c(6,7,8)]) # irrelevante Spalten entfernen

### Calculate Kappa###

cohen.kappa(Inter[,c(5,6)]) # Vergleiche zwischen Personen erstellen jeweils bei c die vergleichenden Spaltennummer einfüllen/ersetzen
kappa2(Inter[,c(4,9)], "equal") 
kappa2(Inter[,c(5,9)], "equal")




            