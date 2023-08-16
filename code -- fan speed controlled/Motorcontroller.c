// LCD Module Connections
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
// End of LCD  Module Connections

 unsigned int Temp = 0;
 double mV,cel;
 char RPM[3];     // string
 int PWM;
 unsigned int txt[4];

 void speed() {            // speed(); fuction called inside the main loop
      PWM1_Start();
      PORTC.B1 = 0;
      PWM1_Set_Duty(PWM);
      }

void main()
{
     TRISA.RA0 = 1;    // Configure PORT A as input
     TRISC = 0;        // configure port c as output
     ADC_Init();       // initialize Analog to Digital Convertor
     lcd_init();       // initialize LCD
     PWM1_init(1000);

     Lcd_Cmd(_LCD_CLEAR);            // Clear LCD Display
     Lcd_Cmd(_LCD_CURSOR_OFF);       // Cursor OFF

     Lcd_out(1,1,"Automatic AC Fan");          // Display Automatic AC Fan
     Delay_ms(2000);
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     Lcd_Out(1,1,"Temp:");             // Display Temperature Value


     do
     { 
       Temp = ADC_Read(0);                     // Read Analog Signal
       mV = Temp*5000.0/1024.0;              // Convert to mV
       cel = mV/10.0;                         // Convert mV to Celcius
       FloatToStr(cel,txt);
       Lcd_Out(1,6,txt);
       Lcd_Chr(1,14,176);                     // 176 ASCII for Celsius degrees
       Lcd_Chr(1,15,'C');

       Lcd_Cmd(_LCD_SECOND_ROW);
       Lcd_Out(2,1," RPM:");

           if (cel >= 25 && cel < 30)
              {
                  // temperatures between 25 and 30 degrees Celsius, set desired RPM to 100
                  strcpy(RPM,"100");   // strcpy assign string "100" to RMP variable
                  PWM=60;
                  speed();             // Fan Speed
              }
           else if (cel >= 30 && cel < 35)
              {
                  // temperatures between 30 and 35 degrees Celsius, set desired RPM to 200
                  strcpy(RPM,"200");
                  PWM=100;
                  speed();
              }
           else if (cel >= 35 && cel < 40)
              {
                 // temperature  between 35 and 40 degree Celcius, set desired RPM to 400
                  strcpy(RPM,"400");
                  PWM=150;
                  speed();
              }
           else if (cel >= 40 && cel < 45)
              {
                 // temperature between 40 and 45 degree Celcius, set desired RPM to 600
                  strcpy(RPM,"600");
                  PWM=200;
                  speed();
              }

           else if (cel >= 45 && cel <= 50)
              {
                 // temperature between 45 and 50 degree Celcius, set desired RPM to 750
                  strcpy(RPM,"750");
                  PWM=235;
                  speed();
              }
           else if (50 < cel)
              {
                  // temperature above 50 degree Celcius, set desired RPM to 800
                  strcpy(RPM,"800");
                  PWM=255;
                  speed();
              }

           else if(cel < 25)       // IF Temperature reading is below 25 degree Celcius, Turn OFF Motor
              {
                PORTC.B1 = 1;
                // temperatures below 25 degrees Celsius, set desired RPM to 0
                strcpy(RPM,"OFF");
              }
      Lcd_Out(2,6,RPM);

     }while(1);
}

