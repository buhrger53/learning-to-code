extends Sprite2D

var speed: int = 400

var angular_speed: float = PI

var velocity: Vector2

# runs on initiation of the Sprite2D node
func _init() -> void: 
	print("hello world")


func _process(delta: float) -> void: 
	rotation += angular_speed * delta
	
	velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
