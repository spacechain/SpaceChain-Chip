	.file	"get_lock_cpu0_stub.c" 
        /* modify manually get_lock_cpu0_stub.s -> get_lock_cpu0.s */
	.text
	.text
	.align 1
	.global	get_lock_cpu0
	.type	get_lock_cpu0, @function
get_lock_cpu0:
	mov.l	r14,@-r15
	add	#-8,r15
	mov	r15,r14
	mov	r14,r1
	add	#-56,r1
	mov.l	.L4,r2
	mov.l	r2,@(60,r1)
	mov	r14,r1
	add	#-56,r1
	mov.l	.L5,r2
	mov.l	r2,@(56,r1)
.L1001:
	mov	r14,r1
	add	#-56,r1
	mov.l	@(60,r1),r1
	tas.b	@r1  /* original C load.b */
	bf	.L1001
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
.L1002:
	mov	#0,r1  /* return(0) */
	mov	r1,r0  /* return(0) */
	add	#8,r14  /* stack pointer */
	mov	r14,r15
	mov.l	@r15+,r14
	rts	
	nop
.L6:
	.align 2
.L4:
	.long	33024  /* 33024 (dec) = 0x8100, adrs of lock var */
.L5:
	.long	335564796  /* 335564796 (dec) = 0x14004ffc */
	.size	get_lock_cpu0, .-get_lock_cpu0
	.ident	"GCC: (Sourcery G++ Lite 2011.03-36 for SEI by OZH) 4.5.2"
