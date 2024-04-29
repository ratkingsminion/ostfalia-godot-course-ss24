extends CharacterBody2D

## Dieser "Character Controller" (Code und mehr, was die Spielfigur steuert) basiert
## auf dem üblichen Template von Godot, sobald man ein Script für einen CharacterBody2D
## erstellt. Zusätzlich manipulieren wir noch die Animation des 2D-Sprites, angesteuert
## über den AnimationPlayer in der Hierarchy der Player2D-Szene.

# Identifier mit "const" davor sind unveränderbare Werte, werden aber ansonsten wie Variablen benutzt
const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * SPEED
		anim.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.5)
		anim.play("idle")
	
	# Damit das Sprite in die richtige Richtung guckt, flippen wir es je nachdem
	# in welche Richtung wir die Figur steuern.
	if direction < 0: sprite.flip_h = true
	elif direction > 0: sprite.flip_h = false

	# Verschiebe Objekte im Weg - und nur, wenn man sich auf dem Boden befindet.
	if is_on_floor():
		# move_and_collide testet eine eventuelle Kollision in die angegebene
		# Richtung - das Ergebnis gibt uns den "angestoßenen" Collider zurück,
		# den wir nun anstupsen können via apply_force
		var result := move_and_collide(velocity * delta, true)
		if result and result.get_collider() is RigidBody2D:
			var rb := result.get_collider() as RigidBody2D
			rb.apply_force(velocity * 20)

	# Dieser Befehl muss am Ende ausgeführt werden, damit das velocity-Property dieses
	# Scripts auch berücksichtigt wird - die Figur wird verschoben und kollidiert mit
	# anderen physikalischen Objekten in der Szene.
	move_and_slide()
