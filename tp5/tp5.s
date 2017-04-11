	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 12
	.globl	_Decryption_fct
	.p2align	4, 0x90
_Decryption_fct:                        ## @Decryption_fct
## BB#0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	andl	$-16777216, %eax        ## imm = 0xFF000000
	movl	-4(%ebp), %ecx
	andl	$255, %ecx
	shll	$16, %ecx
	orl	%ecx, %eax
	movl	-4(%ebp), %ecx
	andl	$65280, %ecx            ## imm = 0xFF00
	orl	%ecx, %eax
	movl	-4(%ebp), %ecx
	andl	$16711680, %ecx         ## imm = 0xFF0000
	shrl	$16, %ecx
	orl	%ecx, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	addl	$8, %esp
	popl	%ebp
	retl

	.globl	_main
	.p2align	4, 0x90
_main:                                  ## @main
## BB#0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	calll	L1$pb
L1$pb:
	popl	%eax
	movl	$0, -4(%ebp)
	movl	$-290800641, -8(%ebp)   ## imm = 0xEEAABBFF
	movl	-8(%ebp), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, (%esp)
	movl	%eax, -12(%ebp)         ## 4-byte Spill
	movl	%ecx, -16(%ebp)         ## 4-byte Spill
	calll	_Decryption_fct
	movl	-12(%ebp), %ecx         ## 4-byte Reload
	leal	L_.str-L1$pb(%ecx), %edx
	movl	%edx, (%esp)
	movl	-16(%ebp), %edx         ## 4-byte Reload
	movl	%edx, 4(%esp)
	movl	%eax, 8(%esp)
	calll	_printf
	xorl	%ecx, %ecx
	movl	%eax, -20(%ebp)         ## 4-byte Spill
	movl	%ecx, %eax
	addl	$40, %esp
	popl	%ebp
	retl

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Repr\303\251sentation crypte en little-endian:   %08x\nRepr\303\251sentation decrypte en big-endian:    %08x\n"


.subsections_via_symbols
