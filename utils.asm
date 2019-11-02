STDIN equ 0
STDOUT equ 1
STDERR equ 2

SYS_READ equ 0
SYS_WRITE equ 1
SYS_OPEN equ 2
SYS_CLOSE equ 3
SYS_EXIT equ 60

section .data
	newLine db 10

section .bss
	input resb 16
	fileData resb 10

section .text

;global printString
;global printChar
;global printNewLine
;global getInput
;global exit

;Before call this subroutine mov rax , stringToPrint
;This subroutine counts the letters and set rbx to tne number
;so when we call print we set rdx as the number of letters
_printString:
	push rax
	mov rbx , 0
	
	_printLoop:
		inc rax
		inc rbx
		mov cl , [rax]
		cmp cl , 0
		jne _printLoop
	
	pop rax
	call _print

	ret

;Before call this subroutine mov rax , charToPrint
_printChar:
	mov rbx , 1
	call _print

	ret

_printNewLine:
	mov rbx , 1
	mov rax , newLine
	call _print
	
	ret

;INTERNAL Set rbx for the size
_print:
	push rax
	mov rax , STDOUT
	mov rdi , 1
	pop rsi
	mov rdx , rbx
	mov rbx , 0
	syscall

	ret
	
;Register rax will have the data
_getInput:
	mov rax , STDIN
	mov rdi , 0
	mov rsi , input
	mov rdx , 16
	syscall

	mov rax , input
	ret

;Set rax with the file name and fileData will have the data from the file	
_readFile:
	mov rdi , rax	
	mov rax , SYS_OPEN 		
	mov rsi , 0
	mov rdx , 0
	syscall

	push rax
	mov rdi , rax
	mov rax , SYS_READ
	mov rsi , fileData
	mov rdx , 300
	syscall

	mov rax , SYS_CLOSE
	pop rdi 
	syscall
	
	mov rax , fileData

	ret	

_exit:
	mov rax , SYS_EXIT
	xor rdi , rdi
	syscall
