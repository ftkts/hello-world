# 
# Small hello-world for Linux 64 bit
# (C) @ftkts apr-28-2018
# 
# Generates a small executable.
# To start the generation, run 
#		./build
# then run
#		./hello
#
.globl _start
.text
entry_point = 0x400078
hello:
elf_header:
	.byte	0x7f, 0x45, 0x4c, 0x46, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word	2		# executable
	.word	0x3e		# amd64
	.long	1		# object file version
	.quad	entry_point	# entry point
	.quad	0x40		# program header offset
#	.quad	0		# sections header offset
#	.long	0		# specific flags
hello_msg:
	.ascii	"Hello world\n"
msg_len = . - hello_msg
	.word	0x40		# ELF header size
	.word	0x38		# size of program header entry
	.word	1		# number of program header entries
	.word	0, 0, 0		# no section headers
program_header:
	.long	1			# loadable segment
	.long	7			# RWX
	.quad	0			# offset in file
	.quad	0x400000		# virtual address
	.quad	0x400000		# reserved
	.quad	_start - hello_start	# size in file
	.quad	_start - hello_start	# size in memory
	.quad	0x200000		# alignment
hello_start:
	popq	%rax			# %rax = 1
	movl	%eax, %edi
a = hello_msg - hello_start + entry_point
	movl	$a, %esi
	movb	$msg_len, %dl
	syscall
	movb	$60, %al
	syscall
hello_len = . - hello
_start:
	movl	$1, %eax
	movl	$3, %edi
	movq	$hello, %rsi
	movl	$hello_len, %edx
	syscall
	movl	$60, %eax
	xorl	%edi, %edi
	syscall
