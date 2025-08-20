extends Node

@export var enemy_scenes: Array[PackedScene]
var score = 0
var is_pause = false
var gameover = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/PauseMenu.visible = false # Replace with function body.
	gameover = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc") and not gameover:
		$HUD/PauseMenu/Options.visible = false
		if not is_pause:
			$HUD/PauseMenu.visible = true
			is_pause = true
			get_tree().paused = true

func _on_enemy_timer_timeout() -> void:
	var enemy_scene = enemy_scenes.pick_random()
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.position = Vector2(152, 165)
	if enemy_instance.name == "Eagle":
		enemy_instance.position.y -= 25
	elif enemy_instance.name == "Vulture":
		enemy_instance.position.y -= 40
	add_child(enemy_instance)
	pass # Replace with function body.


func _on_player_hit() -> void:
	gameover = true
	$ScoreTimer.stop()
	$HUD/Score.hide()
	$HUD/FinalMessage.show()
	$HUD/FinalScore.text = str(score)
	$HUD/FinalScore.show()
	$BackgroundMusic.pitch_scale = 0.4
	Engine.time_scale = 0.1
	await get_tree().create_timer(3 * Engine.time_scale).timeout
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD/Score.text = str(score)


func _on_speed_increase_timeout() -> void:
	Engine.time_scale += 0.01


func _on_resume_pressed() -> void:
	$HUD/PauseMenu.visible = false
	is_pause = false
	get_tree().paused = false

func _on_options_pressed() -> void:
	$HUD/PauseMenu/MainButtons.visible = false
	$HUD/PauseMenu/Options.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_back_options_pressed() -> void:
	$HUD/PauseMenu/Options.visible = false
	$HUD/PauseMenu/MainButtons.visible = true
