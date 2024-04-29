extends Node3D

## Speichere die Referenz zu zwei Scenes mit Tiles der Größe 3x3 darin:
const TILE_01 = preload("res://prefabs/tile_01.tscn")
const TILE_02 = preload("res://prefabs/tile_02.tscn")

## Definiere die Breite des zu generierenden Levels
@export var width = 8
## Und die Höhe
@export var length = 8

## Ein Array enthält mehr als eine Variable; angesprochen werden die einzelnen
## Elemente eines Arrays mittels my_array[index]
var tiles: Array

func _input(event: InputEvent) -> void:
	# Kreiere ein neues Level wann immer die Taste T gedrückt wird
	if event is InputEventKey and event.keycode == KEY_T and event.pressed:
		create_level()

func _ready() -> void:
	create_level()

func create_level():
	# Lösche die vorherigen Tiles
	for t in tiles:
		t.queue_free()
	tiles.clear()
	
	for z in length:
		for x in width:
			
			# Speichere die Referenz auf eines der obigen Tiles (zufällig ausgewählt) ...
			var tile_prefab
			if randi_range(0, 4) == 0: tile_prefab = TILE_01
			else: tile_prefab = TILE_02
			
			# Ein Schachbrett-Muster!
			# % ist der Modulo Operator, der den Rest einer Teilung zurückgibt
			#var tile_prefab
			#if (x + z) % 2 == 0: tile_prefab = TILE_01
			#else: tile_prefab = TILE_02
			
			# Alternative Kurzform für einfache if-else-Abfrage
			#var tile_prefab = TILE_01 if (x + z) % 2 == 0 else TILE_02
			
			# Instanziiere das Tile und hänge es in die Hierarche
			var tile = tile_prefab.instantiate()
			add_child(tile)
			# Setze die richtige Position
			tile.position.x = x * 3.1 - (width * 3.1) / 2.0
			tile.position.z = z * 3.1 - (length * 3.1) / 2.0
			# Um bei erneuterer Levelgenerierung das erstelle Tile löschen zu
			# können, speichern wir die Referenz darauf im Array "tiles"
			tiles.push_back(tile)
