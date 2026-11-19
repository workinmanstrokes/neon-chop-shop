extends Node
## GameState autoload: player profile, run state, heat, and local save.
## Persistent meta-progression (credits, tech, blueprints, cards, shop
## upgrades) survives between runs; unbanked run loot does not.

const SAVE_PATH := "user://savegame.json"
const MAX_HEAT := 100
const RAID_HEAT_THRESHOLD := 80

var credits: int = 250
var stolen_tech: int = 0
var heat: int = 0
var reputation: int = 0

# Current run (roguelite): lost on a full trace / raid, except banked loot.
var run_loot_credits: int = 0
var run_loot_tech: int = 0
var trace_percent: float = 0.0
var current_node: String = "hub"

# Persistent meta-progression.
var unlocked_blueprints: Array[String] = ["optic_chip_mk1"]
var owned_cards: Array[String] = ["icebreaker_spike"]
var shop_upgrades: Array[String] = []


func _ready() -> void:
	load_game()


func start_new_run() -> void:
	run_loot_credits = 0
	run_loot_tech = 0
	trace_percent = 0.0
	current_node = "hub"


func bank_run_loot() -> void:
	credits += run_loot_credits
	stolen_tech += run_loot_tech
	run_loot_credits = 0
	run_loot_tech = 0


func lose_run_loot() -> void:
	run_loot_credits = 0
	run_loot_tech = 0
	trace_percent = 0.0


func add_heat(amount: int) -> void:
	heat = clampi(heat + amount, 0, MAX_HEAT)


func is_raid_risk() -> bool:
	return heat >= RAID_HEAT_THRESHOLD


func apply_surgery_payout(payout: int, overclocked: bool) -> void:
	credits += payout
	reputation += 1
	if overclocked:
		add_heat(15)


func save_game() -> void:
	var data := {
		"credits": credits,
		"stolen_tech": stolen_tech,
		"heat": heat,
		"reputation": reputation,
		"unlocked_blueprints": unlocked_blueprints,
		"owned_cards": owned_cards,
		"shop_upgrades": shop_upgrades,
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("Neon Chop Shop: could not open save file for writing.")
		return
	file.store_string(JSON.stringify(data, "\t"))
	file.close()


func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("Neon Chop Shop: could not open save file for reading.")
		return
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	file.close()
	if typeof(parsed) != TYPE_DICTIONARY:
		push_error("Neon Chop Shop: save file is corrupt, keeping defaults.")
		return
	var data: Dictionary = parsed
	credits = int(data.get("credits", credits))
	stolen_tech = int(data.get("stolen_tech", stolen_tech))
	heat = int(data.get("heat", heat))
	reputation = int(data.get("reputation", reputation))
	unlocked_blueprints.assign(data.get("unlocked_blueprints", unlocked_blueprints))
	owned_cards.assign(data.get("owned_cards", owned_cards))
	shop_upgrades.assign(data.get("shop_upgrades", shop_upgrades))
