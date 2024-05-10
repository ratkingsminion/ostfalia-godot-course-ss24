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
var tiles_map: Dictionary = { }

func _input(event: InputEvent) -> void:
	# Kreiere ein neues Level wann immer die Taste T gedrückt wird
	if event is InputEventKey and event.keycode == KEY_T and event.pressed:
		create_level_maze(30)

func _ready() -> void:
	#create_level_checkerboard()
	create_level_maze(20)

func create_tile(pos: Vector3i) -> Node3D:
	# Ein einzelnes Tile erstellen - dieses wird in zwei Datenstrukturen
	# gepackt, um später darauf zurückgreifen zu können
	# Einerseits in tiles_map, einem Dictionary, und in tiles, einem Array
	var tile = TILE_01.instantiate()
	tile.position = pos * 3 # Die Tiles haben die Maße 3x3!
	add_child(tile) # Zum SceneTree hinzufügen, ansonsten bleibt das Tile unsichtba
	tiles_map[pos] = tile # zum Dictionary hinzufügen
	tiles.append(tile) # zum Array hinzufügen
	return tile

func remove_level():
	# Lösche die vorherigen Tiles
	for t in tiles:
		t.queue_free()
	tiles.clear()
	tiles_map.clear()
	
## Der "Maze"-Level-Algo basiert einfach darauf, dass neue Tiles immer Nachbarn von
## alten Tiles sind
func create_level_maze(size: int) -> void:
	remove_level()
	
	create_tile(Vector3i(0, 0, 0)) # Das erste Tile
	
	# Die while-Schleife ist wie ein if, welches immer wieder ausgeführt wird bis
	# die Kondition wahr (true) ist
	while tiles_map.size() < size:
		# aus den Keys des Dictionaries ein zufälliges Element nehmen
		var pos = tiles_map.keys().pick_random()
		
		# einen Nachbarn wählen - auch zufällig
		pos += [ Vector3i.LEFT, Vector3i.RIGHT, Vector3i.FORWARD, Vector3i.BACK, Vector3i.BACK ].pick_random()
		
		# Wenn die neue Position bereits im Dictionary als Key vorhanden ist, dann gehe zurück an den
		# Anfang der while-Schleife
		if pos in tiles_map.keys(): continue
		create_tile(pos)
		
		# Für Debugging-Zwecke warte 0.2 Sekunden, bevor wir weiter machen.
		# create_timer() erstellt einen temporären Timer-Node, welcher sich
		# nach Ablauf der Zeit selbst zerstört - aber vorher noch ein Signal
		# namens "timeout" auslöst.
		# Vorteilhafterweise hält der await-Befehl die Ausführung des Scripts
		# an, bis das Signal ausgelöst wurde.
		await get_tree().create_timer(0.2).timeout

## Der Checkerboard-Algo erstellt ein level mit den Maßen length x width
func create_level_checkerboard():
	remove_level()
	
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
