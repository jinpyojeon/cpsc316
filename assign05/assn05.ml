(* Jin Pyo Jeon - Assignment 5 *)

fun quicksort nil = nil
  | quicksort [x] = [x]
  | quicksort  l  = 
      let
        fun pivotSplit (p : int, nil) = (nil, nil) 
          | pivotSplit (p, [y]) = 
              if y < p then ([y], nil) else (nil, [y])
          | pivotSplit (p, y::ys) = 
              let 
                val listPair = pivotSplit (p, ys)
                val left = #1 listPair
                val right = #2 listPair
              in 
                if y < p then (y::left, right) else (left, y::right)
              end; 
        
        val x = hd l
        val (smaller, bigger) = pivotSplit (hd l, tl l)
      in 
        quicksort(smaller)@[x]@quicksort(bigger)
      end;

quicksort([9 , 5234 ,2342, 1231 ,2343 ,2]) = [2, 9, 1231, 2342, 2343, 5234]; 
quicksort([]) = [];
quicksort([1,2]) = [1,2];
quicksort([~1,6,7, ~4]) = [~4,~1,6,7];
quicksort([5, 5, 6, 5, 5]) = [5, 5, 5, 5, 6];

fun quicksort2 (nil : 'a list , cmp : 'a * 'a -> bool ) = nil
  | quicksort2 ([x], cmp) = [x]
  | quicksort2 (l, cmp) = 
      let
        fun pivotSplit (p : 'a,  c : 'a * 'a -> bool , nil) = (nil, nil) 
          | pivotSplit (p, c, [y]) = 
              if c (y, p) then ([y], nil) else (nil, [y])
          | pivotSplit (p, c, y::ys) = 
              let 
                val listPair = pivotSplit (p, c, ys)
                val left = #1 listPair
                val right = #2 listPair
              in 
                if c (y, p) then (y::left, right) else (left, y::right)
              end; 
        
        val x::xs = l 
        val f = cmp
        val (smaller, bigger) = pivotSplit (hd l, cmp, xs)
      in 
        quicksort2(smaller, f) @ [x] @ quicksort2(bigger, f)
      end;

quicksort2([9, 5234, 2342, 1231, 2343, 2], Int.>) = [5234, 2343, 2342, 1231, 9, 2];
quicksort2([9 , 5234 ,2342, 1231 ,2343 ,2], Int.<) = [2, 9, 1231, 2342, 2343, 5234]; 
quicksort2([], Int.<) = [];
quicksort2([1,2], Int.<) = [1,2];
quicksort2([1,2], Int.>) = [2,1];
quicksort2([~1,6,7, ~4], Int.<) = [~4,~1,6,7];
quicksort2([~1,6,7, ~4], Int.>) = [7,6,~1,~4];
quicksort2([5, 5, 6, 5, 5], Int.<) = [5, 5, 5, 5, 6];
quicksort2(["i", "for", "one", "welcome", "our", "robot", "overlords"], String.<) = ["for", "i" , "one", "our", "overlords", "robot", "welcome"]; 

fun member (e, nil) = false
  | member (e, [x]) = if e = x then true else false
  | member (e, l) = if e = hd(l) then true else member (e, tl(l));

member(3, [2,1, 3]) = true;
member(3, []) = false;
member(0, [2,1,3]) = false;

fun union (nil, nil) = nil 
  | union (xl, nil) = xl
  | union (nil, yl) = yl
  | union (x::xs, y::ys) = 
      if member (y, x::xs) then union(x::xs, ys) else union(x::y::xs, ys);

union([2,1,3], [4,3]) = [2,4,1,3];
union([], [4,3]) = [4,3];
union([4], [4, 4, 4]) = [4];

fun difference (nil, nil) = nil 
  | difference (xl, nil)  = xl
  | difference (nil, yl)  = nil
  | difference (x::xs, yl) = 
      if member (x, yl) then difference(xs, yl) else x::difference(xs, yl);

difference([2,1,3], [4,3]) = [2,1];
difference([2,1], [4,3]) = [2,1];
difference([], [4,3]) = [];
difference([2,1,3], [2,1,3]) = [];
difference([4, 1], [2,7,8]) = [4,1];

fun intersection (nil, nil) = nil
  | intersection (xl, nil) = nil
  | intersection (nil, yl) = nil
  | intersection (x::xs, yl) = 
      if member (x, yl) then x::intersection(xs, difference(yl, [x])) else
          intersection(xs, yl);

intersection([2,1,3], [4,3]) = [3];
intersection([2,1,3], [2,1]) = [2,1];
intersection([2,1], [3]) = [];
intersection([1,2,3], [5,6,7]) = [];
intersection([], []) = [];

fun powerset nil = [[]]
  | powerset l = 
    let
        val prev_powerset = powerset(tl l)
        val prev_powerset_with = map (fn x => hd l::x) prev_powerset;
    in
      union(prev_powerset, prev_powerset_with)
    end;

powerset([1,2,3]);
powerset([1,2]);
powerset(nil : int list);
powerset(["hello", "there"]);
