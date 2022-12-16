Here you will find the files for the PCB.  

To order the PCBs pre-assembled, visit [pcbshopper](https://pcbshopper.com/) and click the Assembly tab.  Then you can fill out the form and compare pricing from different assemblers.

## Files for assembly:

* Lixie_II_Reverse_LED_GERBERS.zip
* Lixie_II_Reverse_LED_BOM.xlsx
* Lixie_II_Reverse_LED_PLACEMENT.xlsx

## Notes:

* If you don't have EagleCAD to open the .brd/.sch files, you can use the free version of Autodesk Fusion 360 and download Eagle Free.
* I use eagle to generate the .dxf files, ensuring alignment between the pcb and other layers.  

## Generating the DXF Files
Example for LIGHTFILTER.dxf
1. Open the the .brd file in eagle
1. View>Layer Settings: 
> * Select None
> * Select only the LIGHTFILTER/ENGRAVING layers
3. File>Export>DXF: 
> * Name the output file: LIGHTFILTER.dxf
> * Unselect Fill areas
> * Unselect Use wire widths
> * Set Units to mm
> * Press OK

![image](https://user-images.githubusercontent.com/6401110/198635013-37d63f40-745a-42ab-a68d-80de9853c155.png)
