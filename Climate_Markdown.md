## Install the Packages. I installed a few packages I don't use throughout the project. 
```R
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
```

```R
library(dplyr)
library(tidyr)
library(ggplot2)
library(choroplethr)
library(choroplethrMaps)
library(viridis)
library(hrbrthemes)
library(reshape2)
clim_data = read.csv("D:/Downloads/GlobalLandTemp/GlobalLandTemperaturesByState.csv", header = TRUE)
```
    

```R
clim_data %>%
    filter(Country == "United States") %>%
    separate(col = dt, into = c("Year", "Month", "Day"), convert = TRUE) -> clim_data  
clim_data = na.omit(clim_data)
```
After loading the data, lets visualize it. 

```R
head(clim_data)
```


<table class="dataframe">
<caption>A data.frame: 141930 × 7</caption>
<thead>
	<tr><th></th><th scope=col>Year</th><th scope=col>Month</th><th scope=col>Day</th><th scope=col>AverageTemperature</th><th scope=col>AverageTemperatureUncertainty</th><th scope=col>State</th><th scope=col>Country</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>1743</td><td>11</td><td>1</td><td>10.722</td><td>2.898</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>6</th><td>1744</td><td> 4</td><td>1</td><td>19.075</td><td>2.902</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>7</th><td>1744</td><td> 5</td><td>1</td><td>21.197</td><td>2.844</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>8</th><td>1744</td><td> 6</td><td>1</td><td>25.290</td><td>2.879</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>9</th><td>1744</td><td> 7</td><td>1</td><td>26.420</td><td>2.841</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>11</th><td>1744</td><td> 9</td><td>1</td><td>21.735</td><td>2.866</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>12</th><td>1744</td><td>10</td><td>1</td><td>15.630</td><td>2.872</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>13</th><td>1744</td><td>11</td><td>1</td><td>11.198</td><td>2.806</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>14</th><td>1744</td><td>12</td><td>1</td><td> 7.063</td><td>2.823</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>15</th><td>1745</td><td> 1</td><td>1</td><td> 6.931</td><td>2.838</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>16</th><td>1745</td><td> 2</td><td>1</td><td> 8.621</td><td>2.750</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>17</th><td>1745</td><td> 3</td><td>1</td><td>11.232</td><td>2.757</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>18</th><td>1745</td><td> 4</td><td>1</td><td>16.799</td><td>2.749</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>75</th><td>1750</td><td> 1</td><td>1</td><td> 7.444</td><td>2.724</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>76</th><td>1750</td><td> 2</td><td>1</td><td> 9.311</td><td>2.956</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>77</th><td>1750</td><td> 3</td><td>1</td><td>13.229</td><td>3.127</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>78</th><td>1750</td><td> 4</td><td>1</td><td>17.303</td><td>2.761</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>79</th><td>1750</td><td> 5</td><td>1</td><td>21.966</td><td>2.823</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>80</th><td>1750</td><td> 6</td><td>1</td><td>24.568</td><td>2.800</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>81</th><td>1750</td><td> 7</td><td>1</td><td>28.464</td><td>2.787</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>82</th><td>1750</td><td> 8</td><td>1</td><td>27.126</td><td>2.734</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>83</th><td>1750</td><td> 9</td><td>1</td><td>22.742</td><td>2.773</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>84</th><td>1750</td><td>10</td><td>1</td><td>15.084</td><td>2.778</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>86</th><td>1750</td><td>12</td><td>1</td><td> 6.950</td><td>2.852</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>87</th><td>1751</td><td> 1</td><td>1</td><td> 7.167</td><td>2.847</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>88</th><td>1751</td><td> 2</td><td>1</td><td> 7.740</td><td>2.912</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>89</th><td>1751</td><td> 3</td><td>1</td><td>13.688</td><td>2.847</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>90</th><td>1751</td><td> 4</td><td>1</td><td>16.803</td><td>2.777</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>92</th><td>1751</td><td> 6</td><td>1</td><td>25.701</td><td>2.803</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>93</th><td>1751</td><td> 7</td><td>1</td><td>27.315</td><td>2.743</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>...</th><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><th scope=row>149716</th><td>2011</td><td> 4</td><td>1</td><td> 2.900</td><td>0.189</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149717</th><td>2011</td><td> 5</td><td>1</td><td> 7.113</td><td>0.229</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149718</th><td>2011</td><td> 6</td><td>1</td><td>13.953</td><td>0.255</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149719</th><td>2011</td><td> 7</td><td>1</td><td>19.922</td><td>0.205</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149720</th><td>2011</td><td> 8</td><td>1</td><td>19.515</td><td>0.131</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149721</th><td>2011</td><td> 9</td><td>1</td><td>13.959</td><td>0.113</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149722</th><td>2011</td><td>10</td><td>1</td><td> 7.224</td><td>0.144</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149723</th><td>2011</td><td>11</td><td>1</td><td>-1.407</td><td>0.222</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149724</th><td>2011</td><td>12</td><td>1</td><td>-5.806</td><td>0.214</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149725</th><td>2012</td><td> 1</td><td>1</td><td>-3.808</td><td>0.287</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149726</th><td>2012</td><td> 2</td><td>1</td><td>-4.910</td><td>0.251</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149727</th><td>2012</td><td> 3</td><td>1</td><td> 4.259</td><td>0.128</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149728</th><td>2012</td><td> 4</td><td>1</td><td> 7.111</td><td>0.292</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149729</th><td>2012</td><td> 5</td><td>1</td><td>10.369</td><td>0.209</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149730</th><td>2012</td><td> 6</td><td>1</td><td>17.366</td><td>0.239</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149731</th><td>2012</td><td> 7</td><td>1</td><td>21.363</td><td>0.192</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149732</th><td>2012</td><td> 8</td><td>1</td><td>19.468</td><td>0.245</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149733</th><td>2012</td><td> 9</td><td>1</td><td>14.491</td><td>0.221</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149734</th><td>2012</td><td>10</td><td>1</td><td> 5.455</td><td>0.264</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149735</th><td>2012</td><td>11</td><td>1</td><td> 1.884</td><td>0.139</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149736</th><td>2012</td><td>12</td><td>1</td><td>-5.374</td><td>0.375</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149737</th><td>2013</td><td> 1</td><td>1</td><td>-6.491</td><td>0.229</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149738</th><td>2013</td><td> 2</td><td>1</td><td>-5.130</td><td>0.329</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149739</th><td>2013</td><td> 3</td><td>1</td><td>-0.210</td><td>0.209</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149740</th><td>2013</td><td> 4</td><td>1</td><td> 1.673</td><td>0.282</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149741</th><td>2013</td><td> 5</td><td>1</td><td>10.607</td><td>0.208</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149742</th><td>2013</td><td> 6</td><td>1</td><td>16.267</td><td>0.276</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149743</th><td>2013</td><td> 7</td><td>1</td><td>20.222</td><td>0.133</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149744</th><td>2013</td><td> 8</td><td>1</td><td>19.621</td><td>0.217</td><td>Wyoming</td><td>United States</td></tr>
	<tr><th scope=row>149745</th><td>2013</td><td> 9</td><td>1</td><td>15.811</td><td>1.101</td><td>Wyoming</td><td>United States</td></tr>
</tbody>
</table>


Temperature for CONUS

```R
clim_data %>%
filter(State !="Hawaii" & State!="Alaska") -> clim_data1
clim_data1 <- na.omit(clim_data1)
head(clim_data1)
```


<table class="dataframe">
<caption>A data.frame: 6 × 7</caption>
<thead>
	<tr><th></th><th scope=col>Year</th><th scope=col>Month</th><th scope=col>Day</th><th scope=col>AverageTemperature</th><th scope=col>AverageTemperatureUncertainty</th><th scope=col>State</th><th scope=col>Country</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>1743</td><td>11</td><td>1</td><td>10.722</td><td>2.898</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>2</th><td>1744</td><td> 4</td><td>1</td><td>19.075</td><td>2.902</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>3</th><td>1744</td><td> 5</td><td>1</td><td>21.197</td><td>2.844</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>4</th><td>1744</td><td> 6</td><td>1</td><td>25.290</td><td>2.879</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>5</th><td>1744</td><td> 7</td><td>1</td><td>26.420</td><td>2.841</td><td>Alabama</td><td>United States</td></tr>
	<tr><th scope=row>6</th><td>1744</td><td> 9</td><td>1</td><td>21.735</td><td>2.866</td><td>Alabama</td><td>United States</td></tr>
</tbody>
</table>


Let's get some more recent data. 

```R
clim_data1 %>%
filter(Year>1900) %>%
group_by(Year) %>%
summarise(Temp = mean(AverageTemperature)) -> clim_data2
head(clim_data2)
```


<table class="dataframe">
<caption>A tibble: 6 × 2</caption>
<thead>
	<tr><th scope=col>Year</th><th scope=col>Temp</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1901</td><td>10.62789</td></tr>
	<tr><td>1902</td><td>10.66416</td></tr>
	<tr><td>1903</td><td>10.26386</td></tr>
	<tr><td>1904</td><td>10.03563</td></tr>
	<tr><td>1905</td><td>10.32431</td></tr>
	<tr><td>1906</td><td>10.86005</td></tr>
