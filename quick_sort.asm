## Anak Agung Ngurah Bagus Trihatmaja -- Jan 11 2018
## quick_sort.asm -- a program to sort array using quick sort algorithm
##
## Input array:
## [ Joe Jenny Jill John Jeff Joyce Jerry Janice Jake Jonna Jack Jocelyn 
##   Jessie Jess Janet Jane ]
##
## Output array:
## [ Jack Jake Jane Janet Janice Jeff Jenny Jerry Jess Jessie Jill 
##   Jocelyn Joe John Jonna Joyce ]
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
  li $v0, 4
  la $a0, initial_array
  syscall

  # Build the array of address
  la $t0, dataAddress
  la $t1, dataNames
  li $t2, 0
  la $t3, size
  lw $t3, ($t3)


  build_address:
  beq $t2, $t3, end_build_address
  sw $t1, ($t0)
  addi $t0, $t0, 4
  addi $t1, $t1, 32
  addi $t2, $t2, 1
  
  j build_address

  end_build_address:

  ## DEBUG 
  # Prepare for swap function test
  la $a0, dataAddress
  # addi $a0, $a0, 4
  la    $a1, ($a0)
  
  addi $sp, $sp, -4     # Use stack
    sw $ra, 0($sp)
    jal str_lt 
    lw $ra, 0($sp)
    addi $sp, $sp, 4 
  
  # Test the swap fuction
  # addi $sp, $sp, -4 # Use stack
  # sw $ra, 0($sp)
  # jal swap_str_ptrs
  # lw $ra, 0($sp)
  # addi $sp, $sp, 4 # Return stack

  # print_array(data, size);
  la $a0, dataAddress
  la    $a1, size
  lw    $a1, 0($a1)

  addi $sp, $sp, -4 # Use stack
  sw $ra, 0($sp)
  jal print_array
  lw $ra, 0($sp)
  addi $sp, $sp, 4 # Return stack

  # quick_sort(data, size)
  la $a0, dataAddress
  la    $a1, size
  lw    $a1, 0($a1)
  
  addi $sp, $sp, -4 # Use stack
  sw $ra, 0($sp)
  jal quick_sort
  lw $ra, 0($sp)
  addi $sp, $sp, 4 # Return stack

  # printf("Sorted array:\n")
  li    $v0, 4
  la    $a0, sorted_array
  syscall
  
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

# -----------------------------------------------------------------
# int str_lt (const char *x, const char *y)
str_lt:
  lw $t0, ($a0) # Transfer the x from a0 to t0
  lw $t1, ($a1) # Transfer the y from a1 to t1
  

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

    addi    $t0, $t0, 1     #x++ 
    addi    $t1, $t1, 1     #y++
    
    j compare_loop

  end_compare_loop:
    # if ( *y == '\0' ) return 0;
    beq     $t4, $zero, return_0
    # else return 1;
    beq     $t3, $zero, return_1

  return_1:
    li $v0, 1
    jr $ra

  return_0:
    li $v0, 0
    jr $ra

# -----------------------------------------------------------------
# void swap_str_ptrs(const char **s1, const char **s2)
swap_str_ptrs:
  la $t1, ($a0)         # Store a0 in the temporary register
  lw $t1, ($t1)
  
  # const char *tmp = *s1;
  la $t0, ($a0)
  lw $t0, ($t0)
 
  # *s1 = *s2;
  la $t2, ($a1)         # Store a1 in the temporary register t2
  lw $t2, ($t2)
  sw $t2, ($a0)         # and then replace t1 by the content of t2

  # *s2 = tmp;
  sw $t0, ($a1)         # Replace t2 by the initial content of t1
  
  li $v0, 0
  jr $ra

