extends Node

# Referenz auf den Board Manager
var board_manager

# Called when the node enters the scene tree for the first time.
func _ready():
	# Board Manager finden
	board_manager = get_node("/root/BoardScene/BoardManager")
	
	if board_manager == null:
		print("FEHLER: BoardManager nicht gefunden!")
		return

# Diese Funktion würde aufgerufen werden, wenn die KI am Zug ist
# Aktuell nur ein Platzhalter, da wir noch keine Zuglogik implementiert haben
func make_move():
	print("KI ist am Zug und überlegt...")
	
	# Hier fügen wir später die Logik für die KI-Züge ein
	# Für jetzt machen wir nichts
	
	# Verzögerung simulieren (1,5 Sekunden)
	await get_tree().create_timer(1.5).timeout
	
	print("KI hat ihren Zug gemacht")
	
	# Signal senden, dass der Zug abgeschlossen ist
	# Dies würde später implementiert werden
