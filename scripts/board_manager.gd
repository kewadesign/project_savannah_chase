extends Node3D

# Pfade zu den Figuren-Szenen
const LION_SCENE_PATH = "res://lion.tscn"
const GIRAFFE_SCENE_PATH = "res://giraffe.tscn"
const GAZELLE_SCENE_PATH = "res://gazelle.tscn"

# Materialien für die Figuren
const WHITE_MATERIAL_PATH = "res://materials/figure_white.tres"
const BLACK_MATERIAL_PATH = "res://materials/figure_black.tres"

# Referenzen
var white_material: Material
var black_material: Material

# Spielbrett-Größe (7x7)
const BOARD_SIZE = 7

# Figuren-Array zum Speichern aller platzierten Figuren
var pieces = []
# 2D-Array zur Speicherung der Figuren auf dem Brett
var board = []

# Zeigt an, welcher Spieler am Zug ist (true = weiß, false = schwarz)
var is_white_turn = true

# Called when the node enters the scene tree for the first time.
func _ready():
	# Brett-Array initialisieren
	initialize_board_array()
	
	# Materialien laden
	load_materials()
	
	# Figuren in Startposition platzieren
	setup_new_game()

# Initialisiert ein leeres Brett-Array
func initialize_board_array():
	# Zurücksetzen des board-Arrays
	board = []
	for x in range(BOARD_SIZE):
		board.append([])
		for y in range(BOARD_SIZE):
			board[x].append(null)

# Lädt die Materialien für weiße und schwarze Figuren
func load_materials():
	white_material = load(WHITE_MATERIAL_PATH)
	black_material = load(BLACK_MATERIAL_PATH)
# Setzt das Spiel auf den Anfangszustand zurück
func setup_new_game():
	# Alte Figuren entfernen (falls vorhanden)
	clear_pieces()
	
	# Brettarray zurücksetzen
	initialize_board_array()
	
	# Weiß beginnt
	is_white_turn = true
	
	# Weiße Figuren platzieren (Spieler)
	# Giraffen
	place_piece(GIRAFFE_SCENE_PATH, true, 2, 0) # c1
	place_piece(GIRAFFE_SCENE_PATH, true, 4, 0) # e1
	
	# Löwe (König)
	place_piece(LION_SCENE_PATH, true, 3, 0) # d1
	
	# Gazellen (Bauern)
	place_piece(GAZELLE_SCENE_PATH, true, 1, 1) # b2
	place_piece(GAZELLE_SCENE_PATH, true, 2, 1) # c2
	place_piece(GAZELLE_SCENE_PATH, true, 3, 1) # d2
	place_piece(GAZELLE_SCENE_PATH, true, 4, 1) # e2
	place_piece(GAZELLE_SCENE_PATH, true, 5, 1) # f2
	
	# Schwarze Figuren platzieren (KI)
	# Giraffen
	place_piece(GIRAFFE_SCENE_PATH, false, 2, 6) # c7
	place_piece(GIRAFFE_SCENE_PATH, false, 4, 6) # e7
	
	# Löwe (König)
	place_piece(LION_SCENE_PATH, false, 3, 6) # d7
	
	# Gazellen (Bauern)
	place_piece(GAZELLE_SCENE_PATH, false, 1, 5) # b6
	place_piece(GAZELLE_SCENE_PATH, false, 2, 5) # c6
	place_piece(GAZELLE_SCENE_PATH, false, 3, 5) # d6
	place_piece(GAZELLE_SCENE_PATH, false, 4, 5) # e6
	place_piece(GAZELLE_SCENE_PATH, false, 5, 5) # f6
	
	print("Neue Spielrunde gestartet!")

# Platziert eine Figur auf dem Brett
func place_piece(piece_scene_path: String, is_white: bool, x: int, y: int):
	# Szene laden und instanziieren
	var piece_scene = load(piece_scene_path)
	if piece_scene == null:
		print("FEHLER: Figurenszene konnte nicht geladen werden: " + piece_scene_path)
		return
		
	var piece_instance = piece_scene.instantiate()
	if piece_instance == null:
		print("FEHLER: Figureninstanz konnte nicht erstellt werden.")
		return

	# Figur zum Szenebaum hinzufügen, zum Pieces Node falls vorhanden
	var pieces_node = get_node("../Pieces")
	if pieces_node:
		pieces_node.add_child(piece_instance)
	else:
		get_tree().root.add_child(piece_instance)
		print("WARNUNG: Pieces-Node nicht gefunden, Figur wurde zur Hauptszene hinzugefügt")

	# Material basierend auf Spielerfarbe setzen
	var mesh_instance = piece_instance.get_node("Mesh")
	if is_white:
		mesh_instance.set_surface_override_material(0, white_material)
	else:
		mesh_instance.set_surface_override_material(0, black_material)

	# Position auf dem Brett setzen
		# Konvertiere Brettkoordinaten (x,y) in 3D-Koordinaten
		# GridMap Position: (-3.5, -0.5, -3.5), CellSize: 1x0.1x1
	piece_instance.global_position = Vector3(x - 3.5, 0.1, y - 3.5)

	# Figur im Brett-Array speichern
	board[x][y] = piece_instance

	# Figur zur Liste hinzufügen
	pieces.append(piece_instance)

# Entfernt alle Figuren vom Brett
func clear_pieces():
	for piece in pieces:
		piece.queue_free()
	pieces.clear()