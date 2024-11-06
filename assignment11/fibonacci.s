#
# Program Name: fibonacci.s
# Author: Olivia Blute
# Date 11/06/2024
# Purpose: Prompt the user for a number, and calculate its Fibonacci value
# Inputs:
# - Number
# Outputs:
# - Fibonacci value
#
.global main
main:
    # Push the stack
    SUB sp, sp, #4
    STR lr, [sp]

    # Prompt user for value
    LDR r0, =prompt1
    BL printf
    LDR r0, =format
    LDR r1, =number
    BL scanf

    # Load in value from address
    LDR  r0, =number
    LDR r0, [r0]
    # Branch to Fib method
    BL Fib

    # Move result into r1 for printing
    MOV r1, r0

    # Print result
    LDR r0, =output
    BL printf

    # Pop the stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Prompt the user for the number
    prompt1: .asciz "\nEnter a number to calculate its Fibonacci value:  "
    # Tells the user the Fibonacci value
    output: .asciz "\nFibonacci number is: %d\n"
    # Takes the input value
    format: .asciz "%d"
    number: .word 0

# END main

.text
Fib:
    # Push the stack
    SUB sp, sp, #12
    STR lr, [sp]
    STR r4, [sp, #4] // Make space for saved param
    STR r5, [sp, #8] // Make space for output

    # Move to keep safe
    MOV r4, r0

    #if (n == 0 || n == 1) return 1
    CMP r4, #1
    BGT Else // Branch if greater than 0 or 1
        MOV r0, #1
        B Return
    Else: // return Fib(n - 1) + Fib(n - 2)
        SUB r0, r4, #1
        BL Fib
        MOV r5, r0
        SUB r0, r4, #2
        BL Fib
        ADD r0, r0, r5
        B Return
    Endif:

    # Pop the stack
    Return:
    LDR lr, [sp]
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    ADD sp, sp, #12
    MOV pc, lr

.data

# END Fib
