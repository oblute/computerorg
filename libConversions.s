#
# Program Name: libConversions.s
# Author: Olivia Blute
# Date: 10/17/2024
# Purpose: A library to store conversion functions
# system call (svc) from ARM assembly
# Functions: Miles2Kilometers, KPH, F2C, Ft2Inches
#
.global Ft2Inches
.global F2C
.global Miles2Kilometers
.global KPH

.text
Miles2Kilometers:
    # Push stack
    SUB sp, sp, #4
    STR lr, [sp]

    # r0 = r0 * 16/10
    # This operation is done to avoid floating point operations
    MOV r1, #16
    MUL r0, r0, r1  // Multiply by 16
    MOV r1, #10     // Divide by 10
    BL __aeabi_idiv

    # Pop stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
# END Miles2Kilometers

.text
KPH: 
    # Push the stack
    SUB sp, sp, #8
    STR lr, [sp]
    STR r4, [sp, #4]

    # Miles2Kilometers / hours
    MOV r4, r1 // Move hours into r4 for safekeeping
    BL Miles2Kilometers // Km result will be in r0
    MOV r1, r4 // Move hours to r1 for division
    BL __aeabi_idiv

    # Pop the stack
    LDR lr, [sp]
    LDR r4, [sp, #4]
    ADD sp, sp, #8
    MOV pc, lr
.data
# END KPH

.text
F2C:
    # Push stack
    SUB sp, sp, #4
    STR lr, [sp]

    # r0 = (r0-32)*5/9
    MOV r1, #32
    SUB r0, r0, r1
    MOV r1, #5
    MUL r0, r0, r1
    MOV r1, #9
    BL __aeabi_idiv

    # pop stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
#END F2C
 
.text
Ft2Inches:
    # Push stack
    SUB sp, sp, #4
    STR lr, [sp]

    # Convert feet to inches
    MOV r1, #12
    MUL r0, r0, r1

    # Pop the stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
#END Ft2Inches
