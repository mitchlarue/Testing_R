install.packages("dplyr")
install.packages("tidyr")
install.packages("ggplot2")
install.packages("data.table")
install.packages("tidyverse")
install.packages("viridis")
install.packages("hrbrthemes")
install.packages("zoo")
install.packages("maps")
install.packages("choroplethr")
install.packages("choroplethrMaps")
install.packages("reshape2")

library(dplyr)
library(tidyr)
library(ggplot2)
library(choroplethr)
library(choroplethrMaps)
library(viridis)
library(hrbrthemes)
library(reshape2)
clim_data = read.csv("D:/Downloads/GlobalLandTemp/GlobalLandTemperaturesByState.csv", header = TRUE)

clim_data %>%
    filter(Country == "United States") %>%
    separate(col = dt, into = c("Year", "Month", "Day"), convert = TRUE) -> clim_data  
clim_data = na.omit(clim_data)

clim_data

clim_data %>%
filter(State !="Hawaii" & State!="Alaska") -> clim_data1
clim_data1 <- na.omit(clim_data1)
print(clim_data1)

clim_data1 %>%
filter(Year>1900) %>%
group_by(Year) %>%
summarise(Temp = mean(AverageTemperature)) -> clim_data2
print(clim_data2)

qplot(Year, Temp, data=clim_data2, main="Average Temperature 1900-2013", geom=c("point","smooth")) + aes(color = Temp) + scale_color_gradient(low="grey", high="red")

clim_data$State <- as.character(clim_data$State)
clim_data$State[clim_data$State=="Georgia (State)"] <- "Georgia"
clim_data$State<- as.factor(clim_data$State)

clim_data %>%
select(Year, AverageTemperature, State) %>%
group_by(Year,State) %>%
summarize(value = mean(AverageTemperature), .groups = 'drop') -> clim_data3

colnames(clim_data3)[2] <- "region" 
clim_data3$region<-tolower(clim_data3$region)

clim_data3 %>%
filter(Year==1900) -> clim_data1900
clim_data1900<-clim_data1900[,2:3]

clim_data1900

print(state_choropleth(clim_data1900,
                       title="Land Temperature 1900", 
                       num_colors = 8,
                       legend="Degrees"),reference_map=TRUE)

clim_data3 %>%
filter(Year==2000) -> clim_data2000
clim_data2000<-clim_data2000[,2:3]

print(state_choropleth(clim_data2000,
                       title="Land Temperature 2000", 
                       num_colors = 8,
                       legend="Degrees"),reference_map=TRUE)

ggplot(clim_data3, aes(x=Year, y=value, color=as.factor(region))) +
geom_point(size=3) +
facet_wrap(∼region) +
theme(legend.position="none")

clim_data3 %>%
    filter(region == "washington") -> wa_clim
wa_clim <- na.omit(wa_clim)

wa_clim

ggplot(wa_clim, aes(x=Year, y=value, color=as.factor(region))) +
geom_point(size=3) +
facet_wrap(∼region) +
theme(legend.position="none")

clim_data3 %>%
    filter(region == "oregon") -> or_clim
or_clim <- na.omit(or_clim)

or_clim

ggplot(or_clim, aes(x=Year, y=value, color=as.factor(region))) +
geom_point(size=3) +
facet_wrap(∼region) +
theme(legend.position="none")

com_clim <- merge(wa_clim, or_clim, by = 'Year')

com_clim

wa_temp = wa_clim$value

or_temp = or_clim$value

dif_temp <- or_temp - wa_temp

dif_temp

com_clim$TempDiff <- dif_temp

com_clim

ggplot(com_clim, aes(x=Year, y=TempDiff, color = "red", group = 1)) +
stat_boxplot()

ggplot(com_clim, aes(x=Year, y=TempDiff)) +
geom_bin_2d()

com_clim %>%
rename(WA = region.x ,
       WA_temperature = value.x,
      OR = region.y ,
      OR_temperature = value.y,
      ) -> com_clim

com_clim

com_clim1 <- subset(com_clim, select = -TempDiff)

com_clim1

ggplot(com_clim1, aes(x=Year, y=WA_temperature, color = "red")) + 
geom_smooth()

g <- ggplot(com_clim1, aes(x=Year))
g <- g + geom_smooth(aes(y=WA_temperature, color = "red"))
g <- g + geom_smooth(aes(y=OR_temperature)) + 
ggtitle("Plot of WA and OR Temperature") +
xlab("Year") + ylab("WA Temperature and OR Temperature, WA is red")


g



mdf <- melt(com_clim1, id = c("Year", "WA", "OR"))
mdf

ggplot(mdf)+
geom_smooth(aes(x=Year, y=value, col=variable))


