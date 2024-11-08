# RoboPet

Welcome to **RoboPet**! Follow the instructions below to download and run the game on your system.

---

## How to Run the Game

### Step-by-Step Instructions

1. **Clone or Download the Repository**  
   - **Clone:** Open a terminal and run:
     ```bash
     git clone https://github.com/HR6002/RoboPet.git
     ```
   - **Download ZIP:** Click the green "Code" button at the top of this page, select "Download ZIP", and unzip the downloaded file.

2. **Unzip the LOVE 11.5 Package**  
   - Inside the unzipped repository, locate the `love-11.5-win64.zip` file.
   - Unzip `love-11.5-win64.zip` to extract the LOVE framework.

3. **Run the Game**  
   - Open the `love-11.5-win64` folder and double-click `game.exe` to start the game.
   - If you encounter a Windows security warning, click "More info" and select "Run anyway." Alternatively, you can right-click on `game.exe` and select **Run as Administrator**.

---

### Alternative Option: Run with Lua and LOVE

If you’d like to run the game using your own Lua interpreter and LOVE installation:

1. **Install a Lua Interpreter**  
   - Download and install Lua from [Lua's official site](https://www.lua.org/download.html).

2. **Install LOVE**  
   - Download and install the latest version of LOVE from [LOVE's download page](https://love2d.org/#download).

2. **Add Love to Path**  
   - Follow the steps at: [LOVE's download page](https://love2d.org/#download) and make sure you add love to path.
   - test it by running this: should not return error. 
      ```bash
     love
     ```
      

3. **Run the Game**  
   - In a terminal, navigate to the `source-code` directory and run:
     ```bash
     love .
     ```

---

# Documentation for Codebase

## Overview
This codebase defines a simple virtual pet game implemented using the LOVE2D framework. It features a game loop with `love.load`, `love.update`, and `love.draw` functions, various player states, sprite animations, and user interactions via buttons. The game simulates a pet's basic needs, including hunger, sleep, happiness, and health, which are visualised through monitor bars.

### Modules and Classes
- **`Button`**: Represents interactive UI buttons that users can click.
- **`Monitor`**: Represents visual bars that track the player's current stats.
- **`Anim8`**: A library used to create sprite animations.

## Main Functions

### `love.load()`
Initialises variables and objects before the game starts.
- **Player Initialization**: Creates the `Player` table to store its properties such as birth time, last fed time, last interaction, and RGB colour values.
- **Sprite Initialization**: Sets up the sprite animations using the Anim8 library for different emotional states (e.g., happy, normal, sad, sleeping).
- **Monitor Bars**: Creates monitor bars (`MonitorBars`) for displaying the pet’s hunger, sleep, happiness, and health levels.
- **Interactive Buttons**: Defines buttons (`InteractiveButtons`) that allow users to interact with the pet (e.g., "Feed", "Play", "Wake Up", "Exercise").

### `love.update(dt)`
Runs updates for the game state and logic at a frequency determined by the delta time (`dt`).
- **Animation Updates**: Selects the appropriate animation to display based on the player's current emotion.
- **State Check and Update**: Adjusts the player’s emotion based on the values of the monitor bars and conditions.
- **Stat Depletion**: Reduces the progress of various stats over time if the pet is not sleeping.
- **Interaction Timer**: Changes the pet's colour to a random RGB value if it has not been interacted with for over 30 seconds.

### `love.draw()`
Handles rendering of visual elements.
- **Drawing the Player**: Displays the current sprite based on the player's emotion.
- **Monitor Bars**: Draws the monitor bars that show the current stats.
- **Text Displays**: Shows relevant text, such as the pet’s age, last fed time, and last interaction.
- **Buttons**: Renders interactive buttons on the screen.
- **Interaction Prompt**: Displays a prompt if the pet is bored due to a lack of interaction.

### `love.mousepressed(x, y, button)`
Processes mouse click events and triggers corresponding actions when UI buttons are clicked.
- **Feed Button**: Increases hunger progress and updates the last fed time.
- **Play Button**: Increases happiness progress and resets the colour to default.
- **Exercise Button**: Increases health progress and resets the colour to default.
- **Wake Up Button**: Wakes the pet if the sleep bar is above 50%.

## Class Descriptions

### `Button`
Represents an interactive button UI element.
- **Constructor (`Button:new`)**: Creates a new button instance with specified properties (text, width, height, x, and y coordinates).
- **`draw()`**: Renders the button with centred text.
- **`isClick(x, y)`**: Checks if a mouse click occurred within the button's boundaries.

### `Monitor`
Represents a monitor bar that visualises the pet’s stat levels.
- **Constructor (`Monitor:new`)**: Creates a new monitor bar with specified colour arguments and label.
- **`draw(x, y)`**: Draws the monitor bar, filling it proportionally based on the current progress and displaying the label below it.

## Game Mechanics
- **Player Emotions**: The player's current emotion (e.g., sad, normal, happy, sleeping, star) is determined by the values in `MonitorBars`.
- **Stat Changes**: Each game loop decreases the stat values unless the pet is sleeping, which regenerates the sleep stat.
- **Interaction Requirement**: If the pet is not interacted with for over 30 seconds, it displays a prompt and changes its colour to a random RGB value.

This documentation serves as an overview of the main components and functionality within the game codebase. For deeper exploration, consider examining individual methods and how they contribute to the gameplay experience.
Autogenerated By Copilot
