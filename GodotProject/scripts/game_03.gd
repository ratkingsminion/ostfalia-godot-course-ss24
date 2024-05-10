class_name Game
extends Node2D

## Eine Überklasse, welche einzelne Spielelemente sammelt, beispielsweise den
## aktuellen Highscore. Da die Klasse nur ein einziges Mal instantiiert wird und
## am Root-Objekt der Game03-Szene hängt, können wir eine statische instance
## Variable definieren und von überallher auf diese Zugreifen

# static bedeutet, dass die Variable zur Klasse gehört und nicht zum Objekt
static var instance: Game

var highscore_counter = 0

# Ein selbst definiertes Signal
signal highscore_increased(highscore: int)

###

## _init ist der so genannte Konstruktor und wird vor _ready aufgerufen.
## Wichtig ist, dass hier der SzeneTree noch nicht existiert, aber es ist
## erlaubt, auf das eigenen Objekt mittels self zuzugreifen.
func _init() -> void:
	instance = self

## Diese Funktion erhöht den Highscore und sendet an das Signal highscore_increased
## den neuen counter; alle anderen Scripts, die sich mittels
## 		highscore_increased.connect()
## an dieses Signal "drangehangen" haben, bekommen die Nachricht vom neuen Highscore.
func increase_counter(add: int):
	highscore_counter += add
	highscore_increased.emit(highscore_counter)
