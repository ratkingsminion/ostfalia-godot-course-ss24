extends AnimatableBody2D

## Die Plattform muss kein Script haben, das jeden Frame (via _process) die Position verändert -
## dies erledigt der AnimationPlayer für uns! Darum reicht es, die Animationen nur bei Start
## einmal aufzurufen (in _ready)

@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim.play("up_and_down")
