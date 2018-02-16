! This my Fortran program
program PrimeTest
	implicit none
	integer			:: i
	logical			:: t

	do i=2,100
		if (isPrime(i)) then
			write(*, fmt="(i0, 1x) ", advance="no") i
		end if
	end do
	print *, " "
contains

function isPrime(n) result(j)
	implicit none
	integer, intent (in)  :: n 
	logical				  :: j
	logical, dimension(n) :: primeArr
	integer				  :: i
	integer				  :: k 

	do i=1,n
		primeArr(i) = .true.
	end do

	do i=2,n
		if (i**2 <= n) then
			if (primeArr(i)) then
				do k=2*i,n,i
					primeArr(k) = .false.
				end do
			end if 
		end if
	end do
	j = primeArr(n)
end function isPrime

end program PrimeTest
