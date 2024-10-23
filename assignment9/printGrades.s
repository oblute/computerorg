#
# Program Name: printGrades.s
# Author: Olivia Blute
# Date: 10/23/2024
# Purpose: A program to print a user's average grade
# Inputs:
# - name: User input name
# - grade: User input grade (int)
# Outputs:
# - nameOutput: User name
# - grade_A: User avg grade
# - grade_B: User avg grade
# - grade_C: User avg grade
# - grade_F: User avg grade
#
.text
.global main

main:
    # Push the stack
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]

    # Prompt for and read name
    LDR r0, =prompt1
    BL printf
    LDR r0, =format1
    LDR r1, =name
    BL scanf

    # Prompt for and read average
    LDR r0, =prompt2
    BL printf
    LDR r0, =format2
    LDR r1, =grade
    BL scanf
    LDR r1, =grade
    LDR r1, [r1]

    # Branch to calcGrade function
    BL calcGrade

    # Pop the stack
    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

.data
    # Prompts the user for name
    prompt1: .asciz "\nPlease enter your name: "
    # Takes user input value
    format1: .asciz "%s"
    # Prompts the user for grade
    prompt2: .asciz "\nEnter an average grade 0-100: "
    # Takes the user input value
    format2: .asciz "%d"
    name: .space 40
    grade: .word 0

# END main

.text
calcGrade:
    # Push the stack
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]
    
    # Makesure grade is between 0 and 100
    MOV r3, r1
    MOV r0, #0
    CMP r3, #0
    ADDGE r0, r0, #1 // True if grade >=0
    MOV r1, #0
    CMP r3, #100
    ADDLE r1, r1, #1 // True if grade <= 100
    AND r0, r0, r1 
    CMP r0, #1

    # Branch to ErrorMsg if grade isn't between 0-100
    BNE ErrorMsg
        # Else...
        LDR r0, =nameOutput
        LDR r1, =name
        BL printf
        # If 90-100
        MOV r0, #0
        CMP r3, #90
        ADDGE r0, r0, #1
        CMP r0, #1
        BEQ gradeAMessage

        # If 80-90
        MOV r0, #0
        CMP r3, #80
        ADDGE r0, r0, #1
        MOV r1, #0
        CMP r3, #90
        ADDLT r1, r1, #1
        AND r0, r0, r1
        CMP r0, #1
        BEQ gradeBMessage

        # If 70-80
        MOV r0, #0
        CMP r3, #70
        ADDGE r0, r0, #1
        MOV r1, #0
        CMP r3, #80
        ADDLT r1, r1, #1
        AND r0, r0, r1
        CMP r0, #1
        BEQ gradeCMessage

        # Else
        LDR r0, =grade_F
        BL printf
        B End

    # Message to return for gradeA
    gradeAMessage:
        LDR r0, =grade_A
        BL printf
        B End

    # Message if grade B
    gradeBMessage:
        LDR r0, =grade_B
        BL printf
        B End

    # Message if grade C  
    gradeCMessage:
        LDR r0, =grade_C
        BL printf
        B End

    ErrorMsg:
        LDR r0, =error
        BL printf

    End: // end program

    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr

.data
    # Tells the user there was an error
    error: .asciz "\nGrade must be between 0-100"
    # Prints the name and grades
    nameOutput: .asciz "Name is: %s\n"
    grade_A: .asciz "Grade is a A\n"
    grade_B: .asciz "Grade is a B\n"
    grade_C: .asciz "Grade is a C\n"
    grade_F: .asciz "Grade is a F\n"

# END calcGrade
