extends Node3D

## Variablen mit dem Attribut "@export" sind im Inspektor sicht- und veränderbar
@export var curve: Curve
@export var speed = 1.0
@export var limit = 4.0

## Variablen mit dem Attribut "@onready" werden zu Beginn evaluiert
@onready var _start_y = position.y

var _time = 0.0

## Die Funktion _process() wird einmal pro Frame aufgerufen, d.h. ungefähr 60 Mal
## pro Sekunde, falls der Monitor auf 60Hz gestellt ist und VSync aktiviert ist
func _process(delta: float) -> void:
	# Beachtet das "+=", es bedeutet, dass der Wert rects (delta * speed)
	# zur Variable _time hinzugefügt wird und nicht einfach nur zugewiesen
	_time += delta * speed
	
	# Nachfolgend drei Methoden, um die Kugeln hin und her bewegen zu lassen.
	
	# METHODE 1 - ANHAND EINER CURVE-RESOURCE
	# Eine if-Abfrage stellt einen Umstand fest, der wahr oder falsch sein kann.
	# Ist also _time tatsächlich größer als 1.0, dann wird _time wieder um 1.0
	# reduziert. Danach wird die Position entlang der Y-Koordinate so geändert,
	# dass sie einer Kurve (siehe Inspektor) entlang folgt.
	if _time > 1.0: _time -= 1.0
	position.y = _start_y + curve.sample(_time) * limit
	# Kommentiert obige zwei Zeilen aus (mit #), um die unteren zwei Methoden zu
	# testen, indem ihr sie auskommentiert.
	
	# METHODE 2 - ANHAND EINER SINUS-KURVE
	# Die Funktion sin() berechnet eine Sinuskurve und gibt einen Wert zwischen
	# -1 und 1 zurück - siehe auch https://graphtoy.com/
	#position.y = _start_y + sin(_time * speed) * limit
	
	# METHODE 3 - ANHAND EINER IF-ABFRAGE
	# Hier wird einfach nur die Y-Position abgefragt und sie entsprechend in Grenzen
	# gehalten. Wurde die obere oder untere Grenze erreicht, wird die Geschwindigkeit
	# umgedreht (mit -1 multipliziert).
	#if position.y > _start_y + limit:
	#	speed *= -1
	#	position.y = _start_y + limit
	#elif position.y < _start_y - limit:
	#	speed *= -1
	#	position.y = _start_y - limit
