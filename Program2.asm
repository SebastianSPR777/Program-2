;Program 2

;Sebastian Salvador 3/10 
;UT EID: sas7484

;The point of this lab is to sort a list in descending order of student test scores
;ranging from 0-100. Scores will be in bits [7:0] and bits [15:8]
;are zero. The list ends when bits [7:0] are -1 (or x00FF)
;lists starts at location given in x3200

.ORIG x3000	;code starts at x3000
LD R0, startlist	;Load destination of array into R0
LDR R0, R0, #0	;loads start destination of Array
ADD R1, R0, #0	;dest of score 1 in R1
LD R2, negonecheck	;loads negonecheck into R2
LDR R3, R1, #0	;loads score 1 into R3

;program for pointers

AND R6, R6, #0	;initializes pointer register 
BRZ firstnum

addpointer ADD R6, R6, #1
ADD R1, R1, #1
LDR R3, R1, #0

firstnum ADD R3, R3, #1
	AND R3, R3, R2

BRP addpointer

ADD R7, R6, #-1	;subcounter

;Sort algorythm 

nextsort ADD R1, R0, #0	;sets dest of first score again 
ADD R2, R0, #1	;sets dest of second score


keepsort LDR R3, R1, #0	;score1 to R3
LDR R4, R2, #0	;score 2 to R3
NOT R5, R4
ADD R5, R5, #1	;negative of score 2
ADD R5, R3, R5	;difference of scores
BRZP dontswap	;score1>score2

;if score1<score2, sort

STR R3, R2, #0	;puts score1 into dest of score2
STR R4, R1, #0	;puts score2 into dest of score1 

dontswap ADD R1, R1, #1	;dest1 incremented
ADD R2, R2, #1	;dest2 incremented
ADD R7, R7, #-1	;subcounter decreased
BRP keepsort

ADD R6, R6, #-1	;decreases count
ADD R7, R6, #-1	;subcount=count-1

BRZP nextsort


HALT

startlist .FILL x3200
negonecheck .FILL x00FF

.END
