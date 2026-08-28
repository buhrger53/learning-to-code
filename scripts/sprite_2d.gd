extends Sprite2D


## speed in units ps
var speed: int = 400
## rotation speed in radians ps
var angular_speed: float = PI
## variable to apply velocity to position
var velocity: Vector2 = Vector2.ZERO

var timer_time_check_amount_seconds: float = 0

var uprightdownleft: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

# runs on initialization of the Sprite2D node
func _init() -> void: 
	# idk
	print("hello world")

func _ready() -> void:
	var timer: Node = get_node("Timer")
	if not timer: return
	timer.timeout.connect(_on_timer_timeout)


# runs every frame
func _process(delta: float) -> void:
	uprightdownleft = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = uprightdownleft.normalized()
	
	
	
	
	position += velocity * speed * delta


func _on_button_pressed() -> void:
	set_process(not is_processing())


func _on_timer_timeout() -> void:
	visible = not visible
