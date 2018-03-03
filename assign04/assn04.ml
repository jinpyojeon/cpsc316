(* Jin Pyo Jeon - Assignment 4 *)

fun cycle ([], i : int) = []
  | cycle (L, 0) = L
  | cycle (L, i) = cycle(tl(L)@[hd(L)], i - 1);

  cycle([1, 2, 3, 4], 1) = [2,3,4,1];
  cycle([1, 2, 3, 4], 2) = [3,4,1,2];
  cycle([1, 2, 3, 4], 3) = [4,1,2,3];
  cycle([1], 4) = [1];
  cycle([1,2], 0) = [1,2];
  cycle([1,2], 4) = [1,2];
  cycle([], 5) = [];

fun dup [] = []
  | dup L = hd(L)::hd(L)::dup(tl(L));

  dup([1,2,3]) = [1,1,2,2,3,3];
  dup([1,2]) = [1,1,2,2];
  dup([]) = [];
  dup([2,4,5,6]) = [2,2,4,4,5,5,6,6];
  dup([1,1,1]) = [1,1,1,1,1,1];

fun removei ([], _) = []
  | removei (L, 1)  = tl(L)
  | removei (L, i)  = hd(L)::removei(tl(L), i-1);

  removei([1,2,3,4,5], 4) = [1,2,3,5];
  removei([1,2,3,4,5], 3) = [1,2,4,5];
  removei([1,2], 1) = [2];
  removei([1,2], 3) = [1,2];
  removei([], 3) = [];

exception InvalidArg;

fun safedot ([], []) = 0.0
  | safedot (x, nil) = raise InvalidArg
  | safedot (nil, y) = raise InvalidArg
  | safedot (x::nil, y::nil) = x * y
  | safedot (x::xs, y::ys) = x * y + safedot(xs, ys);

fun dot(L, M) = safedot(L,M)
handle InvalidArg => (print "Invalid Arg for dot product \n";  0.0);

  Real.==(32.0, dot([1.0, 2.0, 3.0], [4.0, 5.0, 6.0]));

  Real.==(0.0, dot([1.0, 2.0, 3.0], [4.0, 5.0]));
  Real.==(74.0, dot([7.0, 5.0], [7.0, 5.0]));
  Real.==(25.0, dot([5.0], [5.0]));
  Real.==(0.0, dot([], []));

fun isstri (x : real, y : real, z : real) =  
    if List.all (fn (x)=> Real.>(x, 0.0)) [x,y,z]
        then 
            if x + y > z orelse y + z > x orelse z + x > y 
                then true 
            else false
        else false;

    isstri(3.0,4.0,5.0) = true;
    isstri(8.0, 15.0, 17.0) = true;
    isstri(0.0, 0.0, 0.0) = false;
    isstri(8.0, 8.0, 8.0) = true;
    isstri(Real.~ 9.0, 5.0, 4.0) = false;
    isstri(0.0, 90.0, 90.0) = false;
    isstri(4.0, 4.0, 9.0) = true;
