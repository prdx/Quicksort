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
      names:
        .align 5
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

  # print_array(data, size);
  la $a0, names
  la    $a1, size
  lw    $a1, 0($a1)
  
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  jal print_array
  lw $ra, 0($sp)
  addi $sp, $sp, 4


  # exit(0)
  li $v0, 10  # System call exit
  li $a0, 0   # Return 0
  syscall

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
    beq     $t2, $t1, end_loop # If t2 == size end loop

    # printf(" %s", a[i]);
    la $a0, space
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 4
    syscall

    addi    $t2, $t2, 1 # i++
    addi    $t0, $t0, 32 # Advance the array pointer

    j print_loop # Repeat
  

  end_loop:    
    # printf(" ]\n");
    li    $v0, 4
    la    $a0, close_bracket
    syscall

    li $v0, 0
    jr $ra
