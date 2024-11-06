# 
# Program Name: mult.s
# Author: Olivia Blute
# Date: 11/06/2024
# Purpose: Prompt the user for a value to multiply and a value for to multiply by
# Inputs:
# - num1: number to multiply
# - num2: number to multiply by
# Outputs:
# - Result of multiplication
#
.global main
main:
    # Push the stack
    SUB sp, sp, #4
    STR lr, [sp]

    # Prompt user and load in addresses
    LDR r0, =prompt1
    BL printf
    LDR r0, =format
    LDR r1, =number1
    BL scanf

    LDR r0, =prompt2
    BL printf
    LDR r0, =format
    LDR r1, =number2
    BL scanf

    # Load in values from addresses
    LDR r0, =number1 // M
    LDR r0, [r0]
    LDR r1, =number2 // N
    LDR r1, [r1]

    # Branch to multiplication function
    BL Mult

    # Move for output printing
    MOV r1, r0  

    # Print the utput
    LDR r0, =output
    BL printf

    # Pop the stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Asks the user for values
    prompt1: .asciz "\nEnter a value to multiply: "
    prompt2: .asciz "\nEnter a value for the successive addition for multiplication: "
    # Tells the user the result
    output: .asciz "\n Your multiplication result is: %d\n"
    # Takes the input values
    format: .asciz "%d"
    number1: .word 0
    number2: .word 0

# END main

.text
Mult:
    #push the stack
    SUB sp, sp, #12
    STR lr, [sp, #0]
    STR r4, [sp, #4] // Make space for preservered params
    STR r5, [sp, #8]
    
    MOV r4, r0 // Move m param to make it safe
    MOV r5, r1 // Move n param to make it safe

    #if (n == 1) return m
    CMP r5, #1
    BNE  Else // Branch to Else if not equal
        MOV r0, r4
        B Return // return m
    Else:
        SUB r1, r5, #1 // r1 should now have n (r5) -1
        BL Mult // pass that to Mult
        ADD r0, r4, r0 // What came back from sum plus r4 and put into r0
        B Return
    Endif: 

    # Pop the stack
    Return: 
    LDR lr, [sp, #0]
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    ADD sp, sp, #12
    MOV pc, lr

.data

# END mult