# -----------------------------------------------------------------
# void quick_sort(const char *a[], size_t len) {
quick_sort:
  # Prepare stack
  subu $sp, $sp, 16
  sw $ra, ($sp)
  sw $s0, 4($sp)
  sw $s1, 8($sp)
  sw $s3, 12($sp)
  
  move $s0, $a0         # Transfer arrayAddress to t0 register
  move $s1, $a1         # Transfer size to t1 register

  # if (len <= 1) return;
  ble $s1, 1, return_quick_sort

  # int pivot = 0;
  li $s3, 0
  
  # for (int i = 0; i < len - 1; i++) {
  li $s4, 0             # i = 0
  subu $s5, $s1, 1      # len - 1

  quick_sort_loop:
    bgt $s4, $s5, quick_sort_loop_end       # if i >= len - 1, end loop

    # if (str_lt(a[i], a[len - 1])) {
    li $t0, 4
    multu $s4, $t0      # i * 4
    mflo $t1            # Store the i * 4 to $t1
    multu $s5, $t0      # (len - 1) * 4
    mflo $t2            # Store (len - 1) * 4 to $t2
    add $a0, $s0, $t1   # Advance the pointer
    add $a1, $s0, $t2   # Advance the pointer

    addi $sp, $sp, -4     # Use stack
    sw $ra, 0($sp)
    jal str_lt 
    lw $ra, 0($sp)
    addi $sp, $sp, 4      # Return stack

    beq $v0, 1, do_swap   # str_lt(&a[i], &a[len-1]) == 1

    addi $s4, $s4, 1      # i++
    j quick_sort_loop

    do_swap:
      li $t0, 4
      multu $s4, $t0      # i * 4
      mflo $t1            # Store the i * 4 to $t1
      multu $s3, $t0      # pivot * 4
      mflo $t2            # Store pivot * 4 to $t2
      add $a0, $s0, $t1   # Advance the pointer
      add $a1, $s0, $t2   # Advance the pointer
      
      # swap_str_ptrs(&a[i], &a[pivot]);
      addi $sp, $sp, -4     # Use stack
      sw $ra, 0($sp)
      jal swap_str_ptrs
      lw $ra, 0($sp)
      addi $sp, $sp, 4      # Return stack
      
      # pivot++;
      addi $s3, $s3, 1
      
  quick_sort_loop_end:
  # swap_str_ptrs(&a[pivot], &a[len - 1]);
  li $t0, 4             # Put constant in a register
  multu $s3, $t0        # Multiple pivot * 4
  mflo $s4              # Store pivot * 4 in t1
  subu $s5, $s1, 1      # len - 1 
  multu $s5, $t0        # Multiple len - 1 * 4
  mflo $s5              # Store (len - 1) * 4 in t2
  add $a0, $s0, $s4     # Advance the pointer of s0 + pivot * 4
  add $a1, $s0, $s5     # Advance the pointer of s0 + (len - 1) * 4

  addi $sp, $sp, -4     # Use stack
  sw $ra, 0($sp)
  jal swap_str_ptrs
  lw $ra, 0($sp)
  addi $sp, $sp, 4      # Return stack

  # quick_sort(a, pivot);
  move $a0, $s0         # Restore a0 with the initial array
  move $a1, $s3         # Transfer pivot as parameter
  jal quick_sort

  # quick_sort(a + pivot + 1, len - pivot - 1);
  li $t0, 4             # Put constant in a register
  multu $s3, $t0        # pivot * 4
  mflo $s4
  addi $s4, $s4, 4      # pivot + (1 * 4)
  add $a0, $a0, $s4     # a + (pivot + 1) * 4
  subu $a1, $s1, $s3    # len - pivot
  subu $a1, $a1, 1      # len - pivot - 1
  
  jal quick_sort 
  
  lw $ra, ($sp)
  lw $s0, 4($sp)
  lw $s1, 8($sp)
  lw $s3, 12($sp)
  addu $sp, $sp, 16
  jr $ra

  return_quick_sort:
    lw $ra, ($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s3, 12($sp)
    addu $sp, $sp, 16
    jr $ra

# -----------------------------------------------------------------
# void print_array(const char * a[], const int size)
print_array:
  move $t0, $a0     # Transfer the array to another register
  move $t1, $a1     # Transfer the array size to another register 

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
    lw $a0, ($a0)       # Store the value of the pointed address
    li $v0, 4
    syscall

    addi    $t2, $t2, 1 # i++
    addi    $t0, $t0, 4 # Advance the array pointer

    j print_loop        # Repeat
  
  end_print_loop:    
    # printf(" ]\n");
    li    $v0, 4
    la    $a0, close_bracket
    syscall

    li $v0, 0
    jr $ra
