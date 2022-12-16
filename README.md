
# Remix of Lixie II Open Hardware
Want to make your own Lixie II, but don't want to spend $$$$? You're in the right place. 

Based on the original work by Connor Nishijima: https://github.com/connornishijima/Lixie_II_OSHW

## Remix Notes
- PCB redrawn with a new BOM, using reverse mount LEDs. https://www.adafruit.com/product/4960
  - Loosely based on Adafruit's RGB NeoKey https://www.adafruit.com/product/5157
  - One capacitor per LED
  - Transmission resistors for stable data
- EPS files for lasercutting were converted to DXF.
- Laser Cut files have been redrawn for smaller runs.  
  - Ordering one set = One Digit of the Display
  - Ponoko wil auto-panelize larger orders together.
  - Be sure to read https://help.ponoko.com/en/articles/4405518-getting-started-with-ponoko
- 3D Printed versions of some of the lasercut files

|Filename|Supplier|Material|Thickness|
| ----------- | ----------- | ----------- | ----------- |
|BASEx2.dxf|Ponoko|Black Melamine MDF|6.4|
|NUM0-9.dxf|Ponoko|Clear Acrylic|1.5|
|DECIMAL.dxf|Ponoko|Gray Translucent Acrylic|3|
|LIGHTFILTER.dxf|Ponoko|6061-T6 Aluminum|1|


- LixieII_Price_Calculator.xlsx calculates the cost (including electronics) based on how many you would like to make.  
Here are some BOM estimates as of Oct 28, 2022:

|QTY|Total Cost|Cost Each|
| ----------- | ----------- | ----------- |
|1|$166|$166|
|2|$233|$117|
|4|$255|$64|
|8|$392|$49|
|10|$446|$45|
|16|$665|$42|
|32|$1250|$39|
|200|$4740|$24|


## Todo

- Convert Lightplate into pcb gerbers for cheaper cutting

