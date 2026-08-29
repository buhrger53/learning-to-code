extends Area2D


signal hit


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

	if velocity == Vector2.ZERO:
		animated_sprite_2d.animation = "walk"
		animated_sprite_2d.flip_v = false
	
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


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos: Vector2) -> void:
	position = pos
	show()
	$CollisionShape2D.disabled = false
