# Snake Game Console on Terasic DE2-115 FPGA Board

## Project Overview
This project implements the classic Snake Game on the Terasic DE2-115 FPGA development board. The game leverages FPGA peripherals such as VGA for graphical rendering, onboard push buttons for user input, and a 16x2 LCD display for score tracking. Designed using **Verilog** in **Quartus Prime**, the project demonstrates real-time systems, finite state machines (FSMs), and optimized resource usage.

## Features
- **VGA Display (640x480 resolution):**
  - Snake: Green blocks
  - Food: Red block
  - Background: Black
- **Game Modes:**
  - *Bounded*: Snake collides with the edges of the screen.
  - *Unbounded*: Snake wraps around the screen edges.
- **Input Control:**
  - Push buttons handle snake movement (up, down, left, right).
  - Debounced signals ensure stable input.
- **Score Tracking:**
  - Scores are displayed on the 16x2 LCD screen.
  - High scores are stored and retrieved from flash memory.

## System Design
The project follows a modular design:
1. **Master Control Module:** Handles game start, end, and mode selection.
2. **Game Logic Module:** Manages snake movement, food generation, collision detection, and score updates.
3. **VGA Controller Module:** Generates VGA signals to render the game grid.
4. **Input Controller Module:** Captures user input via push buttons with debouncing.
5. **Score Display Module:** Updates and displays scores in real-time on the LCD screen.

## Tools and Resources
- **Hardware:**
  - Terasic DE2-115 FPGA Development Board
  - VGA Monitor
  - Onboard Push Buttons
- **Software:**
  - Quartus Prime (HDL Development)
  - ModelSim (Simulation)
  - Python (Pixel Data Visualization)

## Deliverables
- Fully functional Verilog code.
- Simulation results using ModelSim.
- Working demonstration on Terasic DE2-115 board.

## Contributors
- **Weerakoon A. B.** – 2020/E/169

---

**Enjoy playing the classic Snake Game on your FPGA board! 🎮**
