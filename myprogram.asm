; Z80 ASSEMBLY PROGRAM
; Filename: BLOCK_COPY_INVERT.ASM
; Functionality: Copies a 10-byte block from SOURCE_ADDR to DEST_ADDR.
;                Each byte is bitwise-inverted (NOT) during the copy.

ORG 8000H         ; Program starts at memory address 8000h

; --- DATA DEFINITION ---
SOURCE_ADDR EQU 9000H  ; Start of the 10-byte source data block
DEST_ADDR   EQU 9100H  ; Start of the destination memory area
BLOCK_SIZE  EQU 0AH    ; The size of the block to copy (10 bytes)

; --- MAIN PROGRAM START ---
MAIN:
    ; 1. INITIALIZE POINTERS AND COUNTER
    LD HL, SOURCE_ADDR  ; Load source address (9000h) into the HL pointer
    LD DE, DEST_ADDR    ; Load destination address (9100h) into the DE pointer
    LD BC, BLOCK_SIZE   ; Load the block size (10) into the BC counter

    ; 2. THE COPY/INVERT LOOP
COPY_LOOP:
    ; 2.1. READ BYTE
    LD A, (HL)          ; Load the byte from memory pointed to by HL into the Accumulator (A)

    ; 2.2. INVERT BITS
    CPL                 ; Complement (invert) the bits in the Accumulator (A = NOT A)

    ; 2.3. WRITE BYTE
    LD (DE), A          ; Store the inverted byte from A into the memory location pointed to by DE

    ; 2.4. UPDATE POINTERS
    INC HL              ; Increment the source pointer (HL = HL + 1)
    INC DE              ; Increment the destination pointer (DE = DE + 1)

    ; 2.5. DECREMENT COUNTER AND CHECK
    DEC BC              ; Decrement the byte counter (BC = BC - 1)
    LD A, C             ; Load the low byte of the counter into A
    OR B                ; OR A with the high byte of the counter (B).
    JR NZ, COPY_LOOP    ; Jump back to COPY_LOOP if BC is NOT Zero

    ; 3. HALT EXECUTION
    HALT              ; Stop the CPU

; --- SOURCE DATA BLOCK ---
ORG SOURCE_ADDR       ; Define data starting at 9000h
DATA_BLOCK:
    DB 0FFH, 00H, 11H, 22H, 33H, 44H, 55H, 66H, 77H, 88H 
    ; 10 bytes of initial data

END ; End of source file
