gdscript
extends Node

var piece_base = preload("res://scripts/piece_base.gd")
var piece_base_instance

func _ready():
    piece_base_instance = piece_base.new()  # Instantiate piece_base
    piece_base_instance.piece_type = "giraffe"  # Set the type of the piece
    # piece_base_instance.is_white =  # Set is_white - you'll likely need to pass this in or determine it another way
    #  You'll need to connect signals here if you want to use the piece_base's signals, e.g.:
    # piece_base_instance.piece_selected.connect(self._on_piece_selected)
    add_child(piece_base_instance) #add as a child so it exists in the scene

# Example of signal connection (you'll need to define this function):
#func _on_piece_selected(piece):
#    # Your logic here
#    pass