(*
    Ramneek Chhatwal
    ECE 3520
    SDE 2
*)

(*
first_duplicate of a list returns -10000 if there are no duplicates in the integer list argument. Otherwise the first item that occurs more than once (duplicate) in the integer list is returned.

Function signature: val first_duplicate : int list -> int = <fun>
*)
let rec first_duplicate = function(list) ->
    (*checking to see if list is empty*)
    if list = [] then
        -10000
    else
        (*if head of the list is the same as the tail, return the head of the list*)
        if List.mem(List.hd list)(List.tl list) then 
            (List.hd list)

        (*otherwise sent the tail of the list recursively into the function*)
        else
            first_duplicate(List.tl list);;

(*
first_nonrepeating of a list returns -10000 if there are no non-repeated (non-duplicated) element in the list. Otherwise it returns the first non-repeating element in the integer list.

Function signature: val first_nonrepeating : int list -> int = <fun>
*)
let rec nonrepeating_helper list duplicate_list =
    (*checking to see if list is empty*)
    if list = [] then
        -10000
    else
        (*if head of the list is the same as the tail or head of the list is in the duplicate list, send the tail of the list and appended duplicate list in the function recursively*)
        if List.mem(List.hd list)(List.tl list) || List.mem(List.hd list)(duplicate_list) then
            nonrepeating_helper(List.tl list)(List.hd list::duplicate_list)
        
        (*otherwise return the head of the list*)
        else
            (List.hd list);;

let rec first_nonrepeating = function(list) ->
    nonrepeating_helper list [];;



(*
sumOfTwo(a,b,v) returns false if there does not exist an integer in a, which added to any integer in b, equals v.  If there is an integer in a, and an integer in b that sum to v, return true.

val sumOfTwo : int list * int list * int -> bool = <fun>
*)
let rec checkSums list1 list2 sum = 
    (*check to see if list is empty*)
    if list1 = [] || list2 = [] then
        false
    else
        (*if head of list 1 + head of list 2 = the target sum, then return true*)
        if (List.hd list1) + (List.hd list2) = sum then
            true
        
        (*otherwise send list1, the tail of list2, and the target sum to the function recursively*)
        else 
            checkSums list1 (List.tl list2) sum

let rec sumOfTwo (list1, list2, sum) =
    (*check to see if list is empty*)
    if list1 = [] || list2 = [] then
        false
    else 
        (*if the helper function ends up return true, then return true to the output*)
        if checkSums list1 list2 sum then
            true

        (*otherwise send the tail of list1, list2, and the target sum to the function recursively*)
        else 
            sumOfTwo ((List.tl list1), list2, sum);;

(*
cyk_sublists n returns all of the positive integer pairs x and y that add up to n.  Pairs are returned as tuples.  Argument nmust be larger than 1, otherwise return []

val cyk_sublists : int -> (int * int) list = <fun>
*)
let rec find_cyk_sublists new_sum original_sum sublist =
    (*base case for cyk algorithm*)
    if  (new_sum - 1) < 1 || (original_sum - (new_sum - 1)) > original_sum then
        sublist
    else 
        find_cyk_sublists (new_sum - 1) original_sum (((new_sum - 1), (original_sum - (new_sum - 1))) :: sublist);;

let rec cyk_sublists = function(int) -> 
    find_cyk_sublists int int [];;



(* TEST CASES *)

(*first_duplicate tests*)
first_duplicate [1;2;3;4;5;6;7;4;5;8;9];;
first_duplicate [1;2;3;4;5;6;7;8;9;10];;

(*first_nonrepeating tests*)
first_nonrepeating [1;2;3;2;7;5;6;1;3];;
first_nonrepeating [1;1;1;2;2;2];;

(*sumOfTwo tests*)
sumOfTwo([1;2;3],[10;20;30;40],42);;
sumOfTwo([1;2;3],[10;20;30;40],44);;

(*cyk_sublists tests*)
cyk_sublists 4;;
cyk_sublists 3;;
