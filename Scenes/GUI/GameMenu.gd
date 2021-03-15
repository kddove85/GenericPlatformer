extends Control

signal start_game()
signal load_game()
signal load_options()
signal quit_game()

onready var start_game = $VBoxContainer/StartGame

func _ready():
	start_game.grab_focus()

func _on_StartGame_pressed():
	emit_signal("start_game")
	
func _on_LoadGame_pressed():
	pass # Replace with function body.

func _on_Options_pressed():
	pass # Replace with function body.

func _on_QuitGame_pressed():
	emit_signal("quit_game")
