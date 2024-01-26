       CSECT
       USING *,15

       STM   14,12,12(13)
       LR    12,15
       LA    15,SAVEAREA
       ST    15,8(13)
       ST    13,4(15)
       ST    15,12(13)

       L     R1,MATRIX_A     ; Load address of matrix A into R1
       L     R2,MATRIX_B     ; Load address of vector b into R2
       L     R3,MATRIX_SIZE  ; Load size of the matrix into R3

       LA    R4,1            ; Set loop counter to 1

LOOP   L     R5,R4,MATRIX_A  ; Load current element of matrix A into R5
       ST    R5,ELEMENT_A    ; Store it in ELEMENT_A

       L     R5,R4,MATRIX_B  ; Load current element of vector b into R5
       ST    R5,ELEMENT_B    ; Store it in ELEMENT_B

       CALL  GAUSSIAN_ELIM   ; Call Gaussian elimination subroutine

       LA    R4,1,R4          ; Increment loop counter
       C     R4,R3            ; Compare loop counter with matrix size
       BL    LOOP             ; Branch back to LOOP if not finished

       B     END

GAUSSIAN_ELIM EQU   *
       L     R6,ELEMENT_B    ; Load current element of vector b into R6
       L     R7,ELEMENT_A    ; Load current element of matrix A into R7
       D     R7,R5            ; Subtract R5 (pivot element) from R7
       D     R7,R6            ; Divide result by R6 (pivot element)
       ST    R7,RESULT_X     ; Store result in RESULT_X
       B     0(15)

RESULT_X DC    F'0'

MATRIX_A DC    F'2.0', F'1.0', F'3.0'  ; Example square matrix A
         DC    F'4.0', F'2.0', F'6.0'
         DC    F'1.0', F'1.0', F'2.0'

MATRIX_B DC    F'8.0', F'18.0', F'5.0'  ; Example vector b
MATRIX_SIZE DC F'3'                   ; Size of the square matrix

ELEMENT_A DS   F
ELEMENT_B DS   F

SAVEAREA DS    18F
       END
