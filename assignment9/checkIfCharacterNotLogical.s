# 
# Program Name: checkIfCharacterNotLogical.s
# Author: Olivia Blute
# Date: 10/23/2024
# Purpose: A program to check if a user input is a character or not
# Inputs: 
# - value: User input value to check
# Outputs:
# - validMessage: Tells user input is a valid char
# - invalidMessage: Tells user input is a invalid char
#
.text
.global main

main:
    # Push the stack
    SUB sp, sp, #4
    STR lr, [sp]

    # Prompt the user for input
    LDR r0, =prompt
    BL printf

    # Scan the user input
    LDR r0, =format
    LDR r1, =value
    BL scanf

    # Read the value from address
    LDR r0, =value
    LDR r0, [r0]

    # Branch to checkValue
    BL checkValue

    # Pop the stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Prompts the user for input
    prompt: .asciz "\nEnter the input value: "
    # Takes the user input value
    value: .word 0
    format: .asciz "%c"

# END Main

.text
checkValue:
    # Push the stack
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4] 

    # Move into r4 for safekeeping
    MOV r4, r0

    # Check for between A to Z
    MOV r0, #0
    CMP r4, #0x41 // A
    ADDGE r0, r0, #1   

    MOV r1, #0
    CMP r4, #0x5A // Z
    ADDLE r1, r1, #1
    
    AND r0, r0, r1
    CMP r0, #1 // this would mean its an uppercase char
    BNE checkLower
        B validCharacter

checkLower:
    # Check lowercase
    MOV r1, #0
    CMP r4, #0x61 // a
    ADDGE r1, r1, #1

    MOV r2, #0
    CMP r4, #0x7A // z
    ADDLE r2, r2, #1

    AND r1, r1, r2
    CMP r1, #1
    BNE invalidCharacter
        B validCharacter

validCharacter:
    LDR r0, =validMessage
    BL printf
    B end

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
