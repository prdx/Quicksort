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

    space:      .char " "

.text
main:
  # printf("Initial array:\n")
  li    $v0, 4
  la    $a0, initial_array
  syscall

  li    $v0, 4
  la    $a0, names
  syscall


  # exit(0)
  li $v0, 10  # System call exit
  li $a0, 0   # Return 0
  syscall

print_array:
  # printf("[")
  li    $v0, 4
  la    $a0, open_bracket
  syscall

  # for(int i = 0, i < size, i++)
  print_loop:
    beq     $t0, $t1, end_loop

    # TODO: printf(" %s", a[i]);
    li $a0, " "
    li $v0, 11
    syscall

  end_loop:
  




			
	
