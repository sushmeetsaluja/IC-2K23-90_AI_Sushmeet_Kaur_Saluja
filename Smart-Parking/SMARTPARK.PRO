domains
    vehicle = string
    requirement = string
    spaceid = string
    spacetype = string
    status = string
    distance = integer

database
    space(spaceid, spacetype, status, distance)

predicates
    initialize
    candidate(requirement, spaceid, distance)
    compatible(vehicle, requirement, spacetype)
    find_space(vehicle, requirement, spaceid, spacetype, distance)
    allocate(vehicle, requirement)
    get_vehicle(vehicle, requirement)
    run_three_tests

clauses

% Initialize the 10 parking spaces.
% The database is populated once when the program starts.

initialize :-
    assertz(space("P1","compact","occupied",2)),
    assertz(space("P2","compact","available",4)),
    assertz(space("P3","regular","available",3)),
    assertz(space("P4","reserved","available",5)),
    assertz(space("P5","large","available",7)),
    assertz(space("P6","accessible","available",2)),
    assertz(space("P7","regular","occupied",6)),
    assertz(space("P8","large","available",4)),
    assertz(space("P9","compact","available",1)),
    assertz(space("P10","accessible","available",3)).

% Candidate spaces are listed nearest first for each requirement.
% Keep these distances consistent with the space/4 facts.

candidate("regular","P9",1).
candidate("regular","P3",3).
candidate("regular","P2",4).

candidate("compact","P9",1).
candidate("compact","P2",4).

candidate("large","P8",4).
candidate("large","P5",7).

candidate("accessible","P6",2).
candidate("accessible","P10",3).

% Vehicle and parking requirement compatibility.

compatible("car","regular","regular").
compatible("car","regular","compact").
compatible("bike","regular","regular").
compatible("bike","regular","compact").

compatible("car","compact","compact").
compatible("bike","compact","compact").

compatible("suv","large","large").

compatible("car","accessible","accessible").
compatible("bike","accessible","accessible").
compatible("suv","accessible","accessible").

% Find a space whose current database status is available.

find_space(V,R,S,T,D) :-
    candidate(R,S,D),
    space(S,T,"available",D),
    compatible(V,R,T).

% Successful allocation:
% remove the available fact and insert an occupied fact.
% The cut commits to the first suitable candidate (nearest first).

allocate(V,R) :-
    find_space(V,R,S,T,D),
    retract(space(S,T,"available",D)),
    assertz(space(S,T,"occupied",D)),
    !,
    nl,
    write("===== SMART PARKING SYSTEM ====="),nl,
    write("Vehicle Type: "),write(V),nl,
    write("Allocated Space: "),write(S),nl,
    write("Space Type: "),write(T),nl,
    write("Distance: "),write(D),nl,
    write("Status: Successfully Allocated"),nl,
    write("Reason: Space is available and matches the requirement."),nl.

% Failure message if no candidate satisfies all conditions.

allocate(V,R) :-
    nl,
    write("===== SMART PARKING SYSTEM ====="),nl,
    write("Vehicle Type: "),write(V),nl,
    write("Requirement: "),write(R),nl,
    write("Status: Allocation Failed"),nl,
    write("Reason: No suitable available parking space found."),nl.

% Read one vehicle request from the user.

get_vehicle(V,R) :-
    nl,
    write("Enter vehicle type (car/bike/suv): "),
    readln(V),
    write("Enter requirement (regular/compact/large/accessible): "),
    readln(R).

% Process three arriving vehicles in the same running session.

run_three_tests :-
    write("================================"),nl,
    write("       SMART PARKING SYSTEM     "),nl,
    write("================================"),nl,
    write("Enter details for three arriving vehicles."),nl,
    get_vehicle(V1,R1),
    allocate(V1,R1),
    get_vehicle(V2,R2),
    allocate(V2,R2),
    get_vehicle(V3,R3),
    allocate(V3,R3),
    nl,
    write("All three vehicle requests processed."),nl.

goal
    initialize,
    run_three_tests.
