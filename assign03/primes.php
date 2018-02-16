<?php
/* This is my first PHP program. */

function isPrime($x){
	$primeArr = array();
	for ($i = 2; $i <= $x; $i++) {
		$primeArr[$i] = true;
	}
	for ($i = 2; $i * $i <= $x; $i++){
		if ($primeArr[$i] == true) {
			for ($k = $i * 2; $k <= $x; $k += $i){
				if ($k == $x) {
					return false;
				}
				$primeArr[$k] = false;
			}
		}
	}
	
	return $primeArr[$x];
}

for ($i = 2; $i <= 100; $i++) {
	if (isPrime($i)) {
		echo $i, " ";
	}
}
echo "\n";

?>
