
_speed:

;Motorcontroller.c,23 :: 		void speed() {            // speed(); fuction called inside the main loop
;Motorcontroller.c,24 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;Motorcontroller.c,25 :: 		PORTC.B1 = 0;
	BCF        PORTC+0, 1
;Motorcontroller.c,26 :: 		PWM1_Set_Duty(PWM);
	MOVF       _PWM+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Motorcontroller.c,27 :: 		}
L_end_speed:
	RETURN
; end of _speed

_main:

;Motorcontroller.c,29 :: 		void main()
;Motorcontroller.c,31 :: 		TRISA.RA0 = 1;    // Configure PORT A as input
	BSF        TRISA+0, 0
;Motorcontroller.c,32 :: 		TRISC = 0;        // configure port c as output
	CLRF       TRISC+0
;Motorcontroller.c,33 :: 		ADC_Init();       // initialize Analog to Digital Convertor
	CALL       _ADC_Init+0
;Motorcontroller.c,34 :: 		lcd_init();       // initialize LCD
	CALL       _Lcd_Init+0
;Motorcontroller.c,35 :: 		PWM1_init(1000);
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      124
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;Motorcontroller.c,37 :: 		Lcd_Cmd(_LCD_CLEAR);            // Clear LCD Display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Motorcontroller.c,38 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);       // Cursor OFF
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Motorcontroller.c,40 :: 		Lcd_out(1,1,"Automatic AC Fan");          // Display Automatic AC Fan
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_Motorcontroller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Motorcontroller.c,41 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;Motorcontroller.c,42 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Motorcontroller.c,43 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Motorcontroller.c,44 :: 		Lcd_Out(1,1,"Temp:");             // Display Temperature Value
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_Motorcontroller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Motorcontroller.c,47 :: 		do
L_main1:
;Motorcontroller.c,49 :: 		Temp = ADC_Read(0);                     // Read Analog Signal
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _Temp+0
	MOVF       R0+1, 0
	MOVWF      _Temp+1
;Motorcontroller.c,50 :: 		mV = Temp*5000.0/1024.0;              // Convert to mV
	CALL       _word2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      64
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      139
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      137
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _mV+0
	MOVF       R0+1, 0
	MOVWF      _mV+1
	MOVF       R0+2, 0
	MOVWF      _mV+2
	MOVF       R0+3, 0
	MOVWF      _mV+3
;Motorcontroller.c,51 :: 		cel = mV/10.0;                         // Convert mV to Celcius
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _cel+0
	MOVF       R0+1, 0
	MOVWF      _cel+1
	MOVF       R0+2, 0
	MOVWF      _cel+2
	MOVF       R0+3, 0
	MOVWF      _cel+3
;Motorcontroller.c,52 :: 		FloatToStr(cel,txt);
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _txt+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;Motorcontroller.c,53 :: 		Lcd_Out(1,6,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Motorcontroller.c,54 :: 		Lcd_Chr(1,14,176);                     // 176 ASCII for Celsius degrees
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      176
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Motorcontroller.c,55 :: 		Lcd_Chr(1,15,'C');
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;Motorcontroller.c,57 :: 		Lcd_Cmd(_LCD_SECOND_ROW);
	MOVLW      192
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Motorcontroller.c,58 :: 		Lcd_Out(2,1," RPM:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_Motorcontroller+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Motorcontroller.c,60 :: 		if (cel >= 25 && cel < 30)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _cel+0, 0
	MOVWF      R0+0
	MOVF       _cel+1, 0
	MOVWF      R0+1
	MOVF       _cel+2, 0
	MOVWF      R0+2
	MOVF       _cel+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      112
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _cel+0, 0
	MOVWF      R0+0
	MOVF       _cel+1, 0
	MOVWF      R0+1
	MOVF       _cel+2, 0
	MOVWF      R0+2
	MOVF       _cel+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
L__main31:
;Motorcontroller.c,63 :: 		strcpy(RPM,"100");   // strcpy assign string "100" to RMP variable
	MOVLW      _RPM+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr4_Motorcontroller+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Motorcontroller.c,64 :: 		PWM=60;
	MOVLW      60
	MOVWF      _PWM+0
	MOVLW      0
	MOVWF      _PWM+1
;Motorcontroller.c,65 :: 		speed();             // Fan Speed
	CALL       _speed+0
;Motorcontroller.c,66 :: 		}
	GOTO       L_main7
L_main6:
;Motorcontroller.c,67 :: 		else if (cel >= 30 && cel < 35)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      112
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _cel+0, 0
	MOVWF      R0+0
	MOVF       _cel+1, 0
	MOVWF      R0+1
	MOVF       _cel+2, 0
	MOVWF      R0+2
	MOVF       _cel+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      12
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _cel+0, 0
	MOVWF      R0+0
	MOVF       _cel+1, 0
	MOVWF      R0+1
	MOVF       _cel+2, 0
	MOVWF      R0+2
	MOVF       _cel+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
L__main30:
;Motorcontroller.c,70 :: 		strcpy(RPM,"200");
	MOVLW      _RPM+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr5_Motorcontroller+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Motorcontroller.c,71 :: 		PWM=100;
	MOVLW      100
	MOVWF      _PWM+0
	MOVLW      0
	MOVWF      _PWM+1
;Motorcontroller.c,72 :: 		speed();
	CALL       _speed+0
;Motorcontroller.c,73 :: 		}
	GOTO       L_main11
