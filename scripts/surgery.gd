extends Control
## Surgery table: drag-and-drop implant placement.
## Drag the implant into the highlighted body slot. A correct drop scores
## the surgery; dropping outside the slot fails it. Overclocking pays more
## but raises heat and malfunction chance.
##
## Milestone 1 skeleton: one client, one implant, one slot, pass/fail
## and payout. Wiring and chip-alignment puzzles land in milestone 2.

signal surgery_finished(success: bool)

const BASE_PAYOUT := 120
const OVERCLOCK_BONUS := 80
const OVERCLOCK_MALFUNCTION_CHANCE := 0.25

var _dragging: bool = false
var _drag_offset: Vector2 = Vector2.ZERO
var _implant_home: Vector2 = Vector2.ZERO
var _overclocked: bool = false
var _last_result: bool = false

@onready var implant: Panel = $Implant
@onready var slot: Panel = $BodySlot
@onready var result_label: Label = $ResultLabel
@onready var overclock_button: Button = $OverclockButton
@onready var finish_button: Button = $FinishButton


func _ready() -> void:
	_implant_home = implant.position
	overclock_button.pressed.connect(_on_overclock_pressed)
	finish_button.pressed.connect(_on_finish_pressed)
	result_label.text = "Client: Vex-9 — faulty optic chip. Drag the OPTIC CHIP into the glowing slot."


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and implant.get_global_rect().has_point(event.global_position):
			_dragging = true
			_drag_offset = implant.global_position - event.global_position
		elif not event.pressed and _dragging:
			_dragging = false
			_resolve_drop()
	elif event is InputEventMouseMotion and _dragging:
		implant.global_position = event.global_position + _drag_offset


func _resolve_drop() -> void:
	var implant_center: Vector2 = implant.get_global_rect().get_center()
	if slot.get_global_rect().has_point(implant_center):
		implant.position = slot.position + (slot.size - implant.size) * 0.5
		_complete_surgery(true)
	else:
		implant.position = _implant_home
		result_label.text = "Missed the slot — implant back on the tray. Try again."


func _complete_surgery(success: bool) -> void:
	var payout: int = BASE_PAYOUT
	if _overclocked:
		payout += OVERCLOCK_BONUS
		if randf() < OVERCLOCK_MALFUNCTION_CHANCE:
			payout = payout / 2
			result_label.text = "MALFUNCTION! Overclock fried the chip. Payout halved: %d cr. Heat +15." % payout
			GameState.apply_surgery_payout(payout, true)
			_end_surgery(false)
			return
	if success:
		result_label.text = "Surgery complete. Client paid %d cr.%s" % [
			payout, " (overclocked — heat +15)" if _overclocked else ""
		]
		GameState.apply_surgery_payout(payout, _overclocked)
	else:
		result_label.text = "Surgery failed. No payout."
	_end_surgery(success)


func _end_surgery(success: bool) -> void:
	_last_result = success
	GameState.save_game()
	overclock_button.disabled = true
	finish_button.visible = true


func _on_overclock_pressed() -> void:
	_overclocked = not _overclocked
	overclock_button.text = "OVERCLOCK: ON (+%d cr, +heat, malfunction risk)" % OVERCLOCK_BONUS if _overclocked else "OVERCLOCK: OFF"


func _on_finish_pressed() -> void:
	surgery_finished.emit(_last_result)
