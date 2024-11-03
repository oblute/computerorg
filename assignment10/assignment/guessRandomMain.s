#
# Program Name: guessMaxNumberMain.s
# Author:       Olivia Blute
# Date:         11/2/2024
# Purpose:      To guess the random number generated by the computer
# Inputs:
# - num: Maximum number for the random number
# - num: Seed for random number generator
# - num: Random number guess
# Outputs:
# - If the guess is too low, too high, or correct
# - The number of guesses
#
.text
.global main
main:

    # Program dictionary
    # r4 - counter for the guessMaxNumber loop
    # r5 - the limit for the grade loop -- is this the random number?
    # r6 - the input number
    # r7 - the max for random

    # Push the stack
    SUB sp, sp, #28
    STR lr, [sp, #0]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    STR r6, [sp, #12]
    STR r7, [sp, #16]
    STR r8, [sp, #20]
    STR r9, [sp, #24]

    # The sentinel loop
    startGuessNumberLoop:
        # Prompt for max number
        LDR r0, =promptMax
        BL printf
        LDR r0, =numFormat
        LDR r1, =num
        BL scanf
        LDR r1, =num
        LDR r1, [r1]
        MOV r7, r1 // This is the limit for the random number

        # Prompt for the seed
        LDR r0, =promptSeed
        BL printf
        LDR r0, =numFormat
        LDR r1, =num
        BL scanf

        # Set seed for random number
        LDR r0, =num
        LDR r0, [r0]
        BL setSeed // Branch to setSeet

        # Set the random number
        BL randFunc // Branch to randFunc

        # Initialize the counter loop
        MOV r4, #0 // Counter
        MOV r5, r0 // r0 has the random number out of randFunc
        MOV r6, #0 // Initialize input to 0

        startDetermineIfMaxLoop:
            # Start the program by reading in the guess
            LDR r0, =promptNum
            BL printf
            LDR r0, =numFormat
            LDR r1, =num
            BL scanf
            LDR r1, =num
            LDR r1, [r1]
            MOV r6, r1 // Move guess to r6

            CMP r5, r6 // Compare the random number and guess
               BEQ endGuessNumberLoop // If equal, end!

            CMP r6, r5
            BGT tooHigh
                BLT tooLow

            tooHigh:
                LDR r0, =tooHighMessage
                BL printf
                ADD r4, r4, #1
                B startDetermineIfMaxLoop

            tooLow:
                LDR r0, =tooLowMessage
                BL printf
                ADD r4, r4, #1
                B startDetermineIfMaxLoop

    endGuessNumberLoop:
        # Print correct message
        LDR r0, =correctMessage
        LDR r1, =numFormat
        MOV r1, r6
        BL printf

    # Print total number of guesses
    LDR r0, =totalGuesses
    LDR r1, =numFormat
    MOV r1, r4
    BL printf

    # Pop the stack
    LDR lr, [sp, #0]
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    LDR r6, [sp, #12]
    LDR r7, [sp, #16]
    LDR r8, [sp, #20]
    LDR r9, [sp, #24]
    ADD sp, sp, #28
    MOV pc, lr

.data
    # Prompts the user for values
    promptMax:        .asciz "\nEnter the maximum value for the random number: "
    promptNum:         .asciz "\nEnter your guess for the random value: "
    promptSeed:       .asciz "\nEnter the seed: "
    # Takes the input values
    numFormat:      .asciz "%d"
    num:          .word 0
    # Tells the user results
    tooHighMessage: .asciz "\nToo high."
    tooLowMessage:  .asciz "\nToo low."
    guesses:        .word 0
    correctMessage: .asciz "\nThe number %d is the correct number."
    totalGuesses:   .asciz "\nThis took %d guesses.\n"

.text
# Function:     setSeed
# Author:       Charles Kann
# Date:         7/31/2020
# Purposee:     Set a seed for the randFunc
# Input:        r0: seed
# Output:       none
# Side effects: Seed is set
setSeed:
     # Push the stack
     SUB sp, sp, #4
     STR lr, [sp]
     
     BL srand // r0 has the seed

     # Pop the stack
     LDR lr, [sp]
     ADD sp, sp, #4
     MOV pc, lr

.text
# Function:     setSeed
# Author:       Charles Kann
# Date:         7/31/2020
# Purpose:      To retrieve a random number from 0..r7
randFunc:
     SUB sp, sp, #8
     STR lr, [sp]
     STR r4, [sp, #4]

     #Get the random number, setting the limit using a modulus operation
     BL rand
     MOV r4, r0   	// Save the random number
     # Modulus operation
     MOV r1, r7
     BL __aeabi_idiv
     MOV r1, r7
     MUL r0, r0, r1
     SUB r0, r4, r0

     LDR lr, [sp]
     LDR r4, [sp, #4]
     ADD sp, sp, #8
     MOV pc, lr
