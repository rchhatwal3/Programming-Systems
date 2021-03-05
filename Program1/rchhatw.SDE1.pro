% Ramneek Chhatwal
% CPSC 3520
% Dr. Ligon
% March 4, 2021

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ECE3520/CpSc3520 SDE1: Prolog Declarative and Logic Programming

% Use the following Prolog relations as a database of familial 
% relationships for 4 generations of people.  If you find obvious
% minor errors (typos) you may correct them.  You may add additional
% data if you like but you do not have to.

% Then write Prolog rules to encode the relations listed at the bottom.
% You may create additional predicates as needed to accomplish this,
% including relations for debugging or extra relations as you desire.
% All should be included when you turn this in.  Your rules must be able
% to work on any data and across as many generations as the data specifies.
% They may not be specific to this data.

% Using SWI-Prolog, run your code, demonstrating that it works in all modes.
% Log this session and turn it in with your code in this (modified) file.
% You examples should demonstrate working across 4 generations where
% applicable.

% Fact recording Predicates:

% list of two parents, father first, then list of all children
%parent_list([?PL], [?CL]).
%parent_list(['Parent_list', 'Child_list']).

% Data:

parent_list([fred_smith, mary_jones],
            [tom_smith, lisa_smith, jane_smith, john_smith]).

parent_list([tom_smith, evelyn_harris],
            [mark_smith, freddy_smith, joe_smith, francis_smith]).

parent_list([mark_smith, pam_wilson],
            [martha_smith, frederick_smith]).

parent_list([freddy_smith, connie_warrick],
            [jill_smith, marcus_smith, tim_smith]).

parent_list([john_smith, layla_morris],
            [julie_smith, leslie_smith, heather_smith, zach_smith]).

parent_list([edward_thompson, susan_holt],
            [leonard_thompson, mary_thompson]).

parent_list([leonard_thompson, list_smith],
            [joe_thompson, catherine_thompson, john_thompson, carrie_thompson]).

parent_list([joe_thompson, lisa_houser],
            [lilly_thompson, richard_thompson, marcus_thompson]).

parent_list([john_thompson, mary_snyder],
            []).

parent_list([jeremiah_leech, sally_swithers],
            [arthur_leech]).

parent_list([arthur_leech, jane_smith],
            [timothy_leech, jack_leech, heather_leech]).

parent_list([robert_harris, julia_swift],
            [evelyn_harris, albert_harris]).

parent_list([albert_harris, margaret_little],
            [june_harris, jackie_harris, leonard_harris]).

parent_list([leonard_harris, constance_may],
            [jennifer_harris, karen_harris, kenneth_harris]).

parent_list([beau_morris, jennifer_willis],
            [layla_morris]).

parent_list([willard_louis, missy_deas],
            [jonathan_louis]).

parent_list([jonathan_louis, marsha_lang],
            [tom_louis]).

parent_list([tom_louis, catherine_thompson],
            [mary_louis, jane_louis, katie_louis]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Facts
male(fred_smith).
male(tom_smith).
male(frederick_smith).
male(freddy_smith).
male(marcus_smith).
male(tim_smith).
male(joe_smith).
male(john_smith).
male(blake_towns).
male(cal_holms).
male(joseph_oleary).
male(zach_smith).
male(edward_thompson).
male(leonard_thompson).
male(joe_thompson).
male(richard_thompson).
male(marcus_thompson).
male(tom_louis).
male(john_thompson).
male(george_frey).
male(larry_mcbride).
male(jeremiah_leech).
male(arthur_leech).
male(timothy_leech).
male(jack_leech).
male(robert_harris).
male(albert_harris).
male(james_french).
male(doug_lauder).
male(leonard_harris).
male(kenneth_harris).
male(beau_morris).
male(willard_louis).
male(jonathan_louis).

female(mary_jones).
female(evelyn_harris).
female(pam_wilson).
female(martha_smith).
female(connie_warrick).
female(jill_smith).
female(francis_smith).
female(lisa_smith).
female(jane_smith).
female(layla_morris).
female(julie_smith).
female(leslie_smith).
female(heather_smith).
female(patty_mcdonna).
female(susan_holt).
female(lisa_houser).
female(lilly_thompson).
female(catherine_thompson).
female(mary_snyder).
female(carrie_thompson).
female(mary_thompson).
female(sally_swithers).
female(heather_leech).
female(julia_swift).
female(margaret_little).
female(june_harris).
female(jackie_harris).
female(constance_may).
female(jennifer_harris).
female(karen_harris).
female(jennifer_willis).
female(layla_morris).
female(missy_deas).
female(marsha_lang).
female(mary_louis).
female(jane_louis).
female(katie_louis).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SWE1 Assignment - Create rules for:
:-use_module(library(clpfd)).

% parent(?Parent, ?Child).
parent(P, C) :- parent_list(PL, CL), member(P, PL), member(C, CL).

% sibling(?Person1, Person2).
sibling(P1, P2) :- parent_list(_, CL), member(P1, CL), member(P2, CL), P1\=P2.

% father(?Father, ?Child).
father(F, C) :- husband(F), parent(F, C).

% mother(?Mother, ?Child).
mother(M, C) :- wife(M), parent(M, C).

% husband(?Husband)
husband(H) :- parent_list(PL, _), nth0(0, PL, H).

% wife(?Wife)
wife(W) :- parent_list(PL, _), nth0(1, PL, W).

% married(?Husband, ?Wife).
married(H, W) :- parent_list(PL, _), nth0(0, PL, H), nth0(1, PL, W).

% ancestor(?Ancestor, ?Person).
ancestor(A, P) :- parent(A, P).
ancestor(A, P) :- parent(Z, P), ancestor(A, Z).

% ancestor_with_dist(?Ancestor, ?Person, ?Distance)
ancestor_with_dist(A, P, 1) :- parent(A, P).
ancestor_with_dist(A, P, D) :- parent(Z, P), D1 #= D - 1, ancestor_with_dist(A, Z, D1).

% common_ancestor(?Person1, ?Person2, ?Ancestor).
common_ancestor(P1, P2, A) :- ancestor(A, P1), ancestor(A, P2).

% descendent(?Decendent, ?Person).
descendent(D, P) :- ancestor(P, D).

% blood(?Person1, ?Person2). %% blood relative
blood(P1, P2) :- ancestor(P1, P2) ; descendent(P1, P2).

% uncle(?Uncle, ?Person).  
uncle(U, P) :- (male(U) ; husband(U)), sibling(U, Z),  parent(Z, P).
uncle(U, P) :- sibling(Z, Q), parent(Q, P), married(U, Z).

% aunt(?Aunt, ?Person).  
aunt(A, P) :- (female(A) ; wife(A)), sibling(A, Z), parent(Z, P).
aunt(A, P) :- married(Z, A), uncle(Z, P).

% cousin(?Cousin, ?Person).
cousin(C, P) :- uncle(Z, P), parent(Z, C).

%% 1st cousin, 2nd cousin, 3rd once removed, etc.
% cousin_type(+Person1, +Person2, -CousinType, -Removed).
cousin_type(P1, P2, CT, R) :- common_ancestor(P1, P2, A), ancestor_with_dist(A, P1, D1), ancestor_with_dist(A, P2, D2), D1 >= 2, D2 >= 2, CT #= (min(D1, D2) - 1), R #= abs(D1-D2), \+(sibling(P1, P2)), \+(parent(P1, P2)), \+(parent(P2, P1)), \+(aunt(P1, P2) ; uncle(P1, P2)), \+(aunt(P2, P1) ; uncle(P2, P1)), P1\=P2.

