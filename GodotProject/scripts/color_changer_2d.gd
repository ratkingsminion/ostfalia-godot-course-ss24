extends Area2D

## Ein kleines Test-Script, das die Farbe (via modulate) aller dynamischen Objekte verändert,
## die in die Area2D, an die dieses Script gehangen wurde, eindringen. Dies geschieht über die
## SIGNALS body_entered und body_exited.

func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body is RigidBody2D or body is CharacterBody2D:
		body.modulate = Color.GREEN

func _on_body_exited(body: Node2D) -> void:
	if body is RigidBody2D or body is CharacterBody2D:
		body.modulate = Color.WHITE
