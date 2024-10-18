#
# Program Name: convertFeet2Inches.s
# Author: Olivia Blute
# Date: 10/17/2024
# Purpose: Converts feet to inches.
# Inputs:
# - input1: Length in feet user wants converted
# Outputs:
# - format1: Length in inches
#
.text
.global main

main: 
    # Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt for an input in feet
    LDR r0, =prompt1
    BL printf

    # Take input with scanf
    LDR r0, =input1
    SUB sp, sp, #4
    MOV r1, sp
    MOV r1, sp
    BL scanf
    LDR r0, [sp, #0]
    ADD sp, sp, #4

    # Convert
    BL Ft2Inches
    MOV r1, r0

    # Print inches
    LDR r0, =format1
    BL printf

    # Return to the OS
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Prompts the user for feet number to convert to inches
    prompt1: .asciz "Enter the length in feet you want in inches: \n"
    # Tells the user the converted number
    format1: .asciz "\nThe length in inches is %d\n"
    # Takes the user value
    input1: .asciz "%d"
    num1: .word 0
