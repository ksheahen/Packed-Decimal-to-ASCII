; Chapter 7 Main Program
; Date: 4/17/2024

INCLUDE Irvine32.inc

.data
numbers DWORD 12345678h, 23456781h, 45678123h,78654321h, 56781234h
buffer BYTE 9 DUP(0)
count DWORD ?

.code
main PROC

	call PackedToAsc	;call PackedToAsc procedure

main ENDP

; PackedToAsc Procedure
PackedToAsc PROC

	mov esi,OFFSET numbers			;point to array
	mov count,LENGTHOF numbers		;set counter for outer loop (L1)

L1:	
	mov eax,[esi]			;move packed number to eax
	mov edx,OFFSET buffer	;point to buffer

	pushad				;pushes all registers
	mov ecx,8			;set counter for inner loop (L2)
L2:

	mov ebx,eax			;move eax to ebx
	and ebx,0F0000000h	;get 4 highest bits
	rol ebx,4			;rotate them to lowest bits

	or bl,30h			;convert to asc char
	mov [edx],bl		;move to buffer

	inc edx				;next byte in buffer
	shl eax,4			;shift eax by 4 to remove highest bits
	loop L2				
	
	popad				;pops all registers

	call WriteString	;displays asc string in console
	call Crlf			;new line

	add esi,TYPE numbers	;next value in array

	dec count			;decrease counter for outer loop
	cmp count,1
	JAE L1				;if counter>=1, continue loop
	JB quit				;if counter<1, exit program

quit:
	exit				;exit program

	ret
PackedToAsc ENDP
END main
