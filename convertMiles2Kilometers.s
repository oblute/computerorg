#
# Program Name: convertMiles2Kilometers.s
# Author: Olivia Blute
# Date: 10/17/2024
# Purpose: Converts number of miles to kilometers.
# Inputs:
# - input1: Number of miles user wants converted
# Outputs:
# - format1: Miles in kilometeres 
#
.text
.global main

main:
    # Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt for an input in miles
    LDR r0, =prompt1
    BL printf

    # Scanf
    LDR r0, =input1
    SUB sp, sp, #4
    MOV r1, sp
    BL scanf
    LDR r0, [sp, #0]
    ADD sp, sp, #4

    # Convert
    BL Miles2Kilometers
    MOV r1, r0

    # Print Kilometer value
    LDR r0, =format1
    BL printf

    # Return to the OS
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Prompts the user for number of miles to convert
    prompt1: .asciz "Enter the number of miles: \n"
    # Tells the user the result
    format1: .asciz "\nThe miles in kilometers: %d\n"
    # Takes the user input value
    input1: .asciz "%d"
    num1: .word 0
