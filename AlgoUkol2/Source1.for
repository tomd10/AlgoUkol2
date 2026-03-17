      PROGRAM MAIN
      IMPLICIT NONE
      
      INTEGER, ALLOCATABLE :: MATRIX(:,:)
      INTEGER :: R = 5, S = 5
      
      
      INTEGER :: R1, R2, S1, S2, SUM
      
      ALLOCATE(MATRIX(R, S))
      PRINT*, '------ZADANI------'
      CALL FILL_MATRIX(MATRIX, R, S, -5, 5)
      CALL PRINT_MATRIX(MATRIX, R, S, 1, R, 1, S)
      CALL SUM_MATRIX(MATRIX, R, S, 1, R, 1, S, SUM)
      PRINT*, SUM
C     PRINT*, ARR
      
C     TEST ALGORITMU 1
      PRINT*, '------ALGORITMUS 1------'
      CALL ALGO1(MATRIX, R, S, R1, R2, S1, S2, SUM)
      CALL PRINT_MATRIX(MATRIX, R, S, R1, R2, S1, S2)
      PRINT*, SUM
      
C     TEST ALGORITMU 2
      PRINT*, '------ALGORITMUS 2------'
      CALL ALGO2(MATRIX, R, S, R1, R2, S1, S2, SUM)
      CALL PRINT_MATRIX(MATRIX, R, S, R1, R2, S1, S2)
      PRINT*, SUM    
C     TEST ALGORITMU 3
      PRINT*, '------ALGORITMUS 3------'
      CALL ALGO3(MATRIX, R, S, R1, R2, S1, S2, SUM)
      CALL PRINT_MATRIX(MATRIX, R, S, R1, R2, S1, S2)
      PRINT*, SUM      
      PAUSE
      
      CONTAINS
      
C
C     ALGORITMUS 1 - HRUBA SILA
C 
      SUBROUTINE ALGO1(MATRIX, R, S, R1, R2, S1, S2, SUM)
          INTEGER, INTENT(IN) :: R, S, MATRIX(R,S)
          INTEGER, INTENT(OUT) :: R1, R2, S1, S2, SUM
          
          INTEGER :: I, J, K, L, TEMP_SUM, TEMP_MAX
          TEMP_MAX = MATRIX(1, 1)
          
C         PRO VSECHNY RADKY, KDE MUZE PODMATICE ZACIT...
          DO I = 1, R
C         PRO VSECHNY SLOUPCE, KDE MUZE PODMATICE ZACIT...
          DO J = 1, S
C         PRO VSECHNY RADKY, KDE MUZE PODMATICE KONCIT...
          DO K = I, R
C         PRO VSECHNY SLOUPCE, KDE MUZE PODMATICE KONCIT...
          DO L = J, S
C             PRINT *, 'TEST: ', I, K, J, L
              CALL SUM_MATRIX(MATRIX, R, S, I, K, J, L, TEMP_SUM)
              IF (TEMP_SUM > TEMP_MAX) THEN
                  TEMP_MAX = TEMP_SUM
                  SUM = TEMP_SUM
                  R1 = I
                  R2 = K
                  S1 = J
                  S2 = L
              END IF
          END DO
          END DO
          END DO
          END DO
          END SUBROUTINE ALGO1

C
C     ALGORITMUS 2 - PREFIXOVE SOUCTY RADKU
C
      SUBROUTINE ALGO2(MATRIX, R, S, R1, R2, S1, S2, SUM)
          INTEGER, INTENT(IN) :: R, S, MATRIX(R,S)
          INTEGER, INTENT(OUT) :: R1, R2, S1, S2, SUM
          
          INTEGER :: I, J, K, L, TEMP_SUM, TEMP_MAX
          INTEGER :: LINE_PREFIX(R, S)
          
C         PREDPOCET PREFIXOVYCH SOUCTU RADKU
          DO I = 1, R
              LINE_PREFIX(I, 1) = MATRIX(I, 1)
              DO J = 2, S
                  LINE_PREFIX(I, J) = LINE_PREFIX(I, J-1) + MATRIX(I, J)
              END DO
          END DO

C         PRO VSECHNY RADKY, KDE MUZE PODMATICE ZACIT...
          DO I = 1, R
C         PRO VSECHNY SLOUPCE, KDE MUZE PODMATICE ZACIT...
          DO J = 1, S
C         PRO VSECHNY RADKY, KDE MUZE PODMATICE KONCIT...
          DO K = I, R
C         PRO VSECHNY SLOUPCE, KDE MUZE PODMATICE KONCIT...
          DO L = J, S
C             PRINT *, 'TEST: ', I, K, J, L
              CALL SUM_PREFIX(LINE_PREFIX, R, S, I, K, J, L, TEMP_SUM)
              IF (TEMP_SUM > TEMP_MAX) THEN
                  TEMP_MAX = TEMP_SUM
                  SUM = TEMP_SUM
                  R1 = I
                  R2 = K
                  S1 = J
                  S2 = L
              END IF
          END DO
          END DO
          END DO
          END DO
      END SUBROUTINE ALGO2

