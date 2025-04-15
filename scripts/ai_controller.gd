# This script remains unchanged as per the instruction.
extends Node

# Reference to the Board Manager
var board_manager

# Called when the node enters the scene tree for the first time
func _ready():
	# Find Board Manager
	board_manager = get_node("/root/BoardScene/BoardManager")
	
	if board_manager == null:
		print("ERROR: BoardManager not found!")
		return

# This function would be called when it's the AI's turn
# Currently a placeholder as we haven't implemented the move logic yet
func make_move():
	print("AI's turn, thinking...")
	
	# AI move logic will be added here later
	# We're doing nothing for now
	
	# Simulate delay (1.5 seconds)
	await get_tree().create_timer(1.5).timeout
	
	print("AI has made its move")
