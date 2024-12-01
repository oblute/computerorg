#
# Program Name: final.s
# Author:       Olivia Blute
# Date:         12/1/2024
# Purpose:      To to read integer values from a user until a "-1" is entered, 
#               and then print out the number of values entered, the total of all the value,#               and the average of the values.
# Inputs:
# - num: User input
# Outputs:
# - values: Number of values entered
# - total: Total of values
# - average: Average of the values
#
.text
.global main
main:
    # Program dictionary
    # r4 - loop counter
    # r5 - loop limit
    # r6 - total of all values

    # Push the stack
    SUB sp, sp, #28
    STR lr, [sp, #0]
    STR r4, [sp, #4]
    STR r5, [sp, #8]
    STR r6, [sp, #12]
    STR r7, [sp, #16]
    STR r8, [sp, #20]
    STR r9, [sp, #24]

    # Psuedo-code in Java
# public class FinalProgram {
#    public static void main(String[] args) {
#       // Initialize
#        Scanner scanner = new Scanner(System.in);
#
#        int count = 0;  // To count the number of valid inputs
#        int total = 0;  // To store the sum of all entered values
#        int value;       // To hold the user's input
#
#        System.out.println("Enter values (enter -1 to stop):");
#
#        // Loop to read user input until -1 is entered
#        while (true) {
#            value = scanner.nextInt();  // Read the next integer
#
#            // If the value is -1, break out of the loop
#            if (value == -1) {
#                break;
#            }
#
#            count++;        // Increment the count for each valid input
#            total += value; // Add the current value to the total sum
#        }
#
#        // After the loop ends, print the results
#        if (count > 0) {
#            double average = (double) total / count;  // Calculate the average
#            System.out.println("Number of values entered: " + count);
#            System.out.println("Total of values: " + total);
#            System.out.println("Average of values: " + average);
#        } else {
#            System.out.println("No values were entered.");
#        }
#
#        scanner.close();  // Close the scanner to prevent memory leaks
#    }
#}
    
    # Sentinel loop
    # Initialize 
    LDR r0, =promptNum
    BL printf
    LDR r0, =numFormat
    LDR r1, =num
    BL scanf

    MOV r4, #1  // Counter initialized to 1
    MOV r5, #-1 // Loop limit initialized to -1
    MOV r6, #0

    # Start label
    startLoop:
        LDR r1, =num
        LDR r1, [r1]

        # Condition check
        CMP r1, r5
        BEQ endLoop // If r1 is -1 end it 

        # Statement or block to execute
        ADD r6, r6, r1
        MOV r1, r4
        LDR r0, =numValues
        BL printf

        ADD r4, r4, #1
            
        # Get next value
        LDR r0, =promptNum
        BL printf
        LDR r0, =numFormat
        LDR r1, =num
        BL scanf
        B startLoop

    endLoop:

    LDR r0, =total
    MOV r1, r6
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
    promptNum:      .asciz "\nEnter a value (-1 to exit): "
    # Takes the input values
    numFormat:      .asciz "%d"
    num:            .word 0
    # Tells the user results
    numValues:      .asciz "\nThe total values entered is %d.\n"
    total:          .asciz "\nThe sum total of the values entered is %d.\n"
    inputs:         .word 0
    average:        .asciz "\nThe average of the values is %d.\n"
    averageNum:        .word 0
