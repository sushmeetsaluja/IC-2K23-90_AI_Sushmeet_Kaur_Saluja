# Smart Parking Space Allocation System

**Assignment:** Set 8 – Smart Parking Space Allocation System  
**Roll number group:** 85–90  
**Implementation language:** Turbo Prolog (classic syntax target)

## Project overview

This project models a parking facility containing spaces of different types. It accepts a vehicle type and parking requirement, checks compatibility and availability, and allocates the nearest suitable space according to the candidate ordering.

## Files

- `SMARTPARK.PRO` – Prolog source code.
- `Test_Cases.txt` – Three sample test scenarios and expected results.
- `Project_Explanation.pdf` – Short project explanation for submission and viva preparation.

## Features

1. Defines ten parking spaces with type, status and distance.
2. Accepts vehicle type and parking requirement.
3. Checks vehicle/space compatibility.
4. Allocates only spaces whose current status is `available`.
5. Updates the dynamic database after allocation so the same space is not allocated again.
6. Searches candidate spaces in nearest-first order.
7. Processes three vehicle requests in one program run.

## Important implementation notes

- The source is written in the classic Turbo Prolog-style section layout: `domains`, `database`, `predicates`, `clauses`, and `goal`.
- Turbo Prolog releases and compatible laboratory compilers can differ in supported built-ins and exact syntax. In particular, verify `assertz`, `retract`, and `readln` in the exact compiler installed in your lab before the practical demonstration.
- If your compiler uses a different database insertion predicate (for example, `assert` rather than `assertz`), make that compiler-specific substitution consistently.
- Candidate facts are manually ordered nearest-first. If a space distance changes, update its candidate ordering too.
- Accessibility is handled by an explicit `accessible` requirement. This implementation does not automatically reorder a waiting queue of vehicles; it gives accessible spaces only to requests with that requirement.
- The three requests are processed in the same session. Restarting the program reinitializes all spaces.

## How to test

Run the program and enter the three requests shown in `Test_Cases.txt`, one after another. The expected results assume the initial parking-space data in `SMARTPARK.PRO`.

## Assignment requirements covered

- At least ten parking spaces
- Vehicle details and special requirements
- Matching rules
- Availability checking
- No duplicate allocation
- Success/failure output
- Nearest-space selection
- Multiple arriving vehicles
- Accessibility-specific allocation
- Three test scenarios