C
C     ALGORITMUS 3 - KADANE
C 
      SUBROUTINE ALGO3(MATRIX, R, S, R1, R2, S1, S2, SUM)
          INTEGER, INTENT(IN) :: R, S
          INTEGER, INTENT(IN) :: MATRIX(R,S)
          INTEGER, INTENT(OUT) :: R1, R2, S1, S2, SUM    

          INTEGER :: TEMP(R)
          INTEGER :: LEFT, RIGHT, I
          INTEGER :: CUR_SUM
          INTEGER :: TOP, BOTTOM

          SUM = MATRIX(1,1)
          R1 = 1
          R2 = 1
          S1 = 1
          S2 = 1

          DO LEFT = 1, S
              TEMP = 0
              DO RIGHT = LEFT, S
                  DO I = 1, R
                      TEMP(I) = TEMP(I) + MATRIX(I, RIGHT)
                  END DO

                  CALL MAX_SUBARRAY(TEMP, R, CUR_SUM, TOP, BOTTOM)

                  IF (CUR_SUM > SUM) THEN
                      SUM = CUR_SUM
                      R1 = TOP
                      R2 = BOTTOM
                      S1 = LEFT
                      S2 = RIGHT
                  END IF
              END DO
          END DO

      END SUBROUTINE ALGO3
      
C
C     MAXIMALNI PODPOLE
C
      SUBROUTINE MAX_SUBARRAY(ARRAY, N, MAX_SUM, START, FINISH)
          INTEGER, INTENT(IN) :: N, ARRAY(N)
          INTEGER, INTENT(OUT) :: MAX_SUM, START, FINISH
          
          INTEGER :: CUR_SUM, START_TEMP, I, LEFT, RIGHT
          
          CUR_SUM = ARRAY(1)
          MAX_SUM = ARRAY(1)
          
          START_TEMP = 1
          LEFT = 1
          RIGHT = 1
          
          DO I = 2, N
              IF (CUR_SUM < 0) THEN
                  CUR_SUM = ARRAY(I)
                  START_TEMP = I
              ELSE
                  CUR_SUM = CUR_SUM + ARRAY(I)
              END IF
              
              IF (CUR_SUM > MAX_SUM) THEN
                  MAX_SUM = CUR_SUM
                  START = START_TEMP
                  FINISH = I
              END IF
          END DO
          RETURN
      END SUBROUTINE MAX_SUBARRAY

C
C     SOUCET PRVKU PODMATICE POMOCI PREFIXOVYCH SOUCTU RADKU
C
      SUBROUTINE SUM_PREFIX(LINE_PREFIX, R, S, R1, R2, S1, S2, SUM)
          INTEGER, INTENT(IN) :: R, S, LINE_PREFIX(R,S)
          INTEGER, INTENT(IN) :: R1, R2, S1, S2
          INTEGER, INTENT(OUT) :: SUM
          INTEGER :: I, J
          
          SUM = 0
          DO I = R1, R2
              IF (S1 > 1) THEN
                  SUM = SUM + LINE_PREFIX(I, S2)-LINE_PREFIX(I, S1 - 1)
              ELSE
                  SUM = SUM + LINE_PREFIX(I, S2)
              END IF
          END DO
      END SUBROUTINE SUM_PREFIX
          
C
C     SOUCET PRVKU (POD)MATICE
C 
      SUBROUTINE SUM_MATRIX(MATRIX, R, S, R1, R2, S1, S2, SUM)
          INTEGER, INTENT(IN) :: R, S, MATRIX(R,S)
          INTEGER, INTENT(IN) :: R1, R2, S1, S2
          INTEGER, INTENT(OUT) :: SUM
          INTEGER :: I, J
          
          SUM = 0
      DO I = R1, R2
          DO J = S1, S2
              SUM = SUM + MATRIX(I, J)
          END DO
      END DO
      END SUBROUTINE SUM_MATRIX
      
C
C     VYGENEROVANI MATICE
C      
      SUBROUTINE FILL_MATRIX(MATRIX, R, S, MIN, MAX)
          INTEGER, INTENT(IN) ::  R, S, MIN, MAX
          INTEGER, INTENT(INOUT) :: MATRIX(R, S)
          DOUBLE PRECISION :: RND
          INTEGER :: I, J
          
          CALL RANDOM_SEED()
          DO I = 1, R
              DO J = 1, S
                  CALL RANDOM_NUMBER(RND)
                  MATRIX(I,J) = MIN + INT(RND * (MAX - MIN + 1))
              END DO
          END DO
          RETURN
      END SUBROUTINE FILL_MATRIX
C
C     VYPIS MATICE
C  
      SUBROUTINE PRINT_MATRIX(MATRIX, R, S, R1, R2, S1, S2)
          INTEGER, INTENT(IN) :: R, S, MATRIX(R, S)
          INTEGER, INTENT(IN) :: R1, R2, S1, S2
          INTEGER :: I
          
          DO I = R1, R2
              PRINT*, MATRIX(I, S1:S2)
          END DO
      END SUBROUTINE PRINT_MATRIX
      END PROGRAM MAIN