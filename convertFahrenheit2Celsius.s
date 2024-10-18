#
# Program Name: convertFahrenheitToCelcius.s
# Author: Olivia Blute
# Date: 10/17/2024
# Purpose: Calculates a temperature from fahrenheit to celsius.
# Inputs:
# - input1: Temperature in Fahrenheit user wants converted
# Outputs:
# - format1: Tempertaure in celius
#
.text
.global main

main:
    # Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt user for inout in Farhenheit
    LDR r0, =prompt1
    BL printf

    # Take user input from sScanf
    LDR r0, =input1
    SUB sp, sp, #4
    MOV r1, sp
    BL scanf
    LDR r0, [sp, #0]
    ADD sp, sp, #4

    # Convert
    BL F2C
    MOV r1, r0

    # Print converted value
    LDR r0, =format1
    BL printf

    # Return to the OS
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Prompts the user to enter in the temperature in fahrenheit
    prompt1: .asciz "Enter the temp in F: \n"
    # Tells the user what the temperature conversion is
    format1: .asciz "\nThe temp in C is: %d\n"
    # Takes user input value for calculation
    input1: .asciz "%d"
    num1: .word 0
