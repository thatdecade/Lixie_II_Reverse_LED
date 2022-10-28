To put this kit together, you will need to order parts below.  One set per digit of your display.

**Not listed**: Arduino-compatible dev board to drive the lights.  Wifi enabled ESP8266 is recommended.

* Laser cut parts
  * BASEx2.dxf
  * NUM0-9.dxf
  * DECIMAL.dxf
  * LIGHTFILTER.dxf

* PCB Assemblies
  * Lixie_II_Reverse_LED_GERBERS.zip
  * Lixie_II_Reverse_LED_BOM.xlsx
  * Lixie_II_Reverse_LED_PLACEMENT.xlsx

* Hardware store
  * 2x Nitrile Gloves
  * 4x 35mm M3 Screw
  * 4x 25mm M3 screw
  * 8x Nylon washer
  * 8x M3 Flange Nut
  * 3x Female Jumper Wires 10cm

# Lixie Base Assembly

* Stack the two black melamine wood base pieces.  Orient so that the thicker 3mm slot is farthest from you.
* Insert 4x 25 mm screw and 4x washers through each of the four inner holes.
* Insert 4x 35 mm screw and 4x washers through each of the four outer holes.
* Add the light filter to the stack. 
* Add the PCB to the stack.
* Take a moment to examine your stack.  
  * Each layer should sit completly flush, with no gaps.  
  * The LEDs should face through the light filter.
  * The LEDs and Light filter should line up with each acrylic slot.
  * Don't worry if you got the orientations wrong, you can always take it apart and try again :)
* Now is time to add the nuts.  Gently tighten 8x flange nuts to the screws.

# Acrylic Assembly

* Peel the paper backing from each acrylic digit and place straight into the Lixie Base.
* There is no step 2.

**Notes:**
- The order of each acrylic digit is important (front to back): 1 0 2 9 3 8 4 7 5 6 .
- Before working with the acrylic, it is important that you wear gloves.  Fingerprints can be cleaned from the acrylic, but let's try and skip that step.
- Peeling from the bottom of each digit will allow you to hide any initial blemishes.

# Power Up and Programming

There are three pins on each side of the PCB.  Allowing you to daisy chain many displays.
If you plan for more than 10 displays, you may want to look into running additional wires from the one power supply to both sides of the chain.

For the data wires, the LEDs are 5V.  So if your arduino-compatible board is 3.3V like the ESP8266 then you either need to keep the data wire lengths short (under 10cm) or you need a 3.3V to 5V converter circuit. More info: https://learn.adafruit.com/neopixel-levelshifter

You can see programming examples from the main Lixie repo: https://github.com/connornishijima/Lixie_II


