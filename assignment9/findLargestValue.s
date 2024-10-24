#
# Program Name: findLargestValue.s
# Author: Olivia Blute
# Date: 10/23/2024
# Purpose: Finds the largest of 3 input values
# Inputs:
# - num1: First number
# - num2: Second number
# - num3: Third number
# Outputs:
# - output: The maximum value
#
.text
.global main

main:
    #Push stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    # Prompt & load for integers
    # First
    LDR r0, =prompt1
    BL printf
    LDR r0, =format1
    LDR r1, =num1
    BL scanf

    # Second
    LDR r0, =prompt2
    BL printf
    LDR r0, =format1
    LDR r1, =num2
    BL scanf

    # Third
    LDR r0, =prompt3
    BL printf
    LDR r0, =format1
    LDR r1, =num3
    BL scanf
    
    # Branch to findMaxVal
    BL findMaxValue

    # Pop stack
    LDR lr, [sp, #0]
    ADD sp, sp, #4
    MOV pc, lr

.data
    # Prompts the user to enter integers
    prompt1: .asciz "\nEnter 1st integer: "
    prompt2: .asciz "\nEnter 2nd integer: "
    prompt3: .asciz "\nEnter 3rd integer: "
    # Takes the input values
    format1: .asciz "%d"
    num1: .word 0
    num2: .word 0
    num3: .word 0

# END MAIN

.text
findMaxValue:
    # Push the stack
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]
    
    # Read in values for loaded values
    LDR r1, =num1
    LDR r1, [r1]
    LDR r2, =num2
    LDR r2, [r2]
    LDR r3, =num3
    LDR r3, [r3]

    # Numbers are in r1, r2, and r3
    CMP r1, r2
    BGT compareWithVal3 // if r1 > r2, check r3
    MOV r1, r2 // if r2 > r1, store as max
    BGT end_find_max

compareWithVal3:
    CMP r1, r3 // if r1 > r3, end program
    BGT end_find_max
    MOV r1, r3 // if r3 > r1, it's max

# End the program
end_find_max:
    LDR r0, =output
    BL printf

    # Pop the stack
    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

.data
# Tells the user the max value
maxNum: .word 0
output: .asciz "\nThe maximum value is %d\n"

# END findMaxValue
