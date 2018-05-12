MODULE algorithm
    use parameters
    use special_type

    implicit none


    contains 

    subroutine delaunay(list_points2D, n_points2D)
        implicit none
        
        integer(kind=DP), intent(in) :: n_points2D
        type(POINT_2D), dimension(n_points2D), intent(in) :: list_points2D

        real(kind=DP) :: sweep_line_x, sl_dx

        ! sweep_line will move along the x-axis
        sweep_line_x = list_points2D(1)%x

        ! ninja sweep_line x offset 
        sl_dx = minval( (list_points2D(2:n_points2D)%x-list_points2D(1:n_points2D-1)%x), &
                        mask = (list_points2D(2:n_points2D)%x-list_points2D(1:n_points2D-1)%x) > 0.001_DP)

        write(*,*) "> DEBUG : "
        write(*,*) "        > sweep_line start @ ", sweep_line_x
        write(*,*) "        > sweep_line dx mov  ", sl_dx

    end subroutine delaunay

END MODULE algorithm
