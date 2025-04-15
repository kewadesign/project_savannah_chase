extends Node

# Referenz auf UI-Elemente
var turn_indicator_label
var game_over_panel

# Referenz auf den Game Manager
var game_manager

# Called when the node enters the scene tree for the first time.
func _ready():
	# UI-Elemente finden (diese müsstest du später in der Szene erstellen)
	# turn_indicator_label = get_node("TurnIndicator/Label")
	# game_over_panel = get_node("GameOverPanel")
	
	# Game Manager finden
	game_manager = get_node("/root/BoardScene/GameManager")
	
	if game_manager == null:
		print("FEHLER: GameManager nicht gefunden!")
		return
	
	# Auf Signale des Game Managers hören
	game_manager.game_started.connect(_on_game_started)
	game_manager.game_over.connect(_on_game_over)
	game_manager.turn_changed.connect(_on_turn_changed)
	
	# UI initialisieren
	# if game_over_panel:
	# 	game_over_panel.visible = false

# Wird aufgerufen, wenn ein neues Spiel startet
func _on_game_started():
	print("UI: Neues Spiel gestartet")
	
	# if game_over_panel:
	# 	game_over_panel.visible = false

# Wird aufgerufen, wenn sich der aktuelle Spieler ändert
func _on_turn_changed(is_white_turn):
	var turn_text = "Weiß (Spieler)" if is_white_turn else "Schwarz (KI)"
	print("UI: Am Zug: " + turn_text)
	
	# if turn_indicator_label:
	# 	turn_indicator_label.text = "Am Zug: " + turn_text

# Wird aufgerufen, wenn das Spiel beendet ist
func _on_game_over(winner_is_white):
	var winner_text = "Weiß (Spieler)" if winner_is_white else "Schwarz (KI)"
	print("UI: Spiel beendet! Gewinner: " + winner_text)
	
	# if game_over_panel:
	# 	game_over_panel.visible = true
	# 	var label = game_over_panel.get_node("WinnerLabel")
	# 	if label:
	# 		label.text = "Gewinner: " + winner_text
