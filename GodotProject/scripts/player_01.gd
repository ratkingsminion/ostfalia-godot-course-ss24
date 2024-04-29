extends Node3D

## Bewege ein Flugzeug anhand von 6 Actions (siehe Projekteinstellungen -> Input Actions)
## mittels _process()-Funktion

@export var move_speed = 5.0
@export var rotate_speed = 180.0

func _process(delta: float) -> void:
	## "basis" ist eine Matrix, welche das lokale Koordinationssystem des
	## Node3D definiert (Rotation und Skalierung)
	var forward_vector = basis.z
	var right_vector = basis.x
	
	## Frage ab, ob die zu den zur Action zugehörigen Tasten gedrückt wurden -
	## wenn ja, ändere die Position bzw. Rotation
	
	if Input.is_action_pressed("move_forward"):
		position += forward_vector * move_speed * delta
	elif Input.is_action_pressed("move_back"):
		position -= forward_vector * move_speed * delta
	if Input.is_action_pressed("move_right"):
		position -= right_vector * move_speed * delta
	elif Input.is_action_pressed("move_left"):
		position += right_vector * move_speed * delta

	if Input.is_action_pressed("rotate_left"):
		rotation_degrees.y += rotate_speed * delta
	elif Input.is_action_pressed("rotate_right"):
		rotation_degrees.y -= rotate_speed * delta
