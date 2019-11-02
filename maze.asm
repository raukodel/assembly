%include "utils.asm"
;EXTERN _printString
;EXTERN _printChar
;EXTERN _printNewLine
;EXTERN _exit

MAZE_WIDTH equ 15
MAZE_HEIGHT equ 15

section .data
	wall db 0x23
	floor db 0x22
	mazeFile db 'mazefile.txt' , 0
	instructionFile db 'instruction.txt'

section .bss
	
section .text
	global _start

_start:
	call _printNewLine

	mov rax , mazeFile
	call _readFile

	call _printWallFloor
	;call _printMaze
	;call _loopMazeHeight	

	mov rax , instructionFile
	call _readFile
	call _printString

	call _checkInput

	call _exit	

_checkInput:
	call _getInput

	mov cl , [rax]

	cmp cl , '9'
	jne	_start 

_printMaze:
	mov rax , fileData
	
	_loopMaze:
		push rax
		call _printChar
		pop rax
		inc rax 
		mov cl , [rax]
		cmp cl , 0
		jne _loopMaze

	ret


_printWallFloor:
	mov rax , fileData 
	
	_loopWallFloor:
		mov cl , [rax]
		inc rax
		push rax
		
		cmp cl , '9'
		je _end

		cmp cl , '1'
		je _wall
		
		cmp cl , '0'
		je _floor
		
		call _printNewLine
		pop rax	
		jmp _loopWallFloor		

		_wall:
			mov rax , wall
			call _printChar
			pop rax
			jmp _loopWallFloor

		_floor:
			mov rax , floor
			call _printChar
			pop rax
			jmp _loopWallFloor

		_end:
			pop rax
			ret

_loopMazeWidth:
	mov rcx , MAZE_WIDTH

	loopMazeWidth:
		push rcx
		mov rax , wall
		call _printChar
		
		pop rcx
		dec rcx
		cmp rcx , 0		
		jnz loopMazeWidth
	ret

_loopMazeHeight:
	mov rcx , MAZE_HEIGHT

	loopMazeHeight:
		push rcx
		mov rax , wall
		call _loopMazeWidth
		call _printNewLine

		pop rcx
		dec rcx
		cmp rcx , 0
		jnz loopMazeHeight

	ret