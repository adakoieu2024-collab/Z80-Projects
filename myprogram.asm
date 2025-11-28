; =======================================================
; Z80 Assembly Program: Sum of First N Integers
; File: integer_sum.asm
; Description: Calculates the sum of integers from 1 up to a hardcoded value N.
; The result is stored as a 16-bit value in memory.
; (Coded for a standard Z80 environment, e.g., CP/M or emulator starting at 0100h)
; =======================================================

ORG 0100h           ; Standard starting address

; --- Program Data and Variables ---
; We use memory addresses 8000h onwards for data storage
N_VALUE:    DB 0Ch      ; INPUT: The number N (0Ch = 12 decimal)
; (1 + 2 + ... + 12 = 78 decimal)
RESULT:     DW 0000h    ; OUTPUT: 16-bit location to store the final sum (78 = 004Eh)

; --- Main Program Execution ---
START:
; 1. Initialize 16-bit sum register (HL) to 0.
LD HL, 0000h        ; HL = Sum = 0

; 2. Load the input N from memory into register B (our 8-bit counter).
LD A, (N_VALUE)
LD B, A             ; B = N

; 3. Loop setup: We will sum B, decrement B, and repeat until B is zero.


LOOP_START:
; Check if counter B is zero.
LD A, B
OR A                ; Sets the Z flag if A (and thus B) is 0
JR Z, DONE          ; Jump if B = 0 (loop is finished)

; --- Summation Step (HL = HL + B) ---
; The ADD HL, reg_pair instruction requires a 16-bit register pair (DE)
; to hold the value being added. Since B is 8-bit, we treat it as 16-bit (00|B).

; a. Prepare DE register: D = 0, E = B
LD D, 00h           ; D (High Byte) = 0
LD E, B             ; E (Low Byte) = B (the current integer N)

; b. Perform 16-bit addition: HL = HL + DE
ADD HL, DE          ; HL = HL + (00h | B)

; c. Decrement the counter and loop.
DEC B               ; N = N - 1
JR LOOP_START       ; Jump back to the start of the loop


; --- Program Completion ---
DONE:
; 4. Store the final 16-bit result (HL) back into memory (RESULT).
; Z80 is Little-Endian: L-byte is stored first, H-byte second.
LD (RESULT), HL

; Halt the CPU/Return to Monitor (depending on the environment)
HALT


; --- End of Code ---
END START
