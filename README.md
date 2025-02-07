# Beat The Clock Binary

## Project Overview  
**Names:** Yadon Kasshaun & Mohammad Zain Al Syed  

Beat The Clock Binary is an FPGA-based digital two-player game that combines combinational and sequential logic to create a competitive and timed gameplay experience. Players take turns guessing randomly generated 5-bit binary numbers within a time limit. Real-time score tracking and countdown timers are implemented using XOR gates for input verification, binary adders/subtractors for timer calculations, and a clock divider for precise timing. The game state transitions manage turn changes, score updates, and timer decrements, ensuring smooth gameplay.  

## Technical Details  
The project is implemented in Verilog and features multiple modules, including a random number generator for 5-bit binary values, edge detection for responsive button presses, and 5-bit counters for player timers. A 1 Hz clock signal, derived from a clock divider, controls the countdown timers. The game logic checks active timers, updates random numbers, and resets values as needed. Seven-segment displays are used to show timers and generated numbers, providing real-time feedback to players.  

## Gameplay Description  
At the start, both players' countdown timers are set to 30 seconds and displayed on the FPGA's seven-segment displays. The first player's timer begins counting down, and they must input the displayed 5-bit binary number using switches. If the guess is correct, their timer pauses, and the other player's timer starts. This alternates until one player's timer reaches zero, declaring the other player the winner. The winning player's number is displayed on the final seven-segment display.  

## Key Features  
- Real-time countdown timers and score tracking.  
- Random 5-bit binary number generation.  
- Responsive button and switch inputs with edge detection.  
- Seven-segment displays for timer and number visualization.  
- Combinational and sequential logic integration for seamless gameplay.  

This project demonstrates the effective use of digital design techniques to create an engaging and interactive game, showcasing both technical skill and creativity.
