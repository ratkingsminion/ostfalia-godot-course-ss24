extends Node3D

## Drehe den Spieler anhand der Mausbewegung

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate(basis.y, event.relative.x * -0.01)
		rotate(basis.x, event.relative.y * 0.01)