</tbody>
</table>




```R
qplot(Year, Temp, data=clim_data2, main="Average Temperature 1900-2013", geom=c("point","smooth")) + aes(color = Temp) + scale_color_gradient(low="grey", high="red")
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'
    
    


    
![png](output_6_1.png)
    

Convert the Georgia (State) into Georgia.

```R
clim_data$State <- as.character(clim_data$State)
clim_data$State[clim_data$State=="Georgia (State)"] <- "Georgia"
clim_data$State<- as.factor(clim_data$State)
```
Get Data ready for choropleth mapping. 

```R
clim_data %>%
select(Year, AverageTemperature, State) %>%
group_by(Year,State) %>%
summarize(value = mean(AverageTemperature), .groups = 'drop') -> clim_data3

colnames(clim_data3)[2] <- "region" 
clim_data3$region<-tolower(clim_data3$region)

clim_data3 %>%
filter(Year==1900) -> clim_data1900
clim_data1900<-clim_data1900[,2:3]
```


```R
clim_data1900
```


<table class="dataframe">
<caption>A tibble: 51 × 2</caption>
<thead>
	<tr><th scope=col>region</th><th scope=col>value</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>alabama             </td><td>17.059167</td></tr>
	<tr><td>alaska              </td><td>-5.146500</td></tr>
	<tr><td>arizona             </td><td>15.742917</td></tr>
	<tr><td>arkansas            </td><td>15.893417</td></tr>
	<tr><td>california          </td><td>14.515750</td></tr>
	<tr><td>colorado            </td><td> 7.470917</td></tr>
	<tr><td>connecticut         </td><td> 9.763167</td></tr>
	<tr><td>delaware            </td><td>12.690167</td></tr>
	<tr><td>district of columbia</td><td>12.712083</td></tr>
	<tr><td>florida             </td><td>21.344750</td></tr>
	<tr><td>georgia             </td><td>17.492667</td></tr>
	<tr><td>hawaii              </td><td>22.429250</td></tr>
	<tr><td>idaho               </td><td> 6.275917</td></tr>
	<tr><td>illinois            </td><td>11.423833</td></tr>
	<tr><td>indiana             </td><td>11.446667</td></tr>
	<tr><td>iowa                </td><td> 9.322500</td></tr>
	<tr><td>kansas              </td><td>12.764667</td></tr>
	<tr><td>kentucky            </td><td>13.414750</td></tr>
	<tr><td>louisiana           </td><td>19.020583</td></tr>
	<tr><td>maine               </td><td> 4.675333</td></tr>
	<tr><td>maryland            </td><td>12.896167</td></tr>
	<tr><td>massachusetts       </td><td> 8.245833</td></tr>
	<tr><td>michigan            </td><td> 7.180833</td></tr>
	<tr><td>minnesota           </td><td> 5.405583</td></tr>
	<tr><td>mississippi         </td><td>17.587417</td></tr>
	<tr><td>missouri            </td><td>12.810083</td></tr>
	<tr><td>montana             </td><td> 6.094750</td></tr>
	<tr><td>nebraska            </td><td>10.057500</td></tr>
	<tr><td>nevada              </td><td>10.332917</td></tr>
	<tr><td>new hampshire       </td><td> 6.001583</td></tr>
	<tr><td>new jersey          </td><td>11.463833</td></tr>
	<tr><td>new mexico          </td><td>12.172417</td></tr>
	<tr><td>new york            </td><td> 7.859583</td></tr>
	<tr><td>north carolina      </td><td>15.137750</td></tr>
	<tr><td>north dakota        </td><td> 5.195500</td></tr>
	<tr><td>ohio                </td><td>10.906667</td></tr>
	<tr><td>oklahoma            </td><td>15.558417</td></tr>
	<tr><td>oregon              </td><td> 8.671583</td></tr>
	<tr><td>pennsylvania        </td><td> 9.888417</td></tr>
	<tr><td>rhode island        </td><td> 9.702167</td></tr>
	<tr><td>south carolina      </td><td>17.147167</td></tr>
	<tr><td>south dakota        </td><td> 8.186000</td></tr>
	<tr><td>tennessee           </td><td>14.341667</td></tr>
	<tr><td>texas               </td><td>17.984167</td></tr>
	<tr><td>utah                </td><td> 9.206917</td></tr>
	<tr><td>vermont             </td><td> 5.781917</td></tr>
	<tr><td>virginia            </td><td>13.428917</td></tr>
	<tr><td>washington          </td><td> 8.185667</td></tr>
	<tr><td>west virginia       </td><td>11.528750</td></tr>
	<tr><td>wisconsin           </td><td> 6.624167</td></tr>
	<tr><td>wyoming             </td><td> 6.130667</td></tr>
</tbody>
</table>




```R
print(state_choropleth(clim_data1900,
                       title="Land Temperature 1900", 
                       num_colors = 8,
                       legend="Degrees"),reference_map=TRUE)
```


    
![png](output_10_0.png)
    



```R
clim_data3 %>%
filter(Year==2000) -> clim_data2000
clim_data2000<-clim_data2000[,2:3]
```


```R
print(state_choropleth(clim_data2000,
                       title="Land Temperature 2000", 
                       num_colors = 8,
                       legend="Degrees"),reference_map=TRUE)
```


    
![png](output_12_0.png)
    

Facet_wrap test. 

```R
ggplot(clim_data3, aes(x=Year, y=value, color=as.factor(region))) +
geom_point(size=3) +
facet_wrap(∼region) +
theme(legend.position="none")
```


    
![png](output_13_0.png)
    

Filtering by washington state. 

```R
clim_data3 %>%
    filter(region == "washington") -> wa_clim
wa_clim <- na.omit(wa_clim)
```


```R
wa_clim
```


<table class="dataframe">
<caption>A tibble: 183 × 3</caption>
<thead>
	<tr><th scope=col>Year</th><th scope=col>region</th><th scope=col>value</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1828</td><td>washington</td><td>7.235727</td></tr>
	<tr><td>1829</td><td>washington</td><td>6.834182</td></tr>
	<tr><td>1832</td><td>washington</td><td>2.855625</td></tr>
	<tr><td>1833</td><td>washington</td><td>7.645417</td></tr>
	<tr><td>1834</td><td>washington</td><td>7.274417</td></tr>
	<tr><td>1835</td><td>washington</td><td>5.542091</td></tr>
	<tr><td>1836</td><td>washington</td><td>6.849917</td></tr>
	<tr><td>1837</td><td>washington</td><td>6.934750</td></tr>
	<tr><td>1838</td><td>washington</td><td>6.698250</td></tr>
	<tr><td>1839</td><td>washington</td><td>7.464000</td></tr>
	<tr><td>1840</td><td>washington</td><td>6.829417</td></tr>
	<tr><td>1841</td><td>washington</td><td>6.951333</td></tr>
	<tr><td>1842</td><td>washington</td><td>7.058667</td></tr>
	<tr><td>1843</td><td>washington</td><td>6.660417</td></tr>
	<tr><td>1844</td><td>washington</td><td>6.531750</td></tr>
	<tr><td>1845</td><td>washington</td><td>7.046000</td></tr>
	<tr><td>1847</td><td>washington</td><td>9.620375</td></tr>
	<tr><td>1848</td><td>washington</td><td>6.723917</td></tr>
	<tr><td>1849</td><td>washington</td><td>6.813583</td></tr>
	<tr><td>1850</td><td>washington</td><td>7.209583</td></tr>
	<tr><td>1851</td><td>washington</td><td>7.920500</td></tr>
	<tr><td>1852</td><td>washington</td><td>7.207500</td></tr>
	<tr><td>1853</td><td>washington</td><td>7.736083</td></tr>
	<tr><td>1854</td><td>washington</td><td>7.169167</td></tr>
	<tr><td>1855</td><td>washington</td><td>7.436583</td></tr>
	<tr><td>1856</td><td>washington</td><td>7.574167</td></tr>
	<tr><td>1857</td><td>washington</td><td>8.054417</td></tr>
	<tr><td>1858</td><td>washington</td><td>7.068667</td></tr>
	<tr><td>1859</td><td>washington</td><td>6.380583</td></tr>
	<tr><td>1860</td><td>washington</td><td>7.778917</td></tr>
	<tr><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>1984</td><td>washington</td><td> 7.356750</td></tr>
	<tr><td>1985</td><td>washington</td><td> 6.574917</td></tr>
	<tr><td>1986</td><td>washington</td><td> 8.401333</td></tr>
	<tr><td>1987</td><td>washington</td><td> 8.887917</td></tr>
	<tr><td>1988</td><td>washington</td><td> 8.402917</td></tr>
	<tr><td>1989</td><td>washington</td><td> 7.971750</td></tr>
	<tr><td>1990</td><td>washington</td><td> 8.371167</td></tr>
	<tr><td>1991</td><td>washington</td><td> 8.302250</td></tr>
	<tr><td>1992</td><td>washington</td><td> 9.152750</td></tr>
	<tr><td>1993</td><td>washington</td><td> 7.423583</td></tr>
	<tr><td>1994</td><td>washington</td><td> 8.724583</td></tr>
	<tr><td>1995</td><td>washington</td><td> 8.561167</td></tr>
	<tr><td>1996</td><td>washington</td><td> 7.507667</td></tr>
	<tr><td>1997</td><td>washington</td><td> 8.368667</td></tr>
	<tr><td>1998</td><td>washington</td><td> 9.123000</td></tr>
	<tr><td>1999</td><td>washington</td><td> 8.242667</td></tr>
	<tr><td>2000</td><td>washington</td><td> 7.859917</td></tr>
	<tr><td>2001</td><td>washington</td><td> 8.284000</td></tr>
	<tr><td>2002</td><td>washington</td><td> 8.288750</td></tr>
	<tr><td>2003</td><td>washington</td><td> 9.032333</td></tr>
	<tr><td>2004</td><td>washington</td><td> 9.111833</td></tr>
	<tr><td>2005</td><td>washington</td><td> 8.531750</td></tr>
	<tr><td>2006</td><td>washington</td><td> 8.675333</td></tr>
	<tr><td>2007</td><td>washington</td><td> 8.302417</td></tr>
	<tr><td>2008</td><td>washington</td><td> 7.685917</td></tr>
	<tr><td>2009</td><td>washington</td><td> 8.047583</td></tr>
	<tr><td>2010</td><td>washington</td><td> 8.442167</td></tr>
	<tr><td>2011</td><td>washington</td><td> 7.619333</td></tr>
	<tr><td>2012</td><td>washington</td><td> 8.477917</td></tr>
	<tr><td>2013</td><td>washington</td><td>10.571778</td></tr>
</tbody>
</table>




```R
ggplot(wa_clim, aes(x=Year, y=value, color=as.factor(region))) +
geom_point(size=3) +
facet_wrap(∼region) +
theme(legend.position="none")
```


    
![png](output_16_0.png)
    

Filtering by oregon. 

```R
clim_data3 %>%
    filter(region == "oregon") -> or_clim
