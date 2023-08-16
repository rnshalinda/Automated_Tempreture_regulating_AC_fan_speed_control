#line 1 "C:/Users/NSR/Desktop/jr micro c/Assignment/code/Motorcontroller.c"

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


 unsigned int Temp = 0;
 double mV,cel;
 char RPM[3];
 int PWM;
 unsigned int txt[4];

 void speed() {
 PWM1_Start();
 PORTC.B1 = 0;
 PWM1_Set_Duty(PWM);
 }

void main()
{
 TRISA.RA0 = 1;
 TRISC = 0;
 ADC_Init();
 lcd_init();
 PWM1_init(1000);

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_out(1,1,"Automatic AC Fan");
 Delay_ms(2000);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"Temp:");


 do
 {
 Temp = ADC_Read(0);
 mV = Temp*5000.0/1024.0;
 cel = mV/10.0;
 FloatToStr(cel,txt);
 Lcd_Out(1,6,txt);
 Lcd_Chr(1,14,176);
 Lcd_Chr(1,15,'C');

 Lcd_Cmd(_LCD_SECOND_ROW);
 Lcd_Out(2,1," RPM:");

 if (cel >= 25 && cel < 30)
 {

 strcpy(RPM,"100");
 PWM=60;
 speed();
 }
 else if (cel >= 30 && cel < 35)
 {

 strcpy(RPM,"200");
 PWM=100;
 speed();
 }
 else if (cel >= 35 && cel < 40)
 {

 strcpy(RPM,"400");
 PWM=150;
 speed();
 }
 else if (cel >= 40 && cel < 45)
 {

 strcpy(RPM,"600");
 PWM=200;
 speed();
 }

 else if (cel >= 45 && cel <= 50)
 {

 strcpy(RPM,"750");
 PWM=235;
 speed();
 }
 else if (50 < cel)
 {

 strcpy(RPM,"800");
 PWM=255;
 speed();
 }

 else if(cel < 25)
 {
 PORTC.B1 = 1;

 strcpy(RPM,"OFF");
 }
 Lcd_Out(2,6,RPM);

 }while(1);
}
