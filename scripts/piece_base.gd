extends StaticBody3D

# Eigenschaften der Figur
var is_white = false  # Gibt an, ob die Figur weiß (true) oder schwarz (false) ist
var board_position = Vector2i(-1, -1)  # Position auf dem Brett (x, y)
var piece_type = "base"  # Typ der Figur (wird in abgeleiteten Klassen überschrieben)

# Signale
signal piece_selected(piece)
signal piece_moved(piece, from_pos, to_pos)
signal piece_captured(piece)

# Referenzen
var board_manager

# Visuelle Eigenschaften
var highlight_material = null
var original_material = null
var mesh_instance = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Mesh-Instance finden
	mesh_instance = get_node("Mesh")
	if mesh_instance == null:
		print("FEHLER: Mesh-Instance nicht gefunden in piece_base!")
	
	# Input-Handling aktivieren
	# In Godot 4.x müssen wir Signale mit connect() verbinden
	input_event.connect(_on_input_event)
	
	# Board Manager finden
	# Da die Figuren jetzt Kinder des Pieces-Node sind, müssen wir den richtigen Pfad verwenden
	# Je nach Szenenstruktur könnte der Pfad unterschiedlich sein
	var board_manager_path = "/root/BoardScene/BoardManager"
	board_manager = get_node(board_manager_path)
	
	if board_manager == null:
		print("FEHLER: BoardManager nicht gefunden. Überprüfe den Pfad: " + board_manager_path)

# Wird aufgerufen, wenn die Figur angeklickt wird
func _on_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print(piece_type + " wurde angeklickt!")
		
		# Signal senden, dass diese Figur ausgewählt wurde
		emit_signal("piece_selected", self)

# Hebt die Figur hervor (wird aufgerufen, wenn die Figur ausgewählt wird)
func highlight():
	if mesh_instance:
		# Originalmaterial speichern, falls noch nicht geschehen
		if original_material == null:
			original_material = mesh_instance.get_surface_override_material(0)
		
		# Hervorhebungsmaterial anwenden (aus dem BoardManager)
		if board_manager and board_manager.highlight_material:
			mesh_instance.set_surface_override_material(0, board_manager.highlight_material)
		else:
			print("WARNUNG: Highlight-Material nicht verfügbar für " + piece_type)

# Entfernt die Hervorhebung
func unhighlight():
	if mesh_instance and original_material:
		# Originalmaterial wiederherstellen
		mesh_instance.set_surface_override_material(0, original_material)

# Bewegt die Figur zu einer neuen Position auf dem Brett
func move_to(new_board_position: Vector2i):
	var old_position = board_position
	
	# Neue Position speichern
	board_position = new_board_position
	
	# 3D-Position aktualisieren
	# Anmerkung: Ähnlich wie in board_manager.gd müssen wir die 
	# Brettkoordinaten in 3D-Weltkoordinaten umrechnen
	# GridMap Position: (-3.5, -0.5, -3.5), CellSize: 1x0.1x1
	global_position = Vector3(board_position.x - 3.5, 0.1, board_position.y - 3.5)
	
	# Signal senden, dass sich die Figur bewegt hat
	emit_signal("piece_moved", self, old_position, board_position)

# Wird aufgerufen, wenn die Figur geschlagen wird
func capture():
	print(piece_type + " wurde geschlagen!")
	
	# Signal senden, dass die Figur geschlagen wurde
	emit_signal("piece_captured", self)
	
	# Figur aus dem Szenebaum entfernen
	queue_free()
