PROGRAM main

    use utils
    use io
    
    implicit none

    integer(kind=4) :: err
    character(len=1) :: yes_or_no

    integer(kind=DP) :: n_points2D, one=1
    type(POINT_2D), allocatable :: list_points2D(:)

    character(len=20) :: file_input='input/data_2D.dat'

    write(*,*) 
    write(*,*) "Funny de Delaunay and cie project "
    write(*,*)

    ! read namelist 
    write(*,'(a,$)') "> Read namelist grid2d ... "
    call read_nml()
    write(*,'(a)') "success"

    ! data point 2D read data
    read(5,*) yes_or_no

    if( yes_or_no == 'y' .or. yes_or_no == 'Y') then
        write(*,'(a,$)') '> Read data points 2D ... '
        call read_2d_data(file_input, list_points2D, n_points2D, err)
        if( err /= 0 ) then
            write(*,*) 
            write(*,*) "Error while reading file : input/data2D.dat"
            call exit(1)
        endif
        write(*,'(a)') 'Success !' 

        write(*,*)
        write(*,'(a,$)') '> Sort data lexicographicaly ... '
        call quicksort(list_points2D, one, n_points2D) 

        if( is_sort(list_points2D, n_points2D) ) then
            write(*,'(a)') 'Success !'
        else
            write(*,'(a)') 'Failed !'
            stop 1
        endif

    else
        write(*,*) ">> TODO : generate point in space cartesian space !"
        write(*,*) ">> TODO : generate point from picture ! "
    endif

    ! free mem
    deallocate(list_points2D)

END PROGRAM main
