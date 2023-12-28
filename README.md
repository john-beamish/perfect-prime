# perfect-prime
CDA 3100 Fall 2023 Assignment 4 Perfect Prime

Project description:

An integer value that evenly divides a larger integer value is often called a factor. A positive integer value that is greater than 1 is perfect if it is equal to the sum of its factors. For example, the number 6 has the factors 1, 2, and 3; 1+2+3=6. Therefore 6 is perfect. The number 10 has the factors 1, 2, and 5; 1+2+5=8. Therefore 10 is not perfect. Likewise, a number is prime if its only factor is 1.

Your assignment is to write a MIPS program that successfully executes on the QtSpim simulator that determines if numbers input by a user are perfect or prime. Your program should prompt the user, read an integer value, show the sum of the factors of the value that was read, and indicate whether or not the number is perfect. If it is not perfect, then you should also indicate whether or not it is prime. You should continue until a number less than 2 is entered. 

You are required to write a separate function to determine if one integer value is a factor of another integer value.

Call this function is_a_factor. This function will accept two integer arguments, where the first is the larger value (received through $a0) and the second is the potential factor (received through $a1). It returns a value (through $v0)

of one if the second value is a factor of the first value, and otherwise returns a value of zero.

You are also required to write a separate function that prints the factors of a integer value, where a ’+’ separates each preceding factor and the next factor. The factor list should be followed by an ’=’ and the sum of the factors. Call this function print_sum_of_factors. It accepts an integer argument (through $a0) and return the sum of the factors of the argument (through $v0).

The is_a_factor, print_sum_of_factors, and main functions should follow the MIPS calling conventions described in the lecture slides and videos in the module "FP Instructions and Functions". Note you should only use a syscall instruction to perform I/O and should not use it to exit the program.

Example:

Enter a value greater than 1: 4

1+2=3

The number 4 is not perfect.

Enter a value greater than 1: 6

1+2+3=6

The number 6 is perfect!

Enter a value greater than 1: 10

1+2+5=8

The number 10 is not perfect.

Enter a value greater than 1: 13

1=1

The number 13 is not perfect and prime.

Enter a value greater than 1: 0

Exiting program.
