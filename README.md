# Tempreture regulating AC-fan speed control
 
## Used software:
This project is developed using mikroC PRO V7.2.0 to program the PIC microcontroller, and Proteus V8.0 for simulation purposes

## Instructions for Running the Simulation: 
1. Please clone this repo to your PC
2. Please install mentioned programs.
3. In sims folder, Open 'New Project.pdsprj' file via Proteus-8.0 and hit 'Play'.
4. If the simulation doesn't start, reallocate the .HEX files as follows:
    * Double click on PIC16F877A component.
    * Set processor clock frequency to 8MHz.
    * In "code -- fan speed controlled" folder relocate .HEX file.

5. Adjust the POT tempreture reading.
6. Tempreture reading below below < 25c should display RPM:OFF, indicating the FAN is OFF.
7. FAN speed increases every five degrees increase.
