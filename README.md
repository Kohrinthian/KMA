# KMA (Kohrinthian Minimap Arrow)

A lightweight, high-performance custom minimap arrow replacement for **Azeroth Survivors** (1.12). It hides the engine-level stock arrow, applies your custom `.tga` texture, tracks player rotation smoothly, and allows live resizing via in-game chat commands.

## Features
- Fully replaces the default engine `minimaparrow` model with a clean custom texture.
- Smooth real-time rotation matching your camera heading.
- Live in-game scaling using `/kma [size]` (saved automatically).
- Custom login broadcast greeting.

## Installation
Unlike standard World of Warcraft addons, Azeroth Survivors addons go into the game config directory:

1. Download the latest release / zip from GitHub.
2. Extract the `KMA` folder into your Azeroth Survivors directory:
   `benilla-config/AddOns/KMA/`
3. Ensure your file path looks like: `benilla-config/AddOns/KMA/KMA.lua`

## Usage
Type `/kma [size]` in your game chat to resize the arrow on the fly (e.g., `/kma 32`).
