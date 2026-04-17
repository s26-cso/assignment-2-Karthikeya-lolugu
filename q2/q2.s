.data
fmt: .asciz "%d "
fm: .asciz "%d"
new: .asciz "\n"
.text
.globl main
.extern atoi
.extern printf
.extern malloc
.extern free
main:
    addi sp,sp,-64
    sd ra,56(sp)
    sd s0,48(sp)
    sd s1,40(sp)
    sd s2,32(sp)
    sd s3,24(sp)
    sd s4,16(sp)
    sd s5,8(sp)
    sd s6,0(sp)

    addi s3,a0,-1
    mv s4,a1        #argv
    li s5,-1        #top

    slli a0,s3,2
    call malloc
    mv s0,a0      #arr
    slli a0,s3,2
    call malloc
    mv s1,a0      #ans
    slli a0,s3,2
    call malloc
    mv s2,a0      #st

    li s6,0
loop1:
    bge s6,s3,done1
    addi t0,s6,1
    slli t0,t0,3
    add t0,s4,t0
    ld a0,0(t0)
    call atoi

    slli t1,s6,2
    add t2,s0,t1
    sw a0,0(t2)
    add t2,s1,t1
    li t3,-1
    sw t3,0(t2)
    addi s6,s6,1
    j loop1
done1:
    li s6,0
loop:
    bge s6,s3,completed
loop2:
    blt s5,x0,push
    slli t1,s5,2
    add t1,s2,t1
    lw t0,0(t1)
    slli t2,t0,2
    add t2,s0,t2
    lw t1,0(t2)
    slli t3,s6,2
    add t3,s0,t3
    lw t2,0(t3)

    bge t1,t2,push
    slli t3,t0,2
    add t3,s1,t3
    sw s6,0(t3)
    
    addi s5,s5,-1
    j loop2
push:
    addi s5,s5,1
    slli t0,s5,2
    add t0,s2,t0
    sw s6,0(t0)
    addi s6,s6,1
    j loop
completed:
    li s6,0
print:
    bge s6,s3,exit
    addi t1,s3,-1
    be s6,t1,ex
    la a0,fmt
    slli t0,s6,2
    add t0,s1,t0
    lw a1,0(t0)
    call printf
    
    addi s6,s6,1
    j print
ex:
    la a0,fm
    slli t0,s6,2
    add t0,s1,t0
    lw a1,0(t0)
    call printf
exit:
    la a0,new
    call printf
    #free
    mv a0,s0
    call free
    mv a0,s1
    call free
    mv a0,s2
    call free

    ld ra,56(sp)
    ld s0,48(sp)
    ld s1,40(sp)
    ld s2,32(sp)
    ld s3,24(sp)
    ld s4,16(sp)
    ld s5,8(sp)
    ld s6,0(sp)
    addi sp,sp,64
    ret