or_clim <- na.omit(or_clim)
```


```R
or_clim
```


<table class="dataframe">
<caption>A tibble: 183 × 3</caption>
<thead>
	<tr><th scope=col>Year</th><th scope=col>region</th><th scope=col>value</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1828</td><td>oregon</td><td> 7.843182</td></tr>
	<tr><td>1829</td><td>oregon</td><td> 7.360727</td></tr>
	<tr><td>1832</td><td>oregon</td><td> 3.466000</td></tr>
	<tr><td>1833</td><td>oregon</td><td> 8.095917</td></tr>
	<tr><td>1834</td><td>oregon</td><td> 7.843833</td></tr>
	<tr><td>1835</td><td>oregon</td><td> 6.067727</td></tr>
	<tr><td>1836</td><td>oregon</td><td> 7.335083</td></tr>
	<tr><td>1837</td><td>oregon</td><td> 7.383167</td></tr>
	<tr><td>1838</td><td>oregon</td><td> 7.199333</td></tr>
	<tr><td>1839</td><td>oregon</td><td> 7.826250</td></tr>
	<tr><td>1840</td><td>oregon</td><td> 7.357917</td></tr>
	<tr><td>1841</td><td>oregon</td><td> 7.430750</td></tr>
	<tr><td>1842</td><td>oregon</td><td> 7.583167</td></tr>
	<tr><td>1843</td><td>oregon</td><td> 7.337333</td></tr>
	<tr><td>1844</td><td>oregon</td><td> 7.123250</td></tr>
	<tr><td>1845</td><td>oregon</td><td> 7.591500</td></tr>
	<tr><td>1847</td><td>oregon</td><td>10.098625</td></tr>
	<tr><td>1848</td><td>oregon</td><td> 7.309333</td></tr>
	<tr><td>1849</td><td>oregon</td><td> 7.538333</td></tr>
	<tr><td>1850</td><td>oregon</td><td> 7.714333</td></tr>
	<tr><td>1851</td><td>oregon</td><td> 8.372000</td></tr>
	<tr><td>1852</td><td>oregon</td><td> 7.638750</td></tr>
	<tr><td>1853</td><td>oregon</td><td> 8.370250</td></tr>
	<tr><td>1854</td><td>oregon</td><td> 7.709500</td></tr>
	<tr><td>1855</td><td>oregon</td><td> 8.015667</td></tr>
	<tr><td>1856</td><td>oregon</td><td> 8.021750</td></tr>
	<tr><td>1857</td><td>oregon</td><td> 8.568167</td></tr>
	<tr><td>1858</td><td>oregon</td><td> 7.769583</td></tr>
	<tr><td>1859</td><td>oregon</td><td> 7.064750</td></tr>
	<tr><td>1860</td><td>oregon</td><td> 8.062000</td></tr>
	<tr><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>1984</td><td>oregon</td><td> 7.715833</td></tr>
	<tr><td>1985</td><td>oregon</td><td> 7.136250</td></tr>
	<tr><td>1986</td><td>oregon</td><td> 9.047667</td></tr>
	<tr><td>1987</td><td>oregon</td><td> 9.132833</td></tr>
	<tr><td>1988</td><td>oregon</td><td> 8.908750</td></tr>
	<tr><td>1989</td><td>oregon</td><td> 8.187167</td></tr>
	<tr><td>1990</td><td>oregon</td><td> 8.605333</td></tr>
	<tr><td>1991</td><td>oregon</td><td> 8.716000</td></tr>
	<tr><td>1992</td><td>oregon</td><td> 9.712500</td></tr>
	<tr><td>1993</td><td>oregon</td><td> 7.580667</td></tr>
	<tr><td>1994</td><td>oregon</td><td> 8.877417</td></tr>
	<tr><td>1995</td><td>oregon</td><td> 9.010500</td></tr>
	<tr><td>1996</td><td>oregon</td><td> 8.723000</td></tr>
	<tr><td>1997</td><td>oregon</td><td> 8.838833</td></tr>
	<tr><td>1998</td><td>oregon</td><td> 8.897083</td></tr>
	<tr><td>1999</td><td>oregon</td><td> 8.541000</td></tr>
	<tr><td>2000</td><td>oregon</td><td> 8.678000</td></tr>
	<tr><td>2001</td><td>oregon</td><td> 8.882667</td></tr>
	<tr><td>2002</td><td>oregon</td><td> 8.806167</td></tr>
	<tr><td>2003</td><td>oregon</td><td> 9.564250</td></tr>
	<tr><td>2004</td><td>oregon</td><td> 9.285167</td></tr>
	<tr><td>2005</td><td>oregon</td><td> 8.840000</td></tr>
	<tr><td>2006</td><td>oregon</td><td> 8.960333</td></tr>
	<tr><td>2007</td><td>oregon</td><td> 8.895833</td></tr>
	<tr><td>2008</td><td>oregon</td><td> 8.315167</td></tr>
	<tr><td>2009</td><td>oregon</td><td> 8.559083</td></tr>
	<tr><td>2010</td><td>oregon</td><td> 8.574583</td></tr>
	<tr><td>2011</td><td>oregon</td><td> 8.077583</td></tr>
	<tr><td>2012</td><td>oregon</td><td> 9.030083</td></tr>
	<tr><td>2013</td><td>oregon</td><td>10.763556</td></tr>
</tbody>
</table>




```R
ggplot(or_clim, aes(x=Year, y=value, color=as.factor(region))) +
geom_point(size=3) +
facet_wrap(∼region) +
theme(legend.position="none")
```


    
![png](output_19_0.png)
    

Let's merge them for analysis. 

```R
com_clim <- merge(wa_clim, or_clim, by = 'Year')
```


```R
com_clim
```


<table class="dataframe">
<caption>A data.frame: 183 × 5</caption>
<thead>
	<tr><th scope=col>Year</th><th scope=col>region.x</th><th scope=col>value.x</th><th scope=col>region.y</th><th scope=col>value.y</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1828</td><td>washington</td><td>7.235727</td><td>oregon</td><td> 7.843182</td></tr>
	<tr><td>1829</td><td>washington</td><td>6.834182</td><td>oregon</td><td> 7.360727</td></tr>
	<tr><td>1832</td><td>washington</td><td>2.855625</td><td>oregon</td><td> 3.466000</td></tr>
	<tr><td>1833</td><td>washington</td><td>7.645417</td><td>oregon</td><td> 8.095917</td></tr>
	<tr><td>1834</td><td>washington</td><td>7.274417</td><td>oregon</td><td> 7.843833</td></tr>
	<tr><td>1835</td><td>washington</td><td>5.542091</td><td>oregon</td><td> 6.067727</td></tr>
	<tr><td>1836</td><td>washington</td><td>6.849917</td><td>oregon</td><td> 7.335083</td></tr>
	<tr><td>1837</td><td>washington</td><td>6.934750</td><td>oregon</td><td> 7.383167</td></tr>
	<tr><td>1838</td><td>washington</td><td>6.698250</td><td>oregon</td><td> 7.199333</td></tr>
	<tr><td>1839</td><td>washington</td><td>7.464000</td><td>oregon</td><td> 7.826250</td></tr>
	<tr><td>1840</td><td>washington</td><td>6.829417</td><td>oregon</td><td> 7.357917</td></tr>
	<tr><td>1841</td><td>washington</td><td>6.951333</td><td>oregon</td><td> 7.430750</td></tr>
	<tr><td>1842</td><td>washington</td><td>7.058667</td><td>oregon</td><td> 7.583167</td></tr>
	<tr><td>1843</td><td>washington</td><td>6.660417</td><td>oregon</td><td> 7.337333</td></tr>
	<tr><td>1844</td><td>washington</td><td>6.531750</td><td>oregon</td><td> 7.123250</td></tr>
	<tr><td>1845</td><td>washington</td><td>7.046000</td><td>oregon</td><td> 7.591500</td></tr>
	<tr><td>1847</td><td>washington</td><td>9.620375</td><td>oregon</td><td>10.098625</td></tr>
	<tr><td>1848</td><td>washington</td><td>6.723917</td><td>oregon</td><td> 7.309333</td></tr>
	<tr><td>1849</td><td>washington</td><td>6.813583</td><td>oregon</td><td> 7.538333</td></tr>
	<tr><td>1850</td><td>washington</td><td>7.209583</td><td>oregon</td><td> 7.714333</td></tr>
	<tr><td>1851</td><td>washington</td><td>7.920500</td><td>oregon</td><td> 8.372000</td></tr>
	<tr><td>1852</td><td>washington</td><td>7.207500</td><td>oregon</td><td> 7.638750</td></tr>
	<tr><td>1853</td><td>washington</td><td>7.736083</td><td>oregon</td><td> 8.370250</td></tr>
	<tr><td>1854</td><td>washington</td><td>7.169167</td><td>oregon</td><td> 7.709500</td></tr>
	<tr><td>1855</td><td>washington</td><td>7.436583</td><td>oregon</td><td> 8.015667</td></tr>
	<tr><td>1856</td><td>washington</td><td>7.574167</td><td>oregon</td><td> 8.021750</td></tr>
	<tr><td>1857</td><td>washington</td><td>8.054417</td><td>oregon</td><td> 8.568167</td></tr>
	<tr><td>1858</td><td>washington</td><td>7.068667</td><td>oregon</td><td> 7.769583</td></tr>
	<tr><td>1859</td><td>washington</td><td>6.380583</td><td>oregon</td><td> 7.064750</td></tr>
	<tr><td>1860</td><td>washington</td><td>7.778917</td><td>oregon</td><td> 8.062000</td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>1984</td><td>washington</td><td> 7.356750</td><td>oregon</td><td> 7.715833</td></tr>
	<tr><td>1985</td><td>washington</td><td> 6.574917</td><td>oregon</td><td> 7.136250</td></tr>
	<tr><td>1986</td><td>washington</td><td> 8.401333</td><td>oregon</td><td> 9.047667</td></tr>
	<tr><td>1987</td><td>washington</td><td> 8.887917</td><td>oregon</td><td> 9.132833</td></tr>
	<tr><td>1988</td><td>washington</td><td> 8.402917</td><td>oregon</td><td> 8.908750</td></tr>
	<tr><td>1989</td><td>washington</td><td> 7.971750</td><td>oregon</td><td> 8.187167</td></tr>
	<tr><td>1990</td><td>washington</td><td> 8.371167</td><td>oregon</td><td> 8.605333</td></tr>
	<tr><td>1991</td><td>washington</td><td> 8.302250</td><td>oregon</td><td> 8.716000</td></tr>
	<tr><td>1992</td><td>washington</td><td> 9.152750</td><td>oregon</td><td> 9.712500</td></tr>
	<tr><td>1993</td><td>washington</td><td> 7.423583</td><td>oregon</td><td> 7.580667</td></tr>
	<tr><td>1994</td><td>washington</td><td> 8.724583</td><td>oregon</td><td> 8.877417</td></tr>
	<tr><td>1995</td><td>washington</td><td> 8.561167</td><td>oregon</td><td> 9.010500</td></tr>
	<tr><td>1996</td><td>washington</td><td> 7.507667</td><td>oregon</td><td> 8.723000</td></tr>
	<tr><td>1997</td><td>washington</td><td> 8.368667</td><td>oregon</td><td> 8.838833</td></tr>
	<tr><td>1998</td><td>washington</td><td> 9.123000</td><td>oregon</td><td> 8.897083</td></tr>
	<tr><td>1999</td><td>washington</td><td> 8.242667</td><td>oregon</td><td> 8.541000</td></tr>
	<tr><td>2000</td><td>washington</td><td> 7.859917</td><td>oregon</td><td> 8.678000</td></tr>
	<tr><td>2001</td><td>washington</td><td> 8.284000</td><td>oregon</td><td> 8.882667</td></tr>
	<tr><td>2002</td><td>washington</td><td> 8.288750</td><td>oregon</td><td> 8.806167</td></tr>
	<tr><td>2003</td><td>washington</td><td> 9.032333</td><td>oregon</td><td> 9.564250</td></tr>
	<tr><td>2004</td><td>washington</td><td> 9.111833</td><td>oregon</td><td> 9.285167</td></tr>
	<tr><td>2005</td><td>washington</td><td> 8.531750</td><td>oregon</td><td> 8.840000</td></tr>
	<tr><td>2006</td><td>washington</td><td> 8.675333</td><td>oregon</td><td> 8.960333</td></tr>
	<tr><td>2007</td><td>washington</td><td> 8.302417</td><td>oregon</td><td> 8.895833</td></tr>
	<tr><td>2008</td><td>washington</td><td> 7.685917</td><td>oregon</td><td> 8.315167</td></tr>
	<tr><td>2009</td><td>washington</td><td> 8.047583</td><td>oregon</td><td> 8.559083</td></tr>
	<tr><td>2010</td><td>washington</td><td> 8.442167</td><td>oregon</td><td> 8.574583</td></tr>
	<tr><td>2011</td><td>washington</td><td> 7.619333</td><td>oregon</td><td> 8.077583</td></tr>
	<tr><td>2012</td><td>washington</td><td> 8.477917</td><td>oregon</td><td> 9.030083</td></tr>
	<tr><td>2013</td><td>washington</td><td>10.571778</td><td>oregon</td><td>10.763556</td></tr>
</tbody>
</table>


Finding the difference of temperatures between WA and OR

```R
wa_temp = wa_clim$value
```


```R
or_temp = or_clim$value
```


```R
dif_temp <- or_temp - wa_temp
```


```R
dif_temp
```


<style>
.list-inline {list-style: none; margin:0; padding: 0}
.list-inline>li {display: inline-block}
.list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
</style>
<ol class=list-inline><li>0.607454545454545</li><li>0.526545454545455</li><li>0.610374999999999</li><li>0.450500000000001</li><li>0.569416666666667</li><li>0.525636363636364</li><li>0.485166666666666</li><li>0.448416666666667</li><li>0.501083333333334</li><li>0.36225</li><li>0.5285</li><li>0.479416666666667</li><li>0.524500000000001</li><li>0.676916666666667</li><li>0.591500000000001</li><li>0.5455</li><li>0.478249999999999</li><li>0.585416666666666</li><li>0.72475</li><li>0.50475</li><li>0.4515</li><li>0.431249999999999</li><li>0.634166666666667</li><li>0.540333333333334</li><li>0.579083333333332</li><li>0.447583333333332</li><li>0.51375</li><li>0.700916666666667</li><li>0.684166666666667</li><li>0.283083333333335</li><li>0.821249999999999</li><li>0.831</li><li>0.707</li><li>0.791333333333333</li><li>0.711583333333333</li><li>0.830833333333334</li><li>0.740333333333334</li><li>0.554416666666667</li><li>0.504249999999999</li><li>0.533416666666668</li><li>0.440583333333333</li><li>0.740166666666666</li><li>0.589083333333334</li><li>0.48025</li><li>1.31275</li><li>0.859333333333333</li><li>0.460833333333333</li><li>0.229166666666668</li><li>0.735</li><li>0.646166666666668</li><li>0.884250000000001</li><li>0.396999999999999</li><li>0.584666666666666</li><li>0.642166666666666</li><li>0.654083333333332</li><li>0.602666666666666</li><li>0.971499999999999</li><li>0.755916666666667</li><li>0.804916666666665</li><li>0.49925</li><li>0.366000000000001</li><li>0.264500000000001</li><li>0.585500000000001</li><li>0.602083333333334</li><li>0.252916666666667</li><li>0.715833333333334</li><li>0.553749999999999</li><li>0.224333333333334</li><li>0.384916666666667</li><li>0.485916666666668</li><li>0.609083333333333</li><li>0.507499999999999</li><li>0.585583333333333</li><li>0.580250000000001</li><li>0.403666666666668</li><li>0.308416666666668</li><li>0.864833333333333</li><li>0.411</li><li>0.921833333333334</li><li>0.7055</li><li>0.407083333333334</li><li>0.23775</li><li>0.641083333333333</li><li>0.461083333333334</li><li>0.299166666666666</li><li>0.802</li><li>0.498333333333333</li><li>0.336499999999999</li><li>0.608166666666667</li><li>0.3065</li><li>0.797416666666667</li><li>0.566166666666667</li><li>0.16875</li><li>0.350499999999999</li><li>0.262583333333334</li><li>0.489166666666668</li><li>0.599666666666667</li><li>0.361916666666667</li><li>0.685083333333333</li><li>0.435916666666667</li><li>0.446083333333334</li><li>0.353166666666667</li><li>0.58975</li><li>0.71475</li><li>0.404333333333334</li><li>0.723916666666667</li><li>0.654249999999999</li><li>0.17625</li><li>0.483916666666666</li><li>0.402833333333334</li><li>0.0515833333333333</li><li>0.216416666666667</li><li>0.730416666666668</li><li>-0.0490833333333329</li><li>0.439</li><li>0.429083333333335</li><li>0.468333333333332</li><li>0.503916666666667</li><li>0.641166666666667</li><li>1.27675</li><li>0.742833333333333</li><li>0.268333333333333</li><li>0.196916666666667</li><li>0.800583333333335</li><li>0.86025</li><li>0.586583333333333</li><li>0.456333333333333</li><li>0.239583333333334</li><li>0.882166666666667</li><li>0.641249999999999</li><li>0.496083333333333</li><li>0.365166666666667</li><li>0.4125</li><li>0.534</li><li>0.346500000000001</li><li>0.531166666666666</li><li>0.20125</li><li>0.659</li><li>0.676500000000001</li><li>0.603</li><li>0.436083333333332</li><li>0.759416666666667</li><li>0.641583333333333</li><li>0.393750000000001</li><li>0.531000000000001</li><li>0.522416666666667</li><li>0.656333333333333</li><li>0.578750000000001</li><li>0.550666666666667</li><li>0.729833333333334</li><li>0.563083333333333</li><li>0.208916666666666</li><li>0.352333333333334</li><li>0.359083333333333</li><li>0.561333333333334</li><li>0.646333333333333</li><li>0.244916666666668</li><li>0.505833333333333</li><li>0.215416666666666</li><li>0.234166666666665</li><li>0.413749999999999</li><li>0.559750000000001</li><li>0.157083333333333</li><li>0.152833333333334</li><li>0.449333333333334</li><li>1.21533333333333</li><li>0.470166666666668</li><li>-0.225916666666667</li><li>0.298333333333334</li><li>0.818083333333332</li><li>0.598666666666666</li><li>0.517416666666666</li><li>0.531916666666666</li><li>0.173333333333334</li><li>0.308250000000001</li><li>0.285</li><li>0.593416666666668</li><li>0.629249999999999</li><li>0.5115</li><li>0.132416666666666</li><li>0.45825</li><li>0.552166666666666</li><li>0.191777777777778</li></ol>




```R
com_clim$TempDiff <- dif_temp
```


```R
com_clim
```


<table class="dataframe">
<caption>A data.frame: 183 × 6</caption>
<thead>
	<tr><th scope=col>Year</th><th scope=col>region.x</th><th scope=col>value.x</th><th scope=col>region.y</th><th scope=col>value.y</th><th scope=col>TempDiff</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1828</td><td>washington</td><td>7.235727</td><td>oregon</td><td> 7.843182</td><td>0.6074545</td></tr>
	<tr><td>1829</td><td>washington</td><td>6.834182</td><td>oregon</td><td> 7.360727</td><td>0.5265455</td></tr>
	<tr><td>1832</td><td>washington</td><td>2.855625</td><td>oregon</td><td> 3.466000</td><td>0.6103750</td></tr>
	<tr><td>1833</td><td>washington</td><td>7.645417</td><td>oregon</td><td> 8.095917</td><td>0.4505000</td></tr>
	<tr><td>1834</td><td>washington</td><td>7.274417</td><td>oregon</td><td> 7.843833</td><td>0.5694167</td></tr>
	<tr><td>1835</td><td>washington</td><td>5.542091</td><td>oregon</td><td> 6.067727</td><td>0.5256364</td></tr>
	<tr><td>1836</td><td>washington</td><td>6.849917</td><td>oregon</td><td> 7.335083</td><td>0.4851667</td></tr>
	<tr><td>1837</td><td>washington</td><td>6.934750</td><td>oregon</td><td> 7.383167</td><td>0.4484167</td></tr>
	<tr><td>1838</td><td>washington</td><td>6.698250</td><td>oregon</td><td> 7.199333</td><td>0.5010833</td></tr>
	<tr><td>1839</td><td>washington</td><td>7.464000</td><td>oregon</td><td> 7.826250</td><td>0.3622500</td></tr>
	<tr><td>1840</td><td>washington</td><td>6.829417</td><td>oregon</td><td> 7.357917</td><td>0.5285000</td></tr>
	<tr><td>1841</td><td>washington</td><td>6.951333</td><td>oregon</td><td> 7.430750</td><td>0.4794167</td></tr>
	<tr><td>1842</td><td>washington</td><td>7.058667</td><td>oregon</td><td> 7.583167</td><td>0.5245000</td></tr>
	<tr><td>1843</td><td>washington</td><td>6.660417</td><td>oregon</td><td> 7.337333</td><td>0.6769167</td></tr>
	<tr><td>1844</td><td>washington</td><td>6.531750</td><td>oregon</td><td> 7.123250</td><td>0.5915000</td></tr>
	<tr><td>1845</td><td>washington</td><td>7.046000</td><td>oregon</td><td> 7.591500</td><td>0.5455000</td></tr>
	<tr><td>1847</td><td>washington</td><td>9.620375</td><td>oregon</td><td>10.098625</td><td>0.4782500</td></tr>
	<tr><td>1848</td><td>washington</td><td>6.723917</td><td>oregon</td><td> 7.309333</td><td>0.5854167</td></tr>
	<tr><td>1849</td><td>washington</td><td>6.813583</td><td>oregon</td><td> 7.538333</td><td>0.7247500</td></tr>
	<tr><td>1850</td><td>washington</td><td>7.209583</td><td>oregon</td><td> 7.714333</td><td>0.5047500</td></tr>
	<tr><td>1851</td><td>washington</td><td>7.920500</td><td>oregon</td><td> 8.372000</td><td>0.4515000</td></tr>
	<tr><td>1852</td><td>washington</td><td>7.207500</td><td>oregon</td><td> 7.638750</td><td>0.4312500</td></tr>
	<tr><td>1853</td><td>washington</td><td>7.736083</td><td>oregon</td><td> 8.370250</td><td>0.6341667</td></tr>
	<tr><td>1854</td><td>washington</td><td>7.169167</td><td>oregon</td><td> 7.709500</td><td>0.5403333</td></tr>
	<tr><td>1855</td><td>washington</td><td>7.436583</td><td>oregon</td><td> 8.015667</td><td>0.5790833</td></tr>
	<tr><td>1856</td><td>washington</td><td>7.574167</td><td>oregon</td><td> 8.021750</td><td>0.4475833</td></tr>
	<tr><td>1857</td><td>washington</td><td>8.054417</td><td>oregon</td><td> 8.568167</td><td>0.5137500</td></tr>
	<tr><td>1858</td><td>washington</td><td>7.068667</td><td>oregon</td><td> 7.769583</td><td>0.7009167</td></tr>
	<tr><td>1859</td><td>washington</td><td>6.380583</td><td>oregon</td><td> 7.064750</td><td>0.6841667</td></tr>
	<tr><td>1860</td><td>washington</td><td>7.778917</td><td>oregon</td><td> 8.062000</td><td>0.2830833</td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>1984</td><td>washington</td><td> 7.356750</td><td>oregon</td><td> 7.715833</td><td> 0.3590833</td></tr>
	<tr><td>1985</td><td>washington</td><td> 6.574917</td><td>oregon</td><td> 7.136250</td><td> 0.5613333</td></tr>
	<tr><td>1986</td><td>washington</td><td> 8.401333</td><td>oregon</td><td> 9.047667</td><td> 0.6463333</td></tr>
	<tr><td>1987</td><td>washington</td><td> 8.887917</td><td>oregon</td><td> 9.132833</td><td> 0.2449167</td></tr>
	<tr><td>1988</td><td>washington</td><td> 8.402917</td><td>oregon</td><td> 8.908750</td><td> 0.5058333</td></tr>
	<tr><td>1989</td><td>washington</td><td> 7.971750</td><td>oregon</td><td> 8.187167</td><td> 0.2154167</td></tr>
	<tr><td>1990</td><td>washington</td><td> 8.371167</td><td>oregon</td><td> 8.605333</td><td> 0.2341667</td></tr>
	<tr><td>1991</td><td>washington</td><td> 8.302250</td><td>oregon</td><td> 8.716000</td><td> 0.4137500</td></tr>
	<tr><td>1992</td><td>washington</td><td> 9.152750</td><td>oregon</td><td> 9.712500</td><td> 0.5597500</td></tr>
	<tr><td>1993</td><td>washington</td><td> 7.423583</td><td>oregon</td><td> 7.580667</td><td> 0.1570833</td></tr>
	<tr><td>1994</td><td>washington</td><td> 8.724583</td><td>oregon</td><td> 8.877417</td><td> 0.1528333</td></tr>
	<tr><td>1995</td><td>washington</td><td> 8.561167</td><td>oregon</td><td> 9.010500</td><td> 0.4493333</td></tr>
	<tr><td>1996</td><td>washington</td><td> 7.507667</td><td>oregon</td><td> 8.723000</td><td> 1.2153333</td></tr>
	<tr><td>1997</td><td>washington</td><td> 8.368667</td><td>oregon</td><td> 8.838833</td><td> 0.4701667</td></tr>
	<tr><td>1998</td><td>washington</td><td> 9.123000</td><td>oregon</td><td> 8.897083</td><td>-0.2259167</td></tr>
	<tr><td>1999</td><td>washington</td><td> 8.242667</td><td>oregon</td><td> 8.541000</td><td> 0.2983333</td></tr>
	<tr><td>2000</td><td>washington</td><td> 7.859917</td><td>oregon</td><td> 8.678000</td><td> 0.8180833</td></tr>
	<tr><td>2001</td><td>washington</td><td> 8.284000</td><td>oregon</td><td> 8.882667</td><td> 0.5986667</td></tr>
	<tr><td>2002</td><td>washington</td><td> 8.288750</td><td>oregon</td><td> 8.806167</td><td> 0.5174167</td></tr>
	<tr><td>2003</td><td>washington</td><td> 9.032333</td><td>oregon</td><td> 9.564250</td><td> 0.5319167</td></tr>
	<tr><td>2004</td><td>washington</td><td> 9.111833</td><td>oregon</td><td> 9.285167</td><td> 0.1733333</td></tr>
	<tr><td>2005</td><td>washington</td><td> 8.531750</td><td>oregon</td><td> 8.840000</td><td> 0.3082500</td></tr>
	<tr><td>2006</td><td>washington</td><td> 8.675333</td><td>oregon</td><td> 8.960333</td><td> 0.2850000</td></tr>
	<tr><td>2007</td><td>washington</td><td> 8.302417</td><td>oregon</td><td> 8.895833</td><td> 0.5934167</td></tr>
	<tr><td>2008</td><td>washington</td><td> 7.685917</td><td>oregon</td><td> 8.315167</td><td> 0.6292500</td></tr>
	<tr><td>2009</td><td>washington</td><td> 8.047583</td><td>oregon</td><td> 8.559083</td><td> 0.5115000</td></tr>
	<tr><td>2010</td><td>washington</td><td> 8.442167</td><td>oregon</td><td> 8.574583</td><td> 0.1324167</td></tr>
	<tr><td>2011</td><td>washington</td><td> 7.619333</td><td>oregon</td><td> 8.077583</td><td> 0.4582500</td></tr>
	<tr><td>2012</td><td>washington</td><td> 8.477917</td><td>oregon</td><td> 9.030083</td><td> 0.5521667</td></tr>
	<tr><td>2013</td><td>washington</td><td>10.571778</td><td>oregon</td><td>10.763556</td><td> 0.1917778</td></tr>
</tbody>
</table>


Graph it. 

```R
ggplot(com_clim, aes(x=Year, y=TempDiff, color = "red", group = 1)) +
stat_boxplot()
```


    
![png](output_28_0.png)
    



```R
ggplot(com_clim, aes(x=Year, y=TempDiff)) +
geom_bin_2d()
```


    
![png](output_29_0.png)
    



```R
com_clim %>%
rename(WA = region.x ,
       WA_temperature = value.x,
      OR = region.y ,
      OR_temperature = value.y,
      ) -> com_clim
