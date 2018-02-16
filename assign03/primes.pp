(* This is my first Pascal program. *)
Program Hello;
var
	i : integer;

function isPrime(n : integer): boolean;
type
	primeArrType = array of boolean;
var   
	primeArr : primeArrType;
	i, k : integer;

begin
	setlength(primeArr, n + 1);
	for i:= 1 to n do primeArr[i] := true;
	for i:= 2 to n do 
	begin
		if (i * i <= n) then
			k := 2 * n;
			while k <= n do
			begin
				primeArr[k] := false;
				k := k + i;
			end;
	end;
	isPrime := primeArr[n];	
end;

begin
	for i:= 2 to 100 do 
	begin
		if isPrime(i) then
			write(i);
	end;
end.
