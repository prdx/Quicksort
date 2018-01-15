## Anak Agung Ngurah Bagus Trihatmaja -- Jan 11 2018
## quicksort.asm -- a program to sort array using quick sort algorithm
##
## Registers used:
##
##
##
##

.globl main

.data
      # const char * names[] = {"Joe", "Jenny", "Jill", "John",
      #                 "Jeff", "Joyce", "Jerry", "Janice",
      #                 "Jake", "Jonna", "Jack", "Jocelyn",
      #                 "Jessie", "Jess", "Janet", "Jane"};
        .align 5
      dataNames:
        .asciiz "Joe" 
        .align 5
        .asciiz "Jenny"
        .align 5
        .asciiz "Jill"
        .align 5
        .asciiz "John"
        .align 5
        .asciiz "Jeff"
        .align 5
        .asciiz "Joyce"
        .align 5
        .asciiz "Jerry"
        .align 5
        .asciiz "Janice"
        .align 5
        .asciiz "Jake"
        .align 5
        .asciiz "Jonna"
        .align 5
        .asciiz "Jack"
        .align 5
        .asciiz "Jocelyn"
        .align 5
        .asciiz "Jessie"
        .align 5
        .asciiz "Jess"
        .align 5
        .asciiz "Janet"
        .align 5
        .asciiz "Jane"
        .align 5
      
                   .align 2
      dataAddress: .space 64

        		
	# int size = 16;
	size: 		.word 16

    initial_array:      .asciiz "Initial array:\n"
    sorted_array:       .asciiz "Sorted array:\n"

    open_bracket:       .asciiz "["
    close_bracket:      .asciiz " ]\n"

    space:      .asciiz " "

.text
main:
  # printf("Initial array:\n")
  li    $v0, 4
  la    $a0, initial_array
  syscall

  # Build the array of address
  la    $t0, dataAddress
  la    $t1, dataNames
  li    $t2, 0
  li 	$t3, 16


  build_address:
  beq $t2, $t3, end_build_address
  sw $t1, ($t0)
  addi $t0, $t0, 4
  addi $t1, $t1, 32
  addi $t2, $t2, 1
  
  j build_address

  end_build_address:

  # print_array(data, size);
  la $a0, dataAddress
  la    $a1, size
  lw    $a1, 0($a1)
  
  addi $sp, $sp, -4 # Use stack
  sw $ra, 0($sp)
  jal print_array
  lw $ra, 0($sp)
  addi $sp, $sp, 4 # Return stack


  # exit(0)
  li $v0, 10  # System call exit
  li $a0, 0   # Return 0
  syscall

# int str_lt (const char *x, const char *y)
str_lt:
  move $t0, $a0 # Transfer the x from a0 to t0
  move $t1, $a1 # Transfer the y from a1 to t1
  

  # for (; *x!='\0' && *y!='\0'; x++, y++) {
  compare_loop:
    lb $t3, ($t0)
    lb $t4, ($t1)
    
    beq     $t3, $zero, end_compare_loop
    beq     $t4, $zero, end_compare_loop
    
    
    # if ( *x < *y ) return 1
    blt     $t3, $t4, return_1
    # if ( *y < *x ) return 0
    blt     $t4, $t3, return_0

    addi    $t0, $t0, 1
    addi    $t1, $t1, 1
    
    j compare_loop

  end_compare_loop:
    # if ( *y == '\0' ) return 0;
    beq     $t1, $zero, return_0
    # else return 1;
    beq     $t0, $zero, return_1

  return_1:
    li $v0, 1
    jr $ra

  return_0:
    li $v0, 0
    jr $ra


# void print_array(const char * a[], const int size)
print_array:
  move $t0, $a0 # Transfer the array to another register
  move $t1, $a1 # Transfer the array size to another register 

  # printf("[")
  li    $v0, 4
  la    $a0, open_bracket
  syscall

  # for(int i = 0, i < size, i++)
  li $t2, 0

  print_loop:
    beq     $t2, $t1, end_print_loop # If t2 == size end loop

    # printf(" %s", a[i]);
    la $a0, space
    li $v0, 4
    syscall
    

    la $a0, ($t0)
    lw $a0, ($a0) # Store the value of the pointed address
    li $v0, 4
    syscall

    addi    $t2, $t2, 1 # i++
    addi    $t0, $t0, 4 # Advance the array pointer

    j print_loop # Repeat
  

  end_print_loop:    
    # printf(" ]\n");
    li    $v0, 4
    la    $a0, close_bracket
    syscall

    li $v0, 0
    jr $ra
