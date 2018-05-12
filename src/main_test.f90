PROGRAM main_test

    use io
    
    implicit none

    integer(kind=4) :: err
    character(len=1) :: yes_or_no

    integer(kind=DP) :: n_points2D_test, one=1
    type(POINT_2D), allocatable :: list_points2D_test(:)

    character(len=20) :: file_input='input/data_2D.dat'

    write(*,*)
    write(*,*) "Check stuff and subroutine"
    write(*,*)

    ! read namelist 
    write(*,*) "> Read namelist grid2d"
    call read_nml()

    ! display parameters 
    write(*,*)
    write(*,*) "> Parameters : "
    call display_nml()

    ! data point 2D read data
    write(*,*)
    write(*,*) "> Import data point ?"
    read(5,*) yes_or_no

    if( yes_or_no == 'y' .or. yes_or_no == 'Y') then
        call read_2d_data(file_input, list_points2D_test, n_points2D_test, err)
        if( err /= 0 ) then
            write(*,*) 
            write(*,*) "Error while reading file : input/data2D.dat"
            call exit(1)
        endif

        write(*,*) '> Data : '
        call write_2D_data(list_points2D_test, n_points2D_test)

        write(*,*)
        call quicksort(list_points2D_test, n_points2D_test)

        call write_2D_data(list_points2D_test, n_points2D_test)

    else
        write(*,*) ">> Implement, add subroutine to generate points on map ! "
    endif

    ! test of read
    
    ! test quicksort

END PROGRAM main_test

subroutine test_quicksort()

    implicit none

    integer, parameter :: n_numbers = 10
    integer :: st, en
    real(kind=8), dimension(n_numbers) :: random_numbers

    random_numbers(:) = 0.d0
    write(*,*)
    write(*,*) "---------- Test for quicksort algorithm ----------"
    write(*,*)

    write(*,'(a,$)') 'Init > '
    call write_tab(random_numbers(:), n_numbers)

    call init_tab(random_numbers(:), n_numbers)

    write(*,'(a,$)') 'Set > '
    call write_tab(random_numbers(:), n_numbers)

    write(*,'(a,$)') 'Sort > '
    st = 1
    en = n_numbers
    call quicksort(random_numbers(:), st, en)
    call write_tab(random_numbers(:), n_numbers)

end subroutine test_quicksort