L_main10:
;Motorcontroller.c,74 :: 		else if (cel >= 35 && cel < 40)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      12
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _cel+0, 0
	MOVWF      R0+0
	MOVF       _cel+1, 0
	MOVWF      R0+1
	MOVF       _cel+2, 0
	MOVWF      R0+2
	MOVF       _cel+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _cel+0, 0
	MOVWF      R0+0
	MOVF       _cel+1, 0
	MOVWF      R0+1
	MOVF       _cel+2, 0
	MOVWF      R0+2
	MOVF       _cel+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
L__main29:
;Motorcontroller.c,77 :: 		strcpy(RPM,"400");
	MOVLW      _RPM+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr6_Motorcontroller+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Motorcontroller.c,78 :: 		PWM=150;
	MOVLW      150
	MOVWF      _PWM+0
	CLRF       _PWM+1
;Motorcontroller.c,79 :: 		speed();
	CALL       _speed+0
;Motorcontroller.c,80 :: 		}
	GOTO       L_main15
L_main14:
;Motorcontroller.c,81 :: 		else if (cel >= 40 && cel < 45)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _cel+0, 0
	MOVWF      R0+0
	MOVF       _cel+1, 0
	MOVWF      R0+1
	MOVF       _cel+2, 0
	MOVWF      R0+2
	MOVF       _cel+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main18
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      52
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _cel+0, 0
	MOVWF      R0+0
	MOVF       _cel+1, 0
	MOVWF      R0+1
	MOVF       _cel+2, 0
	MOVWF      R0+2
	MOVF       _cel+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main18
L__main28:
;Motorcontroller.c,84 :: 		strcpy(RPM,"600");
	MOVLW      _RPM+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr7_Motorcontroller+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Motorcontroller.c,85 :: 		PWM=200;
	MOVLW      200
	MOVWF      _PWM+0
	CLRF       _PWM+1
;Motorcontroller.c,86 :: 		speed();
	CALL       _speed+0
;Motorcontroller.c,87 :: 		}
	GOTO       L_main19
L_main18:
;Motorcontroller.c,89 :: 		else if (cel >= 45 && cel <= 50)
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      52
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	MOVF       _cel+0, 0
	MOVWF      R0+0
	MOVF       _cel+1, 0
	MOVWF      R0+1
	MOVF       _cel+2, 0
	MOVWF      R0+2
	MOVF       _cel+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVF       _cel+0, 0
	MOVWF      R4+0
	MOVF       _cel+1, 0
	MOVWF      R4+1
	MOVF       _cel+2, 0
	MOVWF      R4+2
	MOVF       _cel+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      72
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main22
L__main27:
;Motorcontroller.c,92 :: 		strcpy(RPM,"750");
	MOVLW      _RPM+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr8_Motorcontroller+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Motorcontroller.c,93 :: 		PWM=235;
	MOVLW      235
	MOVWF      _PWM+0
	CLRF       _PWM+1
;Motorcontroller.c,94 :: 		speed();
	CALL       _speed+0
;Motorcontroller.c,95 :: 		}
	GOTO       L_main23
L_main22:
;Motorcontroller.c,96 :: 		else if (50 < cel)
	MOVF       _cel+0, 0
	MOVWF      R4+0
	MOVF       _cel+1, 0
	MOVWF      R4+1
	MOVF       _cel+2, 0
	MOVWF      R4+2
	MOVF       _cel+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      72
	MOVWF      R0+2
	MOVLW      132
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main24
;Motorcontroller.c,99 :: 		strcpy(RPM,"800");
	MOVLW      _RPM+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr9_Motorcontroller+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Motorcontroller.c,100 :: 		PWM=255;
	MOVLW      255
	MOVWF      _PWM+0
	CLRF       _PWM+1
;Motorcontroller.c,101 :: 		speed();
	CALL       _speed+0
;Motorcontroller.c,102 :: 		}
	GOTO       L_main25
L_main24:
;Motorcontroller.c,104 :: 		else if(cel < 25)       // IF Temperature reading is below 25 degree Celcius, Turn OFF Motor
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      72
	MOVWF      R4+2
	MOVLW      131
	MOVWF      R4+3
	MOVF       _cel+0, 0
	MOVWF      R0+0
	MOVF       _cel+1, 0
	MOVWF      R0+1
	MOVF       _cel+2, 0
	MOVWF      R0+2
	MOVF       _cel+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main26
;Motorcontroller.c,106 :: 		PORTC.B1 = 1;
	BSF        PORTC+0, 1
;Motorcontroller.c,108 :: 		strcpy(RPM,"OFF");
	MOVLW      _RPM+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr10_Motorcontroller+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;Motorcontroller.c,109 :: 		}
L_main26:
L_main25:
L_main23:
L_main19:
L_main15:
L_main11:
L_main7:
;Motorcontroller.c,110 :: 		Lcd_Out(2,6,RPM);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      6
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _RPM+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Motorcontroller.c,112 :: 		}while(1);
	GOTO       L_main1
;Motorcontroller.c,113 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
