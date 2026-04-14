.section .data
file: .asciz "input.txt"
yes: .asciz "Yes\n"
no: .asciz "No\n"
.section .text
.globl main

main:
    li a7,56
    li a0,-100
    la a1,file
    li a2,0
    li a3,0
    ecall
    mv s0,a0

    li a7,62
    li a7,62
    mv a0,s0
    li a1,0
    li a2,2
    ecall
    mv s1,a0

    li t0,2
    blt s1,t0,pal
    li s2,0
    addi s3,s1,-1
loop:
    bge s2,s3,pal
    li a7,62
    mv a0,s0
    mv a1,s2
    li a2,0
    ecall
    addi sp,sp,-16
    li a7,63
    mv a0,s0
    mv a1,sp
    li a2,1
    ecall
    lb t1,0(sp)

    li a7,62
    mv a0,s0
    mv a1,s3
    li a2,0
    ecall
    li a7,63
    mv a0,s0
    mv a1,sp
    li a2,1
    ecall
    lb t2,0(sp)
    addi sp,sp,16
    bne t1,t2,not_pal
    addi s2,s2,1
    addi s3,s3,-1
    j loop
pal:
    la a0,yes
    j print
not_pal:
    la a0,no
print:
    mv s4,a0
    mv t0,s4
loop1:
    lb t1,0(t0)
    beqz t1,done 
    addi t0,t0,1
    j loop1
done:
    sub a2,t0,s4
    li a7,64
    li a0,1
    mv a1,s4
    ecall
exit:
    li a7,57
    mv a0,s0
    ecall
    li a7,93
    li a0,0
    ecall