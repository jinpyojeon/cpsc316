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
	setLength(primeArr, n + 1);
	for i:= 0 to n do 
		primeArr[i] := true;
	for i:= 2 to n do 
	begin
		if (i * i <= n) then
		begin
			k := 2 * i;
			while k <= n do
			begin
				primeArr[k] := false;
				k := k + i;
			end;
		end;
	end;
	isPrime := primeArr[n];	
end;

begin
	for i:= 2 to 100 do 
	begin
		if isPrime(i) then
			write(i, ' ');
	end;
	writeln();
end.
