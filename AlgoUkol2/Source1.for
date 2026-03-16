      PROGRAM MAIN
      IMPLICIT NONE
      
      INTEGER, ALLOCATABLE :: MATRIX(:,:)
      INTEGER :: R = 3, S = 3
      
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
C     TEST ALGORITMU 2
      PRINT*, '------ALGORITMUS 2------'
      
C     TEST ALGORITMU 3
      PRINT*, '------ALGORITMUS 3------'
      PAUSE
      
      CONTAINS
      
C
C     SOUCET PRVKU (POD)MATICE
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
              PRINT *, 'TEST: ', I, K, J, L
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