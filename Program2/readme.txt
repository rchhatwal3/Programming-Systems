sde2.caml -> This file is the implementation file for the 4 functions that are outlined in the project write up

sde2.log -> ASCII log file with the funcitonality of 2 test cases for each function created by using terminal command ocaml < sde2.ml > sde2.log

The test cases I used are as follows:

For first_duplicate: 
first_duplicate [1;2;3;4;5;6;7;4;5;8;9];; with expected output : int = 4
first_duplicate [1;2;3;4;5;6;7;8;9;10];; with expected output : int = -10000

For first_nonrepeating:
first_nonrepeating [1;2;3;2;7;5;6;1;3];; with expected output : int= 7
first_nonrepeating [1;1;1;2;2;2];; with expected output : : int = -10000

For sumOfTwo:
sumOfTwo([1;2;3],[10;20;30;40],42);; with expected output : bool = true
sumOfTwo([1;2;3],[10;20;30;40],44);; with expected output : bool = false

For cyk_sublists:
cyk_sublists 4;; with expected output : (int * int) list = [(1, 3); (2, 2); (3, 1)]
cyk_sublists 3;; with expected output : (int * int) list = [(1, 2); (2, 1)]

Pledge: On my honor I have neither given nor received aid on this exam.