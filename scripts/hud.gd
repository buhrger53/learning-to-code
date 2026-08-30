class_name HUD
extends CanvasLayer


signal start_game


@onready var start_button := $StartButton as Button
@onready var message := $Message as Label
@onready var message_timer := $MessageTimer as Timer
@onready var score_label := $Score as Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button.show()

## why does this function exist?
func show_message(text: String) -> void:
	message.text = text
	message.show()
	message_timer.start()


func show_game_over() -> void:
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await message_timer.timeout

	message.text = "scribidi"
	message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	start_button.show()

func update_score(score: int) -> void:
	score_label.text = str(score)

func _on_start_button_pressed() -> void:
	start_button.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	message.hide()
