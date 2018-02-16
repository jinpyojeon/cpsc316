# This is my first Perl program. 
sub isPrime {
	$n = scalar(@_[0]);
	@primeArr = ();
	for ($i = 0; $i <= $n; $i++) {
		push(@primeArr, 1);
	}
	for ($i = 2; $i * $i <= $n; $i++) {
		if (@primeArr[$i] == 1) {
			for ($k = $i * 2; $k <= $n; $k = $k + $i) {
				@primeArr[$k] = 0;
			}
		}
	}
	return @primeArr[$n];
}

for ($l = 2; $l <= 100; $l++) {
	if (isPrime($l) == 1) {
		print $l, " ";
	}
}
print "\n";
