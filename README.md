# Elevator Control System (Verilog)

## Overview
This project implements a **Finite State Machine (FSM)–based elevator controller** using Verilog HDL.  
The elevator operates across **four floors (0–3)**, processes floor requests, and includes an **emergency stop feature**. A complete **testbench** is provided for simulation and verification.

---

## Features
- 4-floor elevator system
- Upward and downward movement control
- Emergency stop functionality
- FSM-based control logic
- Priority-based floor request selection
- Asynchronous reset
- Verilog testbench included

---

## File Structure
| File Name | Description |
|---------|-------------|
| `Elevator_control.v` | Elevator controller RTL module |
| `tb_Elevator_control.v` | Testbench for simulation |

---

## FSM Description

### States
| State | Binary | Description |
|------|--------|-------------|
| `S_IDLE` | `00` | Elevator stopped |
| `S_UP` | `01` | Elevator moving up |
| `S_DOWN` | `10` | Elevator moving down |
| `S_EMER` | `11` | Emergency stop state |

### State Transitions
- **IDLE → UP**: Target floor is higher than current floor
- **IDLE → DOWN**: Target floor is lower than current floor
- **UP/DOWN → IDLE**: Target floor reached
- **Any → EMER**: Emergency stop activated
- **EMER → IDLE**: Emergency stop released

---

## Input Signals
| Signal | Width | Description |
|------|------|-------------|
| `clk` | 1 | System clock |
| `reset` | 1 | Asynchronous reset |
| `floor_req` | 4 | One-hot floor request input |
| `emergency_stop` | 1 | Emergency stop signal |

---

## Output Signals
| Signal | Width | Description |
|------|------|-------------|
| `move_up` | 1 | Elevator moving up |
| `move_down` | 1 | Elevator moving down |
| `motor_stop` | 1 | Elevator stopped |
| `current_floor` | 2 | Current floor number |

---

## Floor Request Logic
- Floor requests are **one-hot encoded**
- Priority order: **Floor 0 → Floor 3**
- Only one target floor is serviced at a time

---

## Testbench Overview
The testbench validates:
1. Reset operation
2. Movement to floor 3
3. Movement to floor 1
4. Emergency stop behavior
5. Post-emergency movement to floor 2

**Clock Period:** 10 ns

---

## Simulation Steps
1. Open a Verilog simulator (Vivado / ModelSim / Questa)
2. Add:
   - `Elevator_control.v`
   - `tb_Elevator_control.v`
3. Set `tb_Elevator_control` as the top module
4. Run simulation and analyze waveforms

---

## Possible future improvements
- Door open/close states
- Request queue implementation
- Variable speed control
- Display and alarm integration
---
