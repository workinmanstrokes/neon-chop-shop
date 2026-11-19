extends Control
## Root scene controller: title screen, Chop Shop hub navigation,
## and scene switching between the hub and the surgery table.

const SURGERY_SCENE: PackedScene = preload("res://scenes/surgery.tscn")

@onready var title_screen: VBoxContainer = $TitleScreen
@onready var hub: VBoxContainer = $Hub
@onready var status_label: Label = $Hub/StatusLabel
@onready var heist_button: Button = $Hub/HeistButton
@onready var shop_button: Button = $Hub/ShopButton

var _surgery_instance: Control = null


func _ready() -> void:
	$TitleScreen/PlayButton.pressed.connect(_on_play_pressed)
	$TitleScreen/ContinueButton.pressed.connect(_on_continue_pressed)
	$Hub/SurgeryButton.pressed.connect(_on_surgery_pressed)
	$Hub/BackButton.pressed.connect(_on_back_pressed)
	heist_button.pressed.connect(_on_not_ready_pressed.bind("Heist map"))
	shop_button.pressed.connect(_on_not_ready_pressed.bind("Upgrades & 3D-Print"))
	show_title()


func show_title() -> void:
	title_screen.visible = true
	hub.visible = false
	_free_surgery()


func show_hub() -> void:
	title_screen.visible = false
	hub.visible = true
	_free_surgery()
	_refresh_status()


func _refresh_status() -> void:
	status_label.text = "Credits: %d  |  Tech: %d  |  Heat: %d%%  |  Rep: %d" % [
		GameState.credits, GameState.stolen_tech, GameState.heat, GameState.reputation
	]


func _on_play_pressed() -> void:
	GameState.start_new_run()
	show_hub()


func _on_continue_pressed() -> void:
	GameState.load_game()
	show_hub()


func _on_surgery_pressed() -> void:
	_free_surgery()
	_surgery_instance = SURGERY_SCENE.instantiate()
	_surgery_instance.surgery_finished.connect(_on_surgery_finished)
	add_child(_surgery_instance)
	title_screen.visible = false
	hub.visible = false


func _on_surgery_finished(_success: bool) -> void:
	show_hub()


func _on_back_pressed() -> void:
	show_title()


func _on_not_ready_pressed(feature_name: String) -> void:
	status_label.text = "%s is not wired up yet — milestone 3/5." % feature_name


func _free_surgery() -> void:
	if _surgery_instance != null and is_instance_valid(_surgery_instance):
		_surgery_instance.queue_free()
	_surgery_instance = null
