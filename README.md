this project was made for fun and maybe some advertising but the code drives an 128x48 
pixel-led dot matrix assembly controlled by max7291 constant curent led matrix driver.
*  -using **ATMEGA 1284P** MICROCONTROLLER and **2088AS** led matrix
*  -code is written in **assmebly** language , compiled with **microchip studio**
*  -it uses simple comunication through **UART** with an **HC-05 bluetooth** serial interface for changing text and various settings
*  -reads time and date from **NEO-6M GPS** Module
*  -reads temperature with **DS18-B**
*  -using different fonts

# KiCad design files for building the project

- **DOTM_MAINB.ZIP**: mainboard controller ATMega 1284P @20Mhz
- **DOTM_MODULE_V2.ZIP**: LED2088AS module board (4 modules)

*  mainboard:
![mainboard](https://github.com/janos-raul/dot_matrix-128x48/blob/main/pics/dot_mainb.png)
*  LED module:
![led module](https://github.com/janos-raul/dot_matrix-128x48/blob/main/pics/DOTM_M6.png)
*  Demo:
![Demo](https://github.com/janos-raul/dot_matrix-128x48/blob/main/pics/led%20matrix%20128x48.gif)


