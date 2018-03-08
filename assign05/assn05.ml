fun quicksort nil = nil
  | quicksort [x] = [x]
  | quicksort l  = 
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
        
        val x::xs = l 
        val (smaller, bigger) = pivotSplit (hd l, xs)
      in 
        quicksort(smaller)@[x]@quicksort(bigger)
      end;

quicksort([9 , 5234 ,2342, 1231 ,2343 ,2]); 

fun quicksort2 (nil, cmp : int * int -> bool) = nil
  | quicksort2 ([x], cmp) = [x]
  | quicksort2 (l, cmp) = 
      let
        fun pivotSplit (p : int, c : int * int -> bool , nil : int list) = (nil, nil) 
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

quicksort2([9, 5234, 2342, 1231, 2343, 2], Int.>);

fun member (e, nil) = false
  | member (e, [x]) = if e = x then true else false
  | member (e, l) = if e = hd(l) then true else member (e, tl(l));

member(3, [2,1, 3]);
