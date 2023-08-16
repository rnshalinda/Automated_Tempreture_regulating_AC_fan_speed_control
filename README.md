# Tempreture regulating AC-fan speed control
 
## Used software:
This project is developed using mikroC PRO V7.2.0 to program the PIC microcontroller, and Proteus V8.0 for simulation purposes

## Instructions for Running the Simulation: 

<img width="657" alt="Capture" src="https://github.com/rnshalinda/Automated_Tempreture_regulating_AC_fan_speed_control/assets/133548503/d0bd9a4e-404b-4fb2-aa07-f5e33105f1e0">

1. Please clone this repo to your PC
2. Please install mentioned programs.
3. In sims folder, Open 'New Project.pdsprj' file via Proteus-8.0 and hit 'Play'.
4. If the simulation doesn't start, reallocate the .HEX files as follows:
    * Double click on PIC16F877A component.
    * Set processor clock frequency to 8MHz.
    * In "code -- fan speed controlled" folder relocate .HEX file.

5. Adjust the POT tempreture reading.
6. Tempreture reading below below < 25c should display RPM:OFF, indicating the FAN is OFF.
7. FAN speed increases with every five degrees increase.

8. Sequence Operation:
   
   ![IMG_20230816_170950](https://github.com/rnshalinda/Automated_Tempreture_regulating_AC_fan_speed_control/assets/133548503/b6fa4890-8137-4adf-b880-e3f3549ad6c8)

### 25< degrees

   ![image](https://github.com/rnshalinda/Automated_Tempreture_regulating_AC_fan_speed_control/assets/133548503/2364a9da-5fd4-42eb-9538-1cd641d02db6) ![image](https://github.com/rnshalinda/Automated_Tempreture_regulating_AC_fan_speed_control/assets/133548503/84a13168-0793-4be8-8e38-b8e2561cd8c6) ![image](https://github.com/rnshalinda/Automated_Tempreture_regulating_AC_fan_speed_control/assets/133548503/f85ea633-9cea-4b9b-8186-54b9c9f140a2)


