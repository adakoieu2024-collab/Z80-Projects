; =======================================================
; Z80 Assembly Program: Sum of First N Integers
; File: integer_sum_clean.asm
; Description: Calculates the sum of integers from 1 up to a hardcoded value N.
; The result is stored as a 16-bit value in memory.
;
; *** SYNTAX NOTE: Uses '$' prefix for hexadecimal numbers, required by z80asm. ***
; =======================================================

ORG $8000           ; Program starts at memory address $8000 (Standard load address)

; --- Program Data and Variables ---
; Define data and variables at a higher memory address
N_VALUE:    DB $0C          ; INPUT: The number N (0C hex = 12 decimal)
                            ; (1 + 2 + ... + 12 = 78 decimal = $4E hex)
RESULT:     DW $0000        ; OUTPUT: 16-bit location to store the final sum

; --- Main Program Execution ---
START:
; 1. Initialize 16-bit sum register (HL) to 0.
LD HL, $0000            ; HL = Sum = 0

; 2. Load the input N from memory into register B (our 8-bit counter).
LD A, (N_VALUE)         ; Load N into A
LD B, A                 ; B = N

; 3. Loop setup: We will sum B, decrement B, and repeat until B is zero.
LOOP_START:
; Check if counter B is zero.
LD A, B
OR A                    ; Sets the Z flag if A (and thus B) is 0
JR Z, DONE              ; Jump if B = 0 (loop is finished)

; --- Summation Step (HL = HL + B) ---
; Since ADD HL, reg_pair needs a 16-bit source, we use DE for the value 'B' (00|B).

; a. Prepare DE register: D = 0, E = B
LD D, $00               ; D (High Byte) = 0
LD E, B                 ; E (Low Byte) = B (the current integer N)

; b. Perform 16-bit addition: HL = HL + DE
ADD HL, DE              ; HL = HL + B

; c. Decrement the counter and loop.
DEC B                   ; N = N - 1
JR LOOP_START           ; Jump back to the start of the loop


; --- Program Completion ---
DONE:
; 4. Store the final 16-bit result (HL) back into memory (RESULT).
LD (RESULT), HL         ; Z80 stores in Little-Endian: L byte first, H byte second.

; Halt the CPU
HALT

; --- Data/Variable Addresses ---
ORG $9000
N_VALUE:    EQU $9000
RESULT:     EQU $9001

; --- End of Code ---
END START
