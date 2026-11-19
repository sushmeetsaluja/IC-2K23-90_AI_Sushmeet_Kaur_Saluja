# Smart Parking Space Allocation System

## 1. Project Overview

The **Smart Parking Space Allocation System** is a Prolog-based application developed to automate the process of assigning parking spaces to vehicles.

The system uses logical reasoning and predefined rules to identify the most suitable available parking space based on vehicle type and parking requirements.

It maintains parking space availability dynamically and ensures that an already occupied space is not allocated again.

## 2. Problem Statement

Finding a suitable parking space in crowded parking areas can be time-consuming. Manual parking allocation may result in incorrect assignments, confusion and duplicate allocation of spaces.

This project solves this problem by using Prolog facts, predicates and logical rules to automatically identify and allocate suitable parking spaces.

## 3. Project Objectives

- Maintain information about 10 parking spaces.
- Identify parking spaces based on their types.
- Accept vehicle details and parking requirements.
- Check vehicle and parking space compatibility.
- Allocate only available parking spaces.
- Select the nearest suitable available parking space.
- Update parking availability after successful allocation.
- Prevent duplicate allocation of occupied spaces.
- Process multiple vehicle requests in one execution.

## 4. Technologies Used

- **Programming Language:** Turbo Prolog
- **Concepts:** Facts, Predicates, Rules, Dynamic Database and Logical Reasoning
- **Environment:** Turbo Prolog IDE

## 5. Parking Space Details

The system contains 10 predefined parking spaces.
 Space ID       Type        Initial Status       Distance 

 P1            Compact      Occupied                2 
 P2            Compact      Available               4 
 P3            Regular      Available               3 
 P4            Reserved     Available               
 P5            Large        Available               7 
 P6            Accessible   Available               2 
 P7            Regular      Occupied                6 
 P8            Large        Available               4 
 P9            Compact      Available               1 
 P10           Accessible   Available               3 

## 6. Vehicle Compatibility

The system uses predefined compatibility rules to match vehicles with parking spaces.

 Vehicle      Requirement      Suitable Space Types 

 Car          Regular          Regular, Compact 
 Bike         Regular          Regular, Compact 
 Car          Compact          Compact 
 Bike         Compact          Compact 
 SUV          Large            Large 
 Car          Accessible       Accessible
 Bike         Accessible       Accessible 
 SUV          Accessible       Accessible 

## 7. Working of the System

The system follows these steps:

1. Initialize the database with 10 parking spaces.
2. Accept the vehicle type from the user.
3. Accept the parking requirement.
4. Find candidate parking spaces according to the requirement.
5. Check their availability and compatibility.
6. Select the nearest suitable parking space.
7. Change its status from Available to Occupied.
8. Display the allocation result.
9. Repeat the process for three arriving vehicles.

## 8. Prolog Concepts Used

**Facts:** Store the information about parking spaces, their types, availability and distance.

**Predicates:** Define operations such as `initialize`, `candidate`, `compatible`, `find_space` and `allocate`.

**Rules:** Determine whether a parking space is suitable for a particular vehicle.

**Dynamic Database:** The `assertz` and `retract` operations update parking space availability during program execution.

**Cut Operator (!):** Stops further backtracking after the first suitable parking space is allocated.

## 9. Nearest Parking Space Selection

The system maintains candidate parking spaces in ascending order of distance.

For example, for a regular parking requirement:

- P9 – Distance 1
- P3 – Distance 3
- P2 – Distance 4

The system checks candidates in this order and allocates the first available and compatible space.

## 10. Sample Execution

**Example 1: Successful Allocation**

Input:
- Vehicle Type: Car
- Requirement: Regular

Output:
- Allocated Space: P9
- Space Type: Compact
- Distance: 1
- Status: Successfully Allocated

**Example 2: Large Vehicle Allocation**

Input:
- Vehicle Type: SUV
- Requirement: Large

Output:
- Allocated Space: P8
- Space Type: Large
- Distance: 4
- Status: Successfully Allocated

**Example 3: No Suitable Space**

If all candidate spaces for a particular requirement are occupied or incompatible, the system displays:

- Status: Allocation Failed
- Reason: No suitable available parking space found.

## 11. Key Features

- Automated parking allocation.
- 10 predefined parking spaces.
- Vehicle-based compatibility checking.
- Nearest available space selection.
- Dynamic parking status management.
- Prevention of duplicate allocation.
- Processing of three vehicle requests in one session.
- Failure message when no suitable space is available.

## 12. Applications

- Shopping malls
- Colleges and universities
- Office buildings
- Hospitals
- Public parking facilities

## 13. Conclusion

The Smart Parking Space Allocation System demonstrates how Prolog can solve a real-world resource allocation problem using logical reasoning.

By combining predefined facts, compatibility rules and dynamic database updates, the system provides an organized method for allocating suitable parking spaces while preventing duplicate assignments.

The project also demonstrates the practical application of artificial intelligence concepts in everyday parking management.