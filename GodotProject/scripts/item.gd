extends Area2D

## Ein einfaches Item, das der Spieler einsammeln kann

func _on_body_entered(body: Node2D) -> void:
	# Mittels Groups können wir einzelne Objekte voneinander leicht unterscheiden
	if body.is_in_group("player"):
		Game.instance.increase_counter(1)
		queue_free()
