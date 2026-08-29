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
	get_tree().call_group("enemies", "queue_free")
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("ready up")


func _on_enemy_timer_timeout() -> void:
	## i don't know the type
	var enemy: RigidBody2D = enemy_scene.instantiate()
	
	var spawn_location: PathFollow2D = $EnemyPath/EnemySpawnLocation
	
	spawn_location.progress_ratio = randf()
	
	enemy.position = spawn_location.position
	
	var direction: float = spawn_location.rotation + PI / 2
	
	if enemy.position.x < 60 or enemy.position.x > 420:
		if enemy.position.y > 360:
			direction += randf_range(0, PI / 4)
		else:
			direction += randf_range(-PI / 4, 0)
	else:
		direction += randf_range(-PI / 8, PI / 8)
	#direction += randf_range(-PI / 4, PI / 4)
	
	enemy.rotation = direction
	
	var velocity: Vector2 = Vector2(randf_range(100.0, 300.0), 0.0)
	
	# it seems linear_velocity has absolute direction
	# possibly from its parent
	# since it doesn't seem to be affected by rotation
	# i think
	enemy.linear_velocity = velocity.rotated(direction)
	
	add_child(enemy)


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$EnemyTimer.start()
	$ScoreTimer.start()
