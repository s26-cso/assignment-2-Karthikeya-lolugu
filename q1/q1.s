.text
.globl make_node
.globl insert
.globl get
.globl getAtMost
make_node:
    addi sp,sp,-16
    sd ra,8(sp)
    sw a0,0(sp)
    li a0,24
    call malloc
    mv t0,a0
    lw t1,0(sp)
    sw t1,0(t0)
    sd x0,8(t0)
    sd x0,16(t0)
    ld ra,8(sp)
    addi sp,sp,16
    ret
insert:
    addi sp,sp,-32
    sd ra,24(sp)
    sd a0,0(sp)
    sw a1,8(sp)
    beq a0,x0,insert_null_root  #if root==NULL
    lw t0,0(a0)
    blt a1,t0,insert_left
    ld t1,16(a0)
    mv a0,t1
    lw a1,8(sp)
    call insert
    ld t2,0(sp)
    sd a0,16(t2)
    mv a0,t2
    ld ra,24(sp)
    addi sp,sp,32
    ret
insert_null_root:
    lw a0,8(sp)
    call make_node
    ld ra,24(sp)
    addi sp,sp,32
    ret
insert_left:
    ld t1,8(a0)
    mv a0,t1
    lw a1,8(sp)
    call insert
    ld t2,0(sp)
    sd a0,8(t2)
    mv a0,t2
    ld ra,24(sp)
    addi sp,sp,32
    ret
get:
    beq a0,x0,get_root_null
    lw t0,0(a0)
    beq t0,a1,get_return
    blt a1,t0,get_left
    ld a0,16(a0)
    j get
get_return:
    ret
get_left:
    ld a0,8(a0)
    j get
get_root_null:
    li a0,0
    ret
getAtMost:
    li t0,-1
loop:
    beq a1,x0,done
    lw t1,0(a1)
    bgt t1,a0,getat_left
    mv t0,t1
    ld a1,16(a1)
    j loop
getat_left:
    ld a1,8(a1)
    j loop
done:
    mv a0,t0
    ret
    