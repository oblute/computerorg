#
# Program Name: determinePrimeNumberMain.s
# Author: Olivia Blute
# Date: 10/29/2024
# Purpose: Prompt the user for a number, and determine if that number is prime
# Inputs:
# - num: number to determine
# Outputs:
# - Result if number is prime or not
#
.text
.global main
main:

    # Program Dictionary
    # r4 - counter for the prime loop
    # r5 - limit for the prime loop (r6 / r4 remainder)
    # r6 - number to check 

    # Push the stack
    SUB sp, sp, #24
    STR lr, [sp, #0]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    STR r6, [sp, #12]
    STR r7, [sp, #16]
    STR r8, [sp, #20]
   
    startMainLoop:
        # Prompt user
        LDR r0, =promptNumber
        BL printf

        # Scan in address
        LDR r0, =numFormat
        LDR r1, =num
        BL scanf

        # Load in value
        LDR r1, =num
        LDR r1, [r1]

        # Check loop condition
        CMP r1, #-1
        BEQ endMainLoop // -1 signals to end
        
        CMP r1, #2
        BLE errorMessage // Less than or equal to 2 errors

        # Initialize variables
        MOV r4, #2 // This is the counter, starts at 2, we increment this
        MOV r5, #0 // This is where we will store r6/r4
        MOV r6, r1 // This would be the number to check

        # Loop statement or block
        startPrimeLoop:
            # Check condition
            SUB r5, r6, #1
            CMP r4, r5
            BGT isPrime

            # Loop statement
            # divide r6 by r4, if remainder is 0 number is not prime
            MOV r0, r6
            MOV r1, r4
            BL __aeabi_idiv // r0 now how the quotient
            MOV r5, r0 // Quotient

            # Problem is in Assembly we need to check remainder
            LDR r6, =num
            LDR r6, [r6] // Dividend
            MOV r4, r1 // Divisor
            MUL r5, r5, r4
            SUB r5, r6, r5
             
            # If statement
            CMP r5, #0
            BEQ notPrime
            ADD r4, r4, #1
            BL startPrimeLoop          
 
            isPrime:
                LDR r0, =primeMessage
                BL printf
                B startMainLoop
            notPrime:
                LDR r0, =notPrimeMessage
                BL printf
                B startMainLoop

        endPrimeLoop:                  

        errorMessage:
            LDR r0, =error
            BL printf
            B startMainLoop

    endMainLoop:
            LDR r0, =promptExit
            BL printf

    # Pop the stack 
    LDR lr, [sp, #0]
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    LDR r6, [sp, #12]
    LDR r7, [sp, #16]
    LDR r8, [sp, #20]
    ADD sp, sp, #24
    MOV pc, lr

.data
    # Prompt the user to enter integer or exit
    promptNumber: .asciz "\nEnter a positive integer (or -1 to exit): "
    promptExit:   .asciz "\nExiting the program.\n"
    # Tells the user the result
    error:        .asciz "\nThe number must be greater than 2."
    primeMessage: .asciz "\nPrime number"
    notPrimeMessage: .asciz "\nNot a prime number"
    # Takes the input values
    numFormat:    .asciz "%d"
    num:          .word 0   

# END MAIN
