# Tetris Game

A classic implementation of the Tetris game, built in C for educational purposes. This project demonstrates the fundamental concepts of game development, including game loop, input handling, rendering, and tetromino generation and movement.

## Features

- **Customizable Game Settings**: Configure the game window dimensions, update rate, and falling speed to tailor the gameplay experience.
- **Colorful Rendering**: Choose from different color schemes for the background and tetrominoes for a visually appealing game.
- **Score Tracking**: Keep track of your score as you clear lines and progress through the game.
- **Smooth Gameplay**: Enjoy a seamless gaming experience with efficient rendering and precise tetromino movements.
- **Intuitive Controls**: Use the arrow keys to move and rotate the tetrominoes, making the gameplay easy to pick up.

## Prerequisites

Before building and running the Tetris game, ensure that you have the following tools installed:

- `gcc` (GNU Compiler Collection)
- `make` (GNU Make)
- `clang-format` (for automatic code formatting)
- `numpy` (pip install numpy)
- `tkinter` (sudo apt-get install python3-tk)

## Getting Started

Follow these steps to build and run the Tetris game:

1. Build the game: (Run the given command in the terminal)
"make"

2. Run the game:
"make run"

This will run the tetris game according to the predefined input given in `testinput.tetris` by the game programmer/ player.

The python code generated after the Syntax Directed Translation(SDT) can be viewed in translated.py

-------------------------------------------------------------------------------------------------------------------------------------------------------------
# VERY IMPORTANT NOTE: In order to successfully play the game, you(the game programmer/ player) MUST specify these(given below) variables in Section1 of the input file.
-------------------------------------------------------------------------------------------------------------------------------------------------------------

- `height`: Height of the game window (default: 20)
- `width`: Width of the game window (default: 10)
- `update_duration`: Duration between game updates in milliseconds (default: 500)
- `move_down_duration`: Duration for tetrominoes to move down in milliseconds (default: 500)
- `background_col`: Background color (1: light gray, 2: dark gray)
- `foreground_col`: Tetromino color (1: blue, 2: red, 3: green)

The available background color options are:

| Option | Background Color |
|--------|-------------------|
| 0      | Black             |
| 1      | White             |
| 2      | Light Gray        |
| 3      | Dark Gray         |

The available tetromino color options are:

| Option | Foreground Color |
|--------|------------------|
| 0      | Blue             |
| 1      | Red              |
| 2      | Green            |
| 3      | Yellow           |
| 4      | Cyan             |
| 5      | Magenta          |

3. Play the game and enjoy!

# Collaborative effort done by:
1. Shanay Mehta(2021A7PS1322G)
2. Ayush Ghatalia(2021A7PS2571G)
3. Karan Bania(2021A7PS2582G)