```


```R
com_clim
```


<table class="dataframe">
<caption>A data.frame: 183 × 6</caption>
<thead>
	<tr><th scope=col>Year</th><th scope=col>WA</th><th scope=col>WA_temperature</th><th scope=col>OR</th><th scope=col>OR_temperature</th><th scope=col>TempDiff</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1828</td><td>washington</td><td>7.235727</td><td>oregon</td><td> 7.843182</td><td>0.6074545</td></tr>
	<tr><td>1829</td><td>washington</td><td>6.834182</td><td>oregon</td><td> 7.360727</td><td>0.5265455</td></tr>
	<tr><td>1832</td><td>washington</td><td>2.855625</td><td>oregon</td><td> 3.466000</td><td>0.6103750</td></tr>
	<tr><td>1833</td><td>washington</td><td>7.645417</td><td>oregon</td><td> 8.095917</td><td>0.4505000</td></tr>
	<tr><td>1834</td><td>washington</td><td>7.274417</td><td>oregon</td><td> 7.843833</td><td>0.5694167</td></tr>
	<tr><td>1835</td><td>washington</td><td>5.542091</td><td>oregon</td><td> 6.067727</td><td>0.5256364</td></tr>
	<tr><td>1836</td><td>washington</td><td>6.849917</td><td>oregon</td><td> 7.335083</td><td>0.4851667</td></tr>
	<tr><td>1837</td><td>washington</td><td>6.934750</td><td>oregon</td><td> 7.383167</td><td>0.4484167</td></tr>
	<tr><td>1838</td><td>washington</td><td>6.698250</td><td>oregon</td><td> 7.199333</td><td>0.5010833</td></tr>
	<tr><td>1839</td><td>washington</td><td>7.464000</td><td>oregon</td><td> 7.826250</td><td>0.3622500</td></tr>
	<tr><td>1840</td><td>washington</td><td>6.829417</td><td>oregon</td><td> 7.357917</td><td>0.5285000</td></tr>
	<tr><td>1841</td><td>washington</td><td>6.951333</td><td>oregon</td><td> 7.430750</td><td>0.4794167</td></tr>
	<tr><td>1842</td><td>washington</td><td>7.058667</td><td>oregon</td><td> 7.583167</td><td>0.5245000</td></tr>
	<tr><td>1843</td><td>washington</td><td>6.660417</td><td>oregon</td><td> 7.337333</td><td>0.6769167</td></tr>
	<tr><td>1844</td><td>washington</td><td>6.531750</td><td>oregon</td><td> 7.123250</td><td>0.5915000</td></tr>
	<tr><td>1845</td><td>washington</td><td>7.046000</td><td>oregon</td><td> 7.591500</td><td>0.5455000</td></tr>
	<tr><td>1847</td><td>washington</td><td>9.620375</td><td>oregon</td><td>10.098625</td><td>0.4782500</td></tr>
	<tr><td>1848</td><td>washington</td><td>6.723917</td><td>oregon</td><td> 7.309333</td><td>0.5854167</td></tr>
	<tr><td>1849</td><td>washington</td><td>6.813583</td><td>oregon</td><td> 7.538333</td><td>0.7247500</td></tr>
	<tr><td>1850</td><td>washington</td><td>7.209583</td><td>oregon</td><td> 7.714333</td><td>0.5047500</td></tr>
	<tr><td>1851</td><td>washington</td><td>7.920500</td><td>oregon</td><td> 8.372000</td><td>0.4515000</td></tr>
	<tr><td>1852</td><td>washington</td><td>7.207500</td><td>oregon</td><td> 7.638750</td><td>0.4312500</td></tr>
	<tr><td>1853</td><td>washington</td><td>7.736083</td><td>oregon</td><td> 8.370250</td><td>0.6341667</td></tr>
	<tr><td>1854</td><td>washington</td><td>7.169167</td><td>oregon</td><td> 7.709500</td><td>0.5403333</td></tr>
	<tr><td>1855</td><td>washington</td><td>7.436583</td><td>oregon</td><td> 8.015667</td><td>0.5790833</td></tr>
	<tr><td>1856</td><td>washington</td><td>7.574167</td><td>oregon</td><td> 8.021750</td><td>0.4475833</td></tr>
	<tr><td>1857</td><td>washington</td><td>8.054417</td><td>oregon</td><td> 8.568167</td><td>0.5137500</td></tr>
	<tr><td>1858</td><td>washington</td><td>7.068667</td><td>oregon</td><td> 7.769583</td><td>0.7009167</td></tr>
	<tr><td>1859</td><td>washington</td><td>6.380583</td><td>oregon</td><td> 7.064750</td><td>0.6841667</td></tr>
	<tr><td>1860</td><td>washington</td><td>7.778917</td><td>oregon</td><td> 8.062000</td><td>0.2830833</td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>1984</td><td>washington</td><td> 7.356750</td><td>oregon</td><td> 7.715833</td><td> 0.3590833</td></tr>
	<tr><td>1985</td><td>washington</td><td> 6.574917</td><td>oregon</td><td> 7.136250</td><td> 0.5613333</td></tr>
	<tr><td>1986</td><td>washington</td><td> 8.401333</td><td>oregon</td><td> 9.047667</td><td> 0.6463333</td></tr>
	<tr><td>1987</td><td>washington</td><td> 8.887917</td><td>oregon</td><td> 9.132833</td><td> 0.2449167</td></tr>
	<tr><td>1988</td><td>washington</td><td> 8.402917</td><td>oregon</td><td> 8.908750</td><td> 0.5058333</td></tr>
	<tr><td>1989</td><td>washington</td><td> 7.971750</td><td>oregon</td><td> 8.187167</td><td> 0.2154167</td></tr>
	<tr><td>1990</td><td>washington</td><td> 8.371167</td><td>oregon</td><td> 8.605333</td><td> 0.2341667</td></tr>
	<tr><td>1991</td><td>washington</td><td> 8.302250</td><td>oregon</td><td> 8.716000</td><td> 0.4137500</td></tr>
	<tr><td>1992</td><td>washington</td><td> 9.152750</td><td>oregon</td><td> 9.712500</td><td> 0.5597500</td></tr>
	<tr><td>1993</td><td>washington</td><td> 7.423583</td><td>oregon</td><td> 7.580667</td><td> 0.1570833</td></tr>
	<tr><td>1994</td><td>washington</td><td> 8.724583</td><td>oregon</td><td> 8.877417</td><td> 0.1528333</td></tr>
	<tr><td>1995</td><td>washington</td><td> 8.561167</td><td>oregon</td><td> 9.010500</td><td> 0.4493333</td></tr>
	<tr><td>1996</td><td>washington</td><td> 7.507667</td><td>oregon</td><td> 8.723000</td><td> 1.2153333</td></tr>
	<tr><td>1997</td><td>washington</td><td> 8.368667</td><td>oregon</td><td> 8.838833</td><td> 0.4701667</td></tr>
	<tr><td>1998</td><td>washington</td><td> 9.123000</td><td>oregon</td><td> 8.897083</td><td>-0.2259167</td></tr>
	<tr><td>1999</td><td>washington</td><td> 8.242667</td><td>oregon</td><td> 8.541000</td><td> 0.2983333</td></tr>
	<tr><td>2000</td><td>washington</td><td> 7.859917</td><td>oregon</td><td> 8.678000</td><td> 0.8180833</td></tr>
	<tr><td>2001</td><td>washington</td><td> 8.284000</td><td>oregon</td><td> 8.882667</td><td> 0.5986667</td></tr>
	<tr><td>2002</td><td>washington</td><td> 8.288750</td><td>oregon</td><td> 8.806167</td><td> 0.5174167</td></tr>
	<tr><td>2003</td><td>washington</td><td> 9.032333</td><td>oregon</td><td> 9.564250</td><td> 0.5319167</td></tr>
	<tr><td>2004</td><td>washington</td><td> 9.111833</td><td>oregon</td><td> 9.285167</td><td> 0.1733333</td></tr>
	<tr><td>2005</td><td>washington</td><td> 8.531750</td><td>oregon</td><td> 8.840000</td><td> 0.3082500</td></tr>
	<tr><td>2006</td><td>washington</td><td> 8.675333</td><td>oregon</td><td> 8.960333</td><td> 0.2850000</td></tr>
	<tr><td>2007</td><td>washington</td><td> 8.302417</td><td>oregon</td><td> 8.895833</td><td> 0.5934167</td></tr>
	<tr><td>2008</td><td>washington</td><td> 7.685917</td><td>oregon</td><td> 8.315167</td><td> 0.6292500</td></tr>
	<tr><td>2009</td><td>washington</td><td> 8.047583</td><td>oregon</td><td> 8.559083</td><td> 0.5115000</td></tr>
	<tr><td>2010</td><td>washington</td><td> 8.442167</td><td>oregon</td><td> 8.574583</td><td> 0.1324167</td></tr>
	<tr><td>2011</td><td>washington</td><td> 7.619333</td><td>oregon</td><td> 8.077583</td><td> 0.4582500</td></tr>
	<tr><td>2012</td><td>washington</td><td> 8.477917</td><td>oregon</td><td> 9.030083</td><td> 0.5521667</td></tr>
	<tr><td>2013</td><td>washington</td><td>10.571778</td><td>oregon</td><td>10.763556</td><td> 0.1917778</td></tr>
</tbody>
</table>




```R
com_clim1 <- subset(com_clim, select = -TempDiff)
```


```R
com_clim1
```


<table class="dataframe">
<caption>A data.frame: 183 × 5</caption>
<thead>
	<tr><th></th><th scope=col>Year</th><th scope=col>WA</th><th scope=col>WA_temperature</th><th scope=col>OR</th><th scope=col>OR_temperature</th></tr>
	<tr><th></th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><th scope=row>1</th><td>1828</td><td>washington</td><td>7.235727</td><td>oregon</td><td> 7.843182</td></tr>
	<tr><th scope=row>2</th><td>1829</td><td>washington</td><td>6.834182</td><td>oregon</td><td> 7.360727</td></tr>
	<tr><th scope=row>3</th><td>1832</td><td>washington</td><td>2.855625</td><td>oregon</td><td> 3.466000</td></tr>
	<tr><th scope=row>4</th><td>1833</td><td>washington</td><td>7.645417</td><td>oregon</td><td> 8.095917</td></tr>
	<tr><th scope=row>5</th><td>1834</td><td>washington</td><td>7.274417</td><td>oregon</td><td> 7.843833</td></tr>
	<tr><th scope=row>6</th><td>1835</td><td>washington</td><td>5.542091</td><td>oregon</td><td> 6.067727</td></tr>
	<tr><th scope=row>7</th><td>1836</td><td>washington</td><td>6.849917</td><td>oregon</td><td> 7.335083</td></tr>
	<tr><th scope=row>8</th><td>1837</td><td>washington</td><td>6.934750</td><td>oregon</td><td> 7.383167</td></tr>
	<tr><th scope=row>9</th><td>1838</td><td>washington</td><td>6.698250</td><td>oregon</td><td> 7.199333</td></tr>
	<tr><th scope=row>10</th><td>1839</td><td>washington</td><td>7.464000</td><td>oregon</td><td> 7.826250</td></tr>
	<tr><th scope=row>11</th><td>1840</td><td>washington</td><td>6.829417</td><td>oregon</td><td> 7.357917</td></tr>
	<tr><th scope=row>12</th><td>1841</td><td>washington</td><td>6.951333</td><td>oregon</td><td> 7.430750</td></tr>
	<tr><th scope=row>13</th><td>1842</td><td>washington</td><td>7.058667</td><td>oregon</td><td> 7.583167</td></tr>
	<tr><th scope=row>14</th><td>1843</td><td>washington</td><td>6.660417</td><td>oregon</td><td> 7.337333</td></tr>
	<tr><th scope=row>15</th><td>1844</td><td>washington</td><td>6.531750</td><td>oregon</td><td> 7.123250</td></tr>
	<tr><th scope=row>16</th><td>1845</td><td>washington</td><td>7.046000</td><td>oregon</td><td> 7.591500</td></tr>
	<tr><th scope=row>17</th><td>1847</td><td>washington</td><td>9.620375</td><td>oregon</td><td>10.098625</td></tr>
	<tr><th scope=row>18</th><td>1848</td><td>washington</td><td>6.723917</td><td>oregon</td><td> 7.309333</td></tr>
	<tr><th scope=row>19</th><td>1849</td><td>washington</td><td>6.813583</td><td>oregon</td><td> 7.538333</td></tr>
	<tr><th scope=row>20</th><td>1850</td><td>washington</td><td>7.209583</td><td>oregon</td><td> 7.714333</td></tr>
	<tr><th scope=row>21</th><td>1851</td><td>washington</td><td>7.920500</td><td>oregon</td><td> 8.372000</td></tr>
	<tr><th scope=row>22</th><td>1852</td><td>washington</td><td>7.207500</td><td>oregon</td><td> 7.638750</td></tr>
	<tr><th scope=row>23</th><td>1853</td><td>washington</td><td>7.736083</td><td>oregon</td><td> 8.370250</td></tr>
	<tr><th scope=row>24</th><td>1854</td><td>washington</td><td>7.169167</td><td>oregon</td><td> 7.709500</td></tr>
	<tr><th scope=row>25</th><td>1855</td><td>washington</td><td>7.436583</td><td>oregon</td><td> 8.015667</td></tr>
	<tr><th scope=row>26</th><td>1856</td><td>washington</td><td>7.574167</td><td>oregon</td><td> 8.021750</td></tr>
	<tr><th scope=row>27</th><td>1857</td><td>washington</td><td>8.054417</td><td>oregon</td><td> 8.568167</td></tr>
	<tr><th scope=row>28</th><td>1858</td><td>washington</td><td>7.068667</td><td>oregon</td><td> 7.769583</td></tr>
	<tr><th scope=row>29</th><td>1859</td><td>washington</td><td>6.380583</td><td>oregon</td><td> 7.064750</td></tr>
	<tr><th scope=row>30</th><td>1860</td><td>washington</td><td>7.778917</td><td>oregon</td><td> 8.062000</td></tr>
	<tr><th scope=row>...</th><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><th scope=row>154</th><td>1984</td><td>washington</td><td> 7.356750</td><td>oregon</td><td> 7.715833</td></tr>
	<tr><th scope=row>155</th><td>1985</td><td>washington</td><td> 6.574917</td><td>oregon</td><td> 7.136250</td></tr>
	<tr><th scope=row>156</th><td>1986</td><td>washington</td><td> 8.401333</td><td>oregon</td><td> 9.047667</td></tr>
	<tr><th scope=row>157</th><td>1987</td><td>washington</td><td> 8.887917</td><td>oregon</td><td> 9.132833</td></tr>
	<tr><th scope=row>158</th><td>1988</td><td>washington</td><td> 8.402917</td><td>oregon</td><td> 8.908750</td></tr>
	<tr><th scope=row>159</th><td>1989</td><td>washington</td><td> 7.971750</td><td>oregon</td><td> 8.187167</td></tr>
	<tr><th scope=row>160</th><td>1990</td><td>washington</td><td> 8.371167</td><td>oregon</td><td> 8.605333</td></tr>
	<tr><th scope=row>161</th><td>1991</td><td>washington</td><td> 8.302250</td><td>oregon</td><td> 8.716000</td></tr>
	<tr><th scope=row>162</th><td>1992</td><td>washington</td><td> 9.152750</td><td>oregon</td><td> 9.712500</td></tr>
	<tr><th scope=row>163</th><td>1993</td><td>washington</td><td> 7.423583</td><td>oregon</td><td> 7.580667</td></tr>
	<tr><th scope=row>164</th><td>1994</td><td>washington</td><td> 8.724583</td><td>oregon</td><td> 8.877417</td></tr>
	<tr><th scope=row>165</th><td>1995</td><td>washington</td><td> 8.561167</td><td>oregon</td><td> 9.010500</td></tr>
	<tr><th scope=row>166</th><td>1996</td><td>washington</td><td> 7.507667</td><td>oregon</td><td> 8.723000</td></tr>
	<tr><th scope=row>167</th><td>1997</td><td>washington</td><td> 8.368667</td><td>oregon</td><td> 8.838833</td></tr>
	<tr><th scope=row>168</th><td>1998</td><td>washington</td><td> 9.123000</td><td>oregon</td><td> 8.897083</td></tr>
	<tr><th scope=row>169</th><td>1999</td><td>washington</td><td> 8.242667</td><td>oregon</td><td> 8.541000</td></tr>
	<tr><th scope=row>170</th><td>2000</td><td>washington</td><td> 7.859917</td><td>oregon</td><td> 8.678000</td></tr>
	<tr><th scope=row>171</th><td>2001</td><td>washington</td><td> 8.284000</td><td>oregon</td><td> 8.882667</td></tr>
	<tr><th scope=row>172</th><td>2002</td><td>washington</td><td> 8.288750</td><td>oregon</td><td> 8.806167</td></tr>
	<tr><th scope=row>173</th><td>2003</td><td>washington</td><td> 9.032333</td><td>oregon</td><td> 9.564250</td></tr>
	<tr><th scope=row>174</th><td>2004</td><td>washington</td><td> 9.111833</td><td>oregon</td><td> 9.285167</td></tr>
	<tr><th scope=row>175</th><td>2005</td><td>washington</td><td> 8.531750</td><td>oregon</td><td> 8.840000</td></tr>
	<tr><th scope=row>176</th><td>2006</td><td>washington</td><td> 8.675333</td><td>oregon</td><td> 8.960333</td></tr>
	<tr><th scope=row>177</th><td>2007</td><td>washington</td><td> 8.302417</td><td>oregon</td><td> 8.895833</td></tr>
	<tr><th scope=row>178</th><td>2008</td><td>washington</td><td> 7.685917</td><td>oregon</td><td> 8.315167</td></tr>
	<tr><th scope=row>179</th><td>2009</td><td>washington</td><td> 8.047583</td><td>oregon</td><td> 8.559083</td></tr>
	<tr><th scope=row>180</th><td>2010</td><td>washington</td><td> 8.442167</td><td>oregon</td><td> 8.574583</td></tr>
	<tr><th scope=row>181</th><td>2011</td><td>washington</td><td> 7.619333</td><td>oregon</td><td> 8.077583</td></tr>
	<tr><th scope=row>182</th><td>2012</td><td>washington</td><td> 8.477917</td><td>oregon</td><td> 9.030083</td></tr>
	<tr><th scope=row>183</th><td>2013</td><td>washington</td><td>10.571778</td><td>oregon</td><td>10.763556</td></tr>
</tbody>
</table>




```R
ggplot(com_clim1, aes(x=Year, y=WA_temperature, color = "red")) + 
geom_smooth()
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'
    
    


    
![png](output_34_1.png)
    



