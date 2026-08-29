extends Node

@export var enemy_scene: PackedScene
var score: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#new_game()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	$HUD.show_game_over()

func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("ready up")


func _on_enemy_timer_timeout() -> void:
	## i don't know the type
	var enemy: RigidBody2D = enemy_scene.instantiate()
	
	var spawn_location: PathFollow2D = $EnemyPath/EnemySpawnLocation
	
	spawn_location.progress_ratio = randf()
	
	enemy.position = spawn_location.position
	
	var direction: float = spawn_location.rotation + PI / 4
	
	direction += randf_range(-PI / 4, PI / 4)
	
	enemy.rotation = direction
	
	var velocity: Vector2 = Vector2(randf_range(150.0, 250.0), 0.0)
	
	enemy.linear_velocity = velocity.rotated(direction)
	
	add_child(enemy)


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$EnemyTimer.start()
	$ScoreTimer.start()
