# Pac-Man

A Pac-Man-style maze game built with Godot and GDScript for my 2D video game programming coursework at the University of Vermont.

Collect the pellets, avoid ghosts, and use power pellets to turn the tables. Clear the maze before losing all three lives.

## Features

- Continuous movement controlled with WASD or arrow keys
- Ghost state machine with home, scatter, chase, vulnerable, and eaten states
- Ghost pathfinding using `NavigationAgent2D`
- Small pellets, power pellets, and increasing rewards for eating ghosts
- Score display, three lives, and win/game-over screens
- Side portals that connect opposite ends of the maze
- Animation and sound hooks for movement, pickups, and death

## Assets excluded

The original course artwork and audio cannot be redistributed and are **not included**. This repository contains scripts, scenes, and project configuration. It will not run as-is without replacement assets.

Supply your own properly licensed replacements at these paths:

- `Assets/BackdropBlackLittleSparkBlack.png`
- `Assets/Ghosts/Ghost_Body_01.png`
- `Assets/Ghosts/Ghost_Body_02.png`
- `Assets/Ghosts/Ghost_Eyes_Down.png`
- `Assets/Ghosts/Ghost_Vulnerable_Blue_01.png`
- `Assets/Ghosts/Ghost_Vulnerable_Blue_02.png`
- `Assets/Ghosts/Ghost_Vulnerable_White_01.png`
- `Assets/Ghosts/Ghost_Vulnerable_White_02.png`
- `Assets/PacManAssets-Items.png`
- `Assets/PacManAssets-PacMan.png`
- `Assets/PacManAssets_Map_TileSet.png`
- `Assets/PacManLife.png`
- `Assets/pacman_beginning.wav`
- `Assets/pacman_chomp.wav`
- `Assets/pacman_death.wav`
- `Assets/pacman_eatghost.wav`
- `Assets/pacman_intermission.wav`

Keep the exact capitalization of these paths. Replacement sprite sheets must match the scene regions and tile atlas layout, or those settings must be updated in Godot. The `Assets/` directory is ignored by Git to prevent accidental uploads.

## Run locally

1. Clone or download this repository.
2. Add compatible replacement artwork and audio as described above.
3. Import `project.godot` in Godot and allow resources to import.
4. Press **F5** to start the game. Use **WASD** or the **arrow keys** to move.

The project configuration specifies **Godot 4.7** with the **Forward Plus** renderer. Use a compatible Godot version.

## Project structure

- `Scenes/pac_man.gd` — movement and player animation handling
- `Scenes/ghost.gd` — ghost states, navigation, and interactions
- `Scenes/level.gd` — pellet spawning, portals, lives, and score display
- `Scenes/small_pellet.gd` and `Scenes/big_pellet.gd` — pellet collection
- `Scenes/title_screen.gd` — starting a game and displaying results
- `Globals.gd` — shared score, lives, and gameplay state
- `Scenes/` — maze, character, pellet, and title scenes

Created by Tyler Sheehan as a class project. Exported builds, archives, editor caches, and backup script copies are excluded.
