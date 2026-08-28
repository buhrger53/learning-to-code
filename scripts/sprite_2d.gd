extends Sprite2D


## speed in units ps
var speed: int = 400
## rotation speed in radians ps
var angular_speed: float = PI
## variable to apply velocity to position
var velocity: Vector2
## is the direction 1 or -1
var direction: Vector2

# runs on initiation of the Sprite2D node
func _init() -> void: 
	# idk
	print("hello world")

# runs every frame
func _process(delta: float) -> void: 
	velocity = Vector2.ZERO
	
	for string: StringName in ["ui_left", "ui_right", "ui_up", "ui_down"]:
		match string:
			"ui_left":
				direction = Vector2.LEFT
			"ui_right":
				direction = Vector2.RIGHT
			"ui_up":
				direction = Vector2.UP
			"ui_down":
				direction = Vector2.DOWN
		if Input.is_action_pressed(string):
			velocity = direction * speed
	
	
	
	position += velocity * delta

func _unhandled_input(event: InputEvent) -> void:
	print("event gotten")
	# what was the other way to uh get the things?
	if event.as_text() == "Alt":
		print("alt pressed")
	if event is InputEventKey:
		handle_keys(event)

func handle_keys(key: InputEventKey) -> void:
	match key.keycode:
		KEY_SPACE when key.pressed:
			print("space")
		KEY_SPACE when not key.pressed:
			print("unspace")
