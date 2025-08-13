extends CharacterBody2D


const JUMP_VELOCITY = -300.0

signal hit
var is_crouching = false
@onready var col_walk := $CollisionUp
@onready var col_crouch := $CollisionCrouch

func _physics_process(delta: float) -> void:		#repeat during the game execution
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#else:
		#$AnimatedSprite2D.play("run")

	# Handle jump.
	if Input.is_action_just_pressed("sxclick") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")
		
	if Input.is_action_pressed("dxclick") and not is_crouching and is_on_floor():
		_enter_crouch()
	elif not Input.is_action_pressed("dxclick") and is_crouching and is_on_floor():
		_exit_crouch()
	
	if is_on_floor():
		if is_crouching:
			$AnimatedSprite2D.play("down")
		elif velocity.y >= 0.0:
			$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("jump")


	move_and_slide()

	var collision = get_last_slide_collision()
	if collision:
		if collision.get_collider() is CharacterBody2D:
			hit.emit()

func _enter_crouch() -> void:
	is_crouching = true
	col_walk.disabled = true
	col_crouch.disabled = false

func _exit_crouch() -> void:
	is_crouching = false
	col_walk.disabled = false
	col_crouch.disabled = true
