MODULE io

    use parameters
    use special_type
    use utils
    implicit none

    contains

    subroutine read_nml()
        read(5,nml=grid2d)
    end subroutine read_nml

    ! display namelist grid2d which contains boundaries of 
    ! space 
    subroutine display_nml()
        write(*,nml=grid2d)
    end subroutine display_nml

    ! read data file containing 2D data points
    !
    subroutine read_2d_data(filename, list_points2D, n_points2D, err_state)
        implicit none
    
        integer(kind=4), intent(out) :: err_state
        integer(kind=DP), intent(out) :: n_points2D
        type(POINT_2D), allocatable, dimension(:), intent(out) :: list_points2D

        character(len=*), intent(in) :: filename
        
        integer(kind=DP) :: i
        logical :: is_there

        inquire(file=trim(filename), exist=is_there)
        if( .not. is_there ) then
            write(*,*) "File ", trim(filename), " not found ! "
            err_state = 1
        else
            
            ! read data file and allocate size
            open(unit=1, file=trim(filename), action='read')
            
            read(1,*) n_points2D
            allocate(list_points2D(n_points2D))

            do i=1, n_points2D
                read (1,*) list_points2D(i)%x, list_points2D(i)%y
            enddo

            close(unit=1)

            err_state = 0
        endif
    end subroutine read_2d_data

    ! display points to stdout
    !
    subroutine write_2d_data(list_points2D, n_points2D)
        implicit none

        integer(kind=DP), intent(in) :: n_points2D
        type(POINT_2D), dimension(n_points2D), intent(in) :: list_points2D

        integer(kind=DP) :: i

        write(*,'(a)') 'Point x   Point y'
        do i=1, n_points2D
            write(*,'(2f8.4)') list_points2D(i)%x, list_points2D(i)%y
        enddo

    end subroutine write_2d_data

END MODULE io
