# Pac-Man

A PacMan style maze game built with Godot and GDScript for my 2D video game programming course at the University of Vermont.

Uploaded code onto Github to show on my portfolio 

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

## Project structure

- `Scenes/pac_man.gd` — movement and player animation handling
- `Scenes/ghost.gd` — ghost states, navigation, and interactions
- `Scenes/level.gd` — pellet spawning, portals, lives, and score display
- `Scenes/small_pellet.gd` and `Scenes/big_pellet.gd` — pellet collection
- `Scenes/title_screen.gd` — starting a game and displaying results
- `Globals.gd` — shared score, lives, and gameplay state
- `Scenes/` — maze, character, pellet, and title scenes
