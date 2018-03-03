-- This is my first Ada program.
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Primes is

	function isPrime(Val: INTEGER) return BOOLEAN is
		type PrimeArrType is array(Positive range <>) of aliased BOOLEAN;
		PrimeArr : PrimeArrType (2..Val);
		K : INTEGER;
	begin
		for E of PrimeArr loop
			E := TRUE;
		end loop;

		for I in INTEGER range 2..Val loop
			if I * I <= Val then
				if PrimeArr(I) then
					K := I * 2;
					while K <= Val loop
						PrimeArr(K) := FALSE;
						K := K + I;
					end loop;
				end if;
			end if;
		end loop;

		return PrimeArr(Val);
	end isPrime;

begin
	for N in 2..100 loop
		if isPrime(N) then
			Put(Integer'Image(N));
		end if;
	end loop;
end Primes;
