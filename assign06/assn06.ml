(* Assignment 6 
 * Jin Pyo Jeon
 * *)
val input_list = [(#"E", 15), (#"T", 12), (#"A", 10), (#"O", 8), (#"R", 7), (#"N", 6), (#"S", 5), (#"U", 5), (#"I", 4), (#"D", 4), (#"M", 3), (#"C", 3), (#"G", 2), (#"K", 2)];

fun huffman nil = nil
  | huffman (l : (char * int) list)  = 
      let
        datatype Tree = Leef of int * char | Root of int * Tree * Tree; 

        fun print_tree t = 
            case t of 
                Leef (i, ch) => print("(" ^ Char.toString(ch) ^ " : " ^ Int.toString(i) ^ ") ") | 
                Root (i, _, _) => print("(Root: " ^  Int.toString(i) ^ ") ");

    
        fun get_freq (tree : Tree) = 
            case tree of 
                Leef (i, _) => i | 
                Root (i, _, _) => i;
        
        fun is_greater_freq (x, y) = get_freq(x) >= get_freq(y);
        
        val rec is_same_tree = 
            fn (Leef(i, ch_l), Leef(j, ch_r)) => i = j andalso ch_l = ch_r 
            |  (Root(i, ll, lr), Root(j, rl, rr)) => i = j andalso is_same_tree(ll, rl) andalso is_same_tree(lr, rr)
            |  (_, _) => false;

        fun return_smaller (a,b) = if is_greater_freq(a,b) then b else a;
        fun return_bigger(a,b) = if is_greater_freq(a,b) then a else b;

        fun get_min (l : Tree list) : (Tree * Tree list)= 
            let 
                fun get_min_h(x : Tree,  nil : Tree list, z : Tree list)  =  (x, z) 
                  | get_min_h(x,  y::ys, z)  =  get_min_h(return_smaller(x,y), ys, return_bigger(x,y)::z);

                val min_and_rest = get_min_h(hd(l), tl(l), nil)
            in
                min_and_rest
            end;

        fun get_two_min (l : Tree list) = 
            let 
                val first_min_removed = get_min(l);
                val first_min = #1 first_min_removed;
                val without_first = #2 first_min_removed;

                val second_min_removed = get_min(without_first);
                val second_min = #1 second_min_removed;
                val without_second = #2 second_min_removed;

            in 
                (first_min, second_min, without_second)
            end;

        fun combine_and_insert(l : Tree list) = 
            let 
                val first_second_rest = get_two_min(l);
                val first = #1 first_second_rest;
                val second = #2 first_second_rest;
                val rest = #3 first_second_rest;
                val combined_freq = get_freq(first) + get_freq(second);
                val combined = Root(combined_freq, first, second);
            in 
                combined::rest
            end;
        
        fun remove_from_list (_, nil) = nil 
          | remove_from_list (t, x::xs) = if is_same_tree(t, x) then remove_from_list(t, xs) 
                                          else x::remove_from_list(t, xs)

        val node_list = map (fn (ch, i) => Leef(i, ch)) l;
        
        val rec huffman_h = 
            fn (nil : Tree list) => nil
             | (x::nil) => [x]
             | (xs) => 
                let 
                    val reduced = combine_and_insert(xs);
                in 
                    huffman_h(reduced)
                end;

        fun pre_traversal t = 
            let 
                fun collapse l  = foldr (fn (x, a) => x :: a) [] l;

                fun pre_traversal_h (Leef(n, c), str) = [(c, str)]
                  | pre_traversal_h (Root(n, l, r), str) = collapse(pre_traversal_h(l, str ^ "0")) @ collapse(pre_traversal_h(r, str ^ "1"));
            in
                pre_traversal_h(t, "")
            end;

        val d = huffman_h(node_list);
        val h = pre_traversal(hd(d));
      in
        (* map (fn x => print_tree x) d *)
        map (fn (ch, str) => print(" ( " ^ Char.toString(ch) ^ " : " ^ str ^ ") ")) h
    
      end;

huffman input_list
