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
	filename db 'myfile.txt' , 0

section .bss
	
section .text
	global _start

_start:
	mov rax , filename
	call _readFile

	call _printWallFloor
	;call _printMaze
	;call _loopMazeHeight	
		
	call _exit	

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
	inc rax
	mov cl , [rax]
	cmp cl , '0'
	je _floor

	_wall:
		mov rax , wall
		call _printChar
		ret

	_floor:
		mov rax , floor
		call _printChar
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
