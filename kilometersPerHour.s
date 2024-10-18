#
# Program Name: kilometersPerHourMain.s
# Author: Olivia Blute
# Date: 10/17/2024
# Purpose: Calculates kilometers per hour.
# Inputs:
# - input1: Miles to be converted
# - input2: Hours
# Outputs:
# - format1: The calculated kilometers per hour
.text
.global main

main:
    # Save return to os on stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt user for an input in mi
    LDR r0, =prompt1
    BL printf

    # Scanf
    LDR r0, =input1
    LDR r1, =numMiles
    BL scanf // Reads mi input

    # Prompt user for input hours
    LDR r0, =prompt2
    BL printf

    # Scanf hour input
    LDR r0, =input1
    LDR r1, =numHours
    BL scanf // reads hours

    # Convert to kph
    LDR r0, =numMiles
    LDR r0, [r0]
    LDR r1, =numHours
    LDR r1, [r1]
    BL KPH
    MOV r1, r0

    # Print kph
    LDR r0, =format1
    BL printf

    # Pop the stack
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Prompts the user to enter distance in miles
    prompt1: .asciz "Enter the distance in miles: "
    # Prompts the user to enter number of hours
    prompt2: .asciz "Enter the number of hours: "
    # Tells the user the kilometers per hour value
    format1: .asciz "\nThe kilometers per hour: %d\n"
    # Takes the input value 
    input1: .asciz "%d"
    numMiles: .word 0
    numHours: .word 0