```R
g <- ggplot(com_clim1, aes(x=Year))
g <- g + geom_smooth(aes(y=WA_temperature, color = "red"))
g <- g + geom_smooth(aes(y=OR_temperature)) + 
ggtitle("Plot of WA and OR Temperature") +
xlab("Year") + ylab("WA Temperature and OR Temperature, WA is red")

```


```R
g


```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'
    
    `geom_smooth()` using method = 'loess' and formula 'y ~ x'
    
    


    
![png](output_36_1.png)
    

Testing melt function. 

```R
mdf <- melt(com_clim1, id = c("Year", "WA", "OR"))
mdf
```


<table class="dataframe">
<caption>A data.frame: 366 × 5</caption>
<thead>
	<tr><th scope=col>Year</th><th scope=col>WA</th><th scope=col>OR</th><th scope=col>variable</th><th scope=col>value</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;fct&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1828</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.235727</td></tr>
	<tr><td>1829</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>6.834182</td></tr>
	<tr><td>1832</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>2.855625</td></tr>
	<tr><td>1833</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.645417</td></tr>
	<tr><td>1834</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.274417</td></tr>
	<tr><td>1835</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>5.542091</td></tr>
	<tr><td>1836</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>6.849917</td></tr>
	<tr><td>1837</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>6.934750</td></tr>
	<tr><td>1838</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>6.698250</td></tr>
	<tr><td>1839</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.464000</td></tr>
	<tr><td>1840</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>6.829417</td></tr>
	<tr><td>1841</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>6.951333</td></tr>
	<tr><td>1842</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.058667</td></tr>
	<tr><td>1843</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>6.660417</td></tr>
	<tr><td>1844</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>6.531750</td></tr>
	<tr><td>1845</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.046000</td></tr>
	<tr><td>1847</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>9.620375</td></tr>
	<tr><td>1848</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>6.723917</td></tr>
	<tr><td>1849</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>6.813583</td></tr>
	<tr><td>1850</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.209583</td></tr>
	<tr><td>1851</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.920500</td></tr>
	<tr><td>1852</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.207500</td></tr>
	<tr><td>1853</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.736083</td></tr>
	<tr><td>1854</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.169167</td></tr>
	<tr><td>1855</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.436583</td></tr>
	<tr><td>1856</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.574167</td></tr>
	<tr><td>1857</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>8.054417</td></tr>
	<tr><td>1858</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.068667</td></tr>
	<tr><td>1859</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>6.380583</td></tr>
	<tr><td>1860</td><td>washington</td><td>oregon</td><td>WA_temperature</td><td>7.778917</td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>1984</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 7.715833</td></tr>
	<tr><td>1985</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 7.136250</td></tr>
	<tr><td>1986</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 9.047667</td></tr>
	<tr><td>1987</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 9.132833</td></tr>
	<tr><td>1988</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.908750</td></tr>
	<tr><td>1989</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.187167</td></tr>
	<tr><td>1990</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.605333</td></tr>
	<tr><td>1991</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.716000</td></tr>
	<tr><td>1992</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 9.712500</td></tr>
	<tr><td>1993</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 7.580667</td></tr>
	<tr><td>1994</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.877417</td></tr>
	<tr><td>1995</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 9.010500</td></tr>
	<tr><td>1996</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.723000</td></tr>
	<tr><td>1997</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.838833</td></tr>
	<tr><td>1998</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.897083</td></tr>
	<tr><td>1999</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.541000</td></tr>
	<tr><td>2000</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.678000</td></tr>
	<tr><td>2001</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.882667</td></tr>
	<tr><td>2002</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.806167</td></tr>
	<tr><td>2003</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 9.564250</td></tr>
	<tr><td>2004</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 9.285167</td></tr>
	<tr><td>2005</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.840000</td></tr>
	<tr><td>2006</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.960333</td></tr>
	<tr><td>2007</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.895833</td></tr>
	<tr><td>2008</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.315167</td></tr>
	<tr><td>2009</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.559083</td></tr>
	<tr><td>2010</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.574583</td></tr>
	<tr><td>2011</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 8.077583</td></tr>
	<tr><td>2012</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td> 9.030083</td></tr>
	<tr><td>2013</td><td>washington</td><td>oregon</td><td>OR_temperature</td><td>10.763556</td></tr>
</tbody>
</table>




```R
ggplot(mdf)+
geom_smooth(aes(x=Year, y=value, col=variable))
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'
    
    


    
![png](output_38_1.png)
    



```R

```
