class_name Player

extends Area2D


signal hit

enum LeftRightLook {
	LEFT = -1,
	RIGHT =  1,
}
var left_right_look: LeftRightLook = LeftRightLook.RIGHT


## speed variable that can be changed in inspector
## i have to read the style guide
## maybe?
## i could just use a linter
@export var speed: int = 400

var screen_size: Vector2
## the direction because vector2 that we move
## it's length is unit
## because of later code
var move_direction: Vector2

var velocity: Vector2

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	screen_size = get_viewport_rect().size

## random variable for animation stuff
var last_velocity: Vector2 = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.ZERO

	move_direction = Input.get_vector(
			"move_left", "move_right", 
			"move_up", "move_down"
	).normalized();
	if move_direction.length() > 0:
		velocity = move_direction * speed
		if animated_sprite_2d: animated_sprite_2d.play()
	else:
		if animated_sprite_2d: animated_sprite_2d.stop()
	
	## dookie
	## braindead logic
	## why did this work?
	if (
		(last_velocity == Vector2.ZERO or last_velocity.x != 0)
		and velocity != Vector2.ZERO and velocity.x != 0
	):
		if velocity.x < 0:
			left_right_look = LeftRightLook.LEFT
		else:
			left_right_look = LeftRightLook.RIGHT

	## backup
	if velocity == Vector2.ZERO and last_velocity != Vector2.ZERO and last_velocity.x != 0:
		if last_velocity.x < 0:
			left_right_look = LeftRightLook.LEFT
		else:
			left_right_look = LeftRightLook.RIGHT

	if velocity == Vector2.ZERO:
		animated_sprite_2d.animation = "walk"
		animated_sprite_2d.flip_v = false
		if left_right_look == -1:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
	
	if animated_sprite_2d:
		if velocity.x != 0:
			animated_sprite_2d.animation = "walk"
			animated_sprite_2d.flip_v = false
			# left
			animated_sprite_2d.flip_h = velocity.x < 0
		elif velocity.y != 0:
			animated_sprite_2d.animation = "up"
			animated_sprite_2d.flip_h = false
			# down
			animated_sprite_2d.flip_v = velocity.y > 0

	
	position += velocity * delta
	position.clamp(Vector2.ZERO, screen_size)
	
	last_velocity = velocity


func _on_body_entered(_body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionPolygon2D.set_deferred("disabled", true)

func start(pos: Vector2) -> void:
	position = pos
	show()
	$CollisionPolygon2D.disabled = false
