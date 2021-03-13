extends Node

var level_01 = preload("res://Scenes/Levels/Level01.tscn").instance()

var is_level_01_collectible_held = false

func _ready():
	get_tree().get_root().add_child(level_01)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().get_root().add_child(level_01)
