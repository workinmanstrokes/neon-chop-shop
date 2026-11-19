# Neon Chop Shop

**Install the chrome. Break the ICE. Don't get traced.**

Neon Chop Shop is a mobile cyberpunk roguelite where you run a back-alley
chop shop in a gritty, dystopian neon metropolis. Diagnose clients, install
and overclock cyberware through drag-and-drop wiring and chip-alignment
puzzles, then jack into cyberspace for card-based data heists against ICE
before the trace meter fills.

Credits and stolen tech fund new blueprints, 3D-printed chrome and better
hacking software, while overclocking and failed heists raise heat and risk
malfunctions and police raids.

## What it is

- **Cybernetic upgrade simulator** — back-alley cyber-surgeon: inspect
  clients, read faulty system logs, install, rewire and overclock implants
  (optical chips, neural links, military-grade chrome).
- **Roguelite hackathon loop** — between surgeries, jack in for data-heist
  "hackathons": a quick-turn digital card battler mixed with push-your-luck
  hacking puzzles against firewall security AI (ICE).
- **Chop Shop economy** — earn digital credit and stolen tech to expand the
  shop, 3D-print illegal implants, and buy better hacking software.
- **Heat and raids** — overclocking grants extreme bonuses but raises heat
  and malfunction meters, risking permanent system failure or police raids.

## Features

- Client diagnosis: read symptoms and faulty system logs to pick the correct
  implant and wiring fault before surgery.
- Drag-and-drop surgery: place an implant in a body slot, drag wires to
  matching circuit nodes, and align memory chips under a precision/timer
  check.
- Overclocking: boost implant power for extra payout and bonuses while
  raising heat and malfunction chance.
- Turn-based ICE card battles: play icebreaker cards and scripts against
  firewall AI to break nodes and steal data.
- Push-your-luck downloads: keep hacking for more loot as the trace meter
  rises, or jack out before cyber-police trace you.
- Roguelite heist map: pick branching heist nodes between surgeries; a full
  trace ends the run and loses unbanked loot.
- Chop Shop upgrades: spend credits and stolen tech on implant blueprints,
  3D-printing, better cards and hacking software.
- Heat and raid system: high heat from overclocking and failed hacks triggers
  malfunctions, fines and police raids.
- Persistent meta-progression and local save: keep unlocked blueprints, cards
  and shop upgrades between runs.

## Screens

Title / Main Menu · Chop Shop Hub · Client Intake & Diagnosis ·
Surgery Table · Surgery Results & Payment · Cyberspace Heist Map ·
Hack Battle · Upgrade & 3D-Print Shop · Run End / Raid / Game Over

## How to run

Requires **Godot 4** (4.x, GDScript, 2D).

1. Open this folder in Godot 4 (Import, or open `project.godot`).
2. Press **F5** (or the Play button) to run the project. The main scene is
   `main.tscn`.
3. The starter build is a playable skeleton: from the Hub, open the Surgery
   Table, drag the implant into the highlighted body slot, and get a
   pass/fail result with payout. Credits, heat and save state live in the
   `GameState` autoload (`scripts/game_state.gd`).

### Exporting to Android / iOS

- **Android:** install the Godot Android export templates, enable the
  Android export preset (one-click deploy to a device for testing, or build
  an APK/AAB for sideloading/store).
- **iOS:** export from Godot on macOS with the iOS export preset, then open
  the generated Xcode project to sign and deploy.
- The project uses a portrait mobile viewport (720 × 1280) with stretch
  mode `canvas_items`, so one codebase serves both platforms.

## Build milestones

1. Playable skeleton in Godot: hub, one client, drag one implant into a
   slot, pass/fail and payout.
2. Full surgery loop: diagnosis from logs, wire-connecting and chip-alignment
   puzzles, scoring and malfunction.
3. Hack battler: hand of icebreaker cards vs one ICE type, trace meter,
   download and jack-out.
4. Roguelite loop: branching heist map, run rewards, trace-out ends run and
   loses unbanked loot.
5. Chop Shop economy: shop, blueprints and 3D-printing, card/software
   upgrades, overclock and heat/raid consequences.
6. Content and balance pass: multiple clients, implants, cards, ICE types
   and heist nodes with tuned difficulty.
7. Polish and ship: neon glitch UI, diagnostic animations, synth music/SFX,
   local save, Android/iOS export and device testing.

## Tech

- **Engine:** Godot 4 (GDScript, 2D) — one codebase exports to Android and
  iOS and natively handles touch drag-and-drop, cards, particles, glitch
  shaders and audio.
- **Save:** local JSON save via `user://savegame.json` (no account, no
  server).

## License

All original code and assets in this repository are the author's own work.
