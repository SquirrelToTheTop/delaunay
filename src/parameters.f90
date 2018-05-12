MODULE parameters
    
    implicit none
    
    integer, parameter :: DP=kind(0.d0)
    real(kind=DP) :: xmin, ymin, xmax, ymax

    namelist /grid2d/ xmin, ymin, xmax, ymax

END MODULE parameters
