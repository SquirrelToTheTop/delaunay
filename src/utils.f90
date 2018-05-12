MODULE utils

    use special_type
    use parameters

    implicit none

    contains

    ! Part of the quicksort algorithm : this part is used to find the correct position
    ! of the pivot =)
    !
    subroutine part(list_points2D, id_start, id_end, id_pivot, j)
        implicit none

        integer(kind=DP), intent(in) :: id_start, id_end, id_pivot
        integer(kind=DP), intent(out) :: j
        type(POINT_2D), dimension(*), intent(inout) :: list_points2D

        integer(kind=DP) :: i
        type(POINT_2D) :: tmp

        tmp = list_points2D(id_end)
        list_points2D(id_end) = list_points2D(id_pivot)
        list_points2D(id_pivot) = tmp

        j = id_start
        do i=id_start, id_end-1
            if( list_points2D(i)%x < list_points2D(id_pivot)%x ) then
                tmp = list_points2D(i)
                list_points2D(i) = list_points2D(j)
                list_points2D(j) = tmp
                j = j + 1
            else if( list_points2D(i)%x == list_points2D(id_pivot)%x ) then
                if( list_points2D(i)%y < list_points2D(id_pivot)%y) then
                    tmp = list_points2D(i)
                    list_points2D(i) = list_points2D(j)
                    list_points2D(j) = tmp
                    j = j + 1
                endif
            endif
        enddo

        ! put the pivot at his spot    
        tmp = list_points2D(j)
        list_points2D(j) = list_points2D(id_pivot)
        list_points2D(id_pivot) = tmp

    end subroutine part

    ! Quicksort algorithm ; the pivot is always the last of list_points2D
    !                       could be improved if pivot is the median value
    !
    recursive subroutine quicksort(list_points2D, id_start, id_end)
        implicit none

        integer(kind=DP), intent(in) :: id_start, id_end
        type(POINT_2D), dimension(*), intent(inout) :: list_points2D

        integer(kind=DP) :: id_pivot_correct
    
        if( id_start < id_end ) then
            call part(list_points2D, id_start, id_end, id_end, id_pivot_correct)
            call quicksort(list_points2D, id_start, id_pivot_correct-1)
            call quicksort(list_points2D, id_pivot_correct+1, id_end)
        endif

    end subroutine quicksort

    subroutine init_tab(tab, n)
        implicit none

        integer(kind=DP), intent(in) :: n
        real(kind=8), dimension(n), intent(out) :: tab

        call random_number(tab)

        tab(:) = tab(:)*10.d0

    end subroutine init_tab

    subroutine write_tab(tab, n)
        implicit none

        integer(kind=DP), intent(in):: n
        real(kind=DP), dimension(n), intent(in) :: tab

        integer(kind=DP) :: i
    
        do i=1, n
            write(*,'(f8.4,$)') tab(i)
        enddo
        write(*,*)

    end subroutine write_tab

    function is_sort(list_points2D, n_points2D)
        implicit none

        integer(kind=DP), intent(in) :: n_points2D
        type(POINT_2D), dimension(n_points2D), intent(in) :: list_points2D

        integer(kind=DP) :: i
        logical :: is_sort

        is_sort = .true.
        do i=1, n_points2D-1
            
            if( list_points2D(i+1)%x < list_points2D(i)%x ) then
                is_sort = .false.
                return
            elseif ( list_points2D(i+1)%x == list_points2D(i)%x .and. &
                     list_points2D(i+1)%y < list_points2D(i)%y ) then
                 is_sort = .false.
                 return
            endif

        enddo

    end function is_sort

END MODULE utils
