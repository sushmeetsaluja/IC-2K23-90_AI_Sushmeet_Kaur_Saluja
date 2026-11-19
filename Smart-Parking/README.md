# Smart Parking System — Turbo Prolog

A Prolog program that assigns each arriving vehicle the **nearest available parking space that suits its type and requirement**. If nothing fits, it explains why.

**Concepts:** constraint handling, prioritisation, reasoning

---

## Files

| File | Purpose |
|---|---|
| `TP/PARKING.PRO` | Source code |
| `Start Turbo Prolog.bat` | Launches DOSBox + Turbo Prolog |
| `tprolog.conf` | DOSBox settings (window size, speed, auto-mount) |

## How to Run

1. Double-click **`Start Turbo Prolog.bat`**. If Windows warns you, click *More info → Run anyway*.
2. Press **Esc**, then **F → L**, type `PARKING`, and press **Enter**.
3. Press **R** to run.
4. Type all input in **lowercase**.

| Menu | Action |
|---|---|
| `1` | Park one vehicle (asks for its ID, type and requirement) |
| `2` | Demo: 8 vehicles arriving one after another |
| `3` | Show all spaces and their status |
| `0` | Exit |

Press **Esc → R** to reset all spaces before each new test.

---

## Knowledge Base (Facts)

`space(Id, Type, Status, Distance)`, stored in the `database` section so it can change at run time.

| ID | Type | Status | Distance (m) |
|---|---|---|---|
| p1 | regular | occupied | 5 |
| p2 | compact | available | 10 |
| p3 | regular | available | 15 |
| p4 | reserved | available | 8 |
| p5 | accessible | available | 3 |
| p6 | accessible | available | 20 |
| p7 | ev | available | 12 |
| p8 | large | available | 30 |
| p9 | bike | available | 2 |
| p10 | regular | unavailable | 4 |
| p11 | regular | available | 25 |
| p12 | compact | available | 6 |

`parked(VehicleId, SpaceId)` is added each time a vehicle is parked.

## Rules

| Predicate | Purpose |
|---|---|
| `suits(VType, Req, SpaceType)` | Matching rules: car+regular→regular, car+compact→compact, car+ev→ev, car+vip→reserved, bike→bike, truck→large, any+accessible→accessible |
| `candidate/5` | **Constraint:** the space must be `available` AND `suits` must hold |
| `nearest/5` | `findall` collects the candidate distances; `min_of` picks the smallest |
| `park/3` | Allocates the space: `retract` it as available, `assertz` it as occupied, record `parked/2`. A vehicle that's already parked is refused |
| `explain/2` | **Reasoning:** reports either "all matching spaces are full" or "no space type matches" |
| `process/2`, `handle/2` | **Priority:** pass 1 serves accessible vehicles, pass 2 serves everyone else |

## Approach

1. A vehicle arrives with a type and a requirement.
2. Prolog keeps only spaces that are **available** and **match** (constraint handling).
3. It chooses the **nearest** one (smallest distance).
4. That space is marked `occupied`, so it can never be allocated twice.
5. If no space qualifies, Prolog backtracks to the next `park` clause, and `explain` gives the reason.
6. With multiple vehicles, **accessible vehicles are served first**.

---

## Test Cases

Run each on a fresh start (**Esc → R**).

### 1. Successful allocation
Input: `1` → `car1`, `car`, `regular`
```
Vehicle      : car1 (car, regular)
Allocated    : p3
Space Type   : regular
Distance     : 15 m
Status       : Successfully Allocated
Reason       : p3 is the nearest available space matching the requirement.
```
p1 (occupied) and p10 (unavailable) are nearer but get rejected.

### 2. No matching space type
Input: `1` → `truck1`, `truck`, `compact`
```
Vehicle      : truck1 (truck, compact)
Status       : NOT Allocated
Reason       : No space type matches this vehicle and requirement.
```

### 3. Multiple vehicles with priority
Input: `2`

| Served | Vehicle | Requirement | Result |
|---|---|---|---|
| 1 | car2 | accessible | p5 (priority) |
| 2 | car1 | regular | p3 |
| 3 | bike1 | regular | p9 |
| 4 | car3 | vip | p4 |
| 5 | truck1 | regular | p8 |
| 6 | car4 | ev | p7 |
| 7 | car5 | regular | p11 |
| 8 | car6 | regular | NOT allocated: all matching spaces occupied |

---


