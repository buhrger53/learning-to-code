class_name Enemy

extends RigidBody2D

@onready var animated_sprite_2d := $AnimatedSprite2D as AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemy_types: Array = Array(animated_sprite_2d.sprite_frames.get_animation_names())
	animated_sprite_2d.animation = enemy_types.pick_random()
	animated_sprite_2d.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

## pretty wacky name
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
