/* SMART PARKING SYSTEM - Turbo Prolog 2.0
   Constraint handling, prioritisation and reasoning */

domains
  ilist   = integer*
  vehicle = v(symbol, symbol, symbol)      /* id, type, requirement */
  vlist   = vehicle*

database
  space(symbol, symbol, symbol, integer)   /* id, type, status, distance */
  parked(symbol, symbol)                   /* vehicle id, space id */

predicates
  suits(symbol, symbol, symbol)
  candidate(symbol, symbol, symbol, symbol, integer)
  min_of(ilist, integer)
  nearest(symbol, symbol, symbol, symbol, integer)
  park(symbol, symbol, symbol)
  explain(symbol, symbol)
  process(vlist, integer)
  handle(vehicle, integer)
  show_spaces
  header
  menu
  choice(char)

clauses
  /* ---------- PARKING SPACES: id, type, status, distance (m) ---------- */
  space(p1,  regular,    occupied,    5).
  space(p2,  compact,    available,  10).
  space(p3,  regular,    available,  15).
  space(p4,  reserved,   available,   8).
  space(p5,  accessible, available,   3).
  space(p6,  accessible, available,  20).
  space(p7,  ev,         available,  12).
  space(p8,  large,      available,  30).
  space(p9,  bike,       available,   2).
  space(p10, regular,    unavailable, 4).
  space(p11, regular,    available,  25).
  space(p12, compact,    available,   6).

  /* ---------- MATCHING RULES: vehicle type + requirement -> space type ---------- */
  suits(_,     accessible, accessible).
  suits(car,   regular,    regular).
  suits(car,   compact,    compact).
  suits(car,   ev,         ev).
  suits(car,   vip,        reserved).
  suits(bike,  regular,    bike).
  suits(truck, regular,    large).

  /* ---------- CONSTRAINTS: only available + matching spaces ---------- */
  candidate(VT, Req, Id, ST, D) :-
      space(Id, ST, available, D),
      suits(VT, Req, ST).

  /* ---------- NEAREST SPACE ---------- */
  min_of([X], X) :- !.
  min_of([H|T], H) :- min_of(T, M), H <= M, !.
  min_of([_|T], M) :- min_of(T, M).

  nearest(VT, Req, Id, ST, D) :-
      findall(X, candidate(VT, Req, _, _, X), L),
      L = [_|_],
      min_of(L, D),
      candidate(VT, Req, Id, ST, D), !.

  /* ---------- ALLOCATION ---------- */
  park(VId, _, _) :-
      parked(VId, S), !,
      write("Vehicle ", VId, " is already parked at ", S), nl.
  park(VId, VT, Req) :-
      nearest(VT, Req, Id, ST, D), !,
      retract(space(Id, ST, available, D)),
      assertz(space(Id, ST, occupied, D)),
      assertz(parked(VId, Id)),
      write("Vehicle      : ", VId, " (", VT, ", ", Req, ")"), nl,
      write("Allocated    : ", Id), nl,
      write("Space Type   : ", ST), nl,
      write("Distance     : ", D, " m"), nl,
      write("Status       : Successfully Allocated"), nl,
      write("Reason       : ", Id, " is the nearest available space matching the requirement."), nl, nl.
  park(VId, VT, Req) :-
      write("Vehicle      : ", VId, " (", VT, ", ", Req, ")"), nl,
      write("Status       : NOT Allocated"), nl,
      explain(VT, Req), nl.

  /* ---------- REASONING: why no space ---------- */
  explain(VT, Req) :-
      space(_, ST, _, _), suits(VT, Req, ST), !,
      write("Reason       : All matching spaces are occupied or unavailable."), nl.
  explain(_, _) :-
      write("Reason       : No space type matches this vehicle and requirement."), nl.

  /* ---------- PRIORITY QUEUE: accessible first, then others ---------- */
  process([], _).
  process([V|T], P) :- handle(V, P), process(T, P).

  handle(v(Id, VT, accessible), 1) :- !, park(Id, VT, accessible).
  handle(v(_,_,accessible),2):-!.
  handle(v(Id, VT, Req),2):-!,park(Id,VT,Req).
  handle(_, _).

  /* ---------- DISPLAY ---------- */
  header :-
      nl, write("========== SMART PARKING SYSTEM =========="), nl, nl.

  show_spaces :-
      header,
      write("ID\tTYPE\t\tSTATUS\t\tDIST"), nl,
      space(Id, T, S, D),
      write(Id, "\t", T, "\t\t", S, "\t", D), nl,
      fail.
  show_spaces.

  /* ---------- MENU ---------- */
  menu :-
      nl, write("1. Park a vehicle"), nl,
      write("2. Demo: multiple vehicles arriving"), nl,
      write("3. Show all spaces"), nl,
      write("0. Exit"), nl,
      write("Choice: "), readchar(C), write(C), nl,
      choice(C).

  choice('1') :- !,
      write("Vehicle ID (e.g. car1): "), readln(I),
      write("Type (car/bike/truck): "), readln(T),
      write("Requirement (regular/compact/ev/vip/accessible): "), readln(R),
      header, park(I, T, R), menu.
  choice('2') :- !,
      header,
      write("Accessible vehicles are served first."), nl, nl,
      Q = [v(car1, car, regular), v(car2, car, accessible),
           v(bike1, bike, regular), v(car3, car, vip),
           v(truck1, truck, regular), v(car4, car, ev),
           v(car5, car, regular), v(car6, car, regular)],
      process(Q, 1),
      process(Q, 2),
      menu.
  choice('3') :- !, show_spaces, menu.
  choice('0') :- !.
  choice(_) :- menu.

goal
  header,
  menu.
