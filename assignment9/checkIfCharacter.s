# 
# Program Name: checkIfCharacterMain.s
# Author: Olivia Blute
# Date: 10/23/2024
# Purpose: A program to  check if a user input value is a character or not
# Inputs:
# - value: User input value to check.
# Outputs:
# - validMessage: Tells user input is valid character
# - invalidMessage: Tells use input is invalid character
#
.text
.global main

main:
    # Push the stack
    SUB sp, sp, #4
    STR lr, [sp]

    # Prompt the user for value
    LDR r0, =prompt
    BL printf

    # Load value from user
    LDR r0, =format
    LDR r1, =value
    BL scanf

    # Read value from address
    LDR r0, =value
    LDR r0, [r0]
    
    # Branch to checkValue function
    BL checkValue

    # Pop the stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Prompts the user for input value
    prompt: .asciz "\nEnter input value: "
    # Takes the user input value
    value: .word 0 // Storing character input
    format: .asciz "%c"

# END Main

.text
checkValue:
    # Push the stack
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]

    # Move value into r4 for safekeeping
    MOV r4, r0

    # Check if value is upper case character
    MOV r0, #0
    # First if (a >=0x41 and <= 0x5A), it's true
    CMP r4, #0x41 // A hex value
    ADDGE r0, r0, #1 // true if >=0x41
    MOV r1, #0
    CMP r4, #0x5A // Z hex value
    ADDLE r1, r1, #1 // true if <= 0x5A
    AND r0, r0, r1 // r0 now 1 if both true

    # Check if value is lower case character
    MOV r1, #0
    CMP r4, #0x61 // a hex value
    ADDGE r1, r1, #1
    MOV r2, #0
    CMP r4, #0x7A // z hex value
    ADDLE r2, r2, #1
    AND r1, r1, r2

    # Check if it's true on upper or lower
    ORR r0, r0, r1
    CMP r0, #1
    BNE invalidCharacter // branch to invalid if false
        LDR r0, =validMessage // otherwise print valid
        BL printf
        B end // branch to end
    
    # If character is invalid
    invalidCharacter:
        LDR r0, =invalidMessage
        BL printf
        B end

    end: // end the program

    # Pop the stack
    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

.data
    # Tells the user the result
    validMessage: .asciz "\nThis value is a character."
    invalidMessage: .asciz "\nThis value is not a character.\n"

# END checkValue
