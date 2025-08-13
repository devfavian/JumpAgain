extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:			#it happens when the game start
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		#it happens in everyframe
	position.x -= 100*delta
