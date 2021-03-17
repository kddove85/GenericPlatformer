extends Node

var scene_to_delete
var next_scene

var fade_screen
var splash
var menu
var world
var current_level
var collectibles_obtained = {}

func _ready():
	fade_screen = load("res://Scenes/GUI/FadeScreen.tscn").instance()
	fade_screen.connect("switch_scene", self, "on_switch_scene")
	get_tree().get_root().call_deferred("add_child", fade_screen)
	
	splash = load("res://Scenes/GUI/Splash.tscn").instance()
	splash.connect("splash_complete", self, "on_splash_complete")
	get_tree().get_root().call_deferred("add_child", splash)

func on_switch_scene():
	get_tree().get_root().get_node(scene_to_delete).queue_free()
	get_tree().get_root().call_deferred("add_child", next_scene)
	
func on_splash_complete():
	menu = load("res://Scenes/GUI/GameMenu.tscn").instance()
	menu.connect("start_game", self, "on_start_game")
	menu.connect("load_game", self, "on_load_game")
	menu.connect("load_options", self, "on_load_options")
	menu.connect("quit_game", self, "on_quit_game")
	next_scene = menu
	scene_to_delete = splash.name
	fade_screen.fade_out()
	
func on_start_game():
	# if your game has an overworld and you start there, use this code
#	world = load("res://Scenes/World/World.tscn").instance()
#	next_scene = world
	
	# else use this
	scene_to_delete = menu.name
	enter_level("01")
	fade_screen.fade_out()
	
func on_load_game():
	pass
	
func on_load_options():
	pass
	
func on_quit_game():
	get_tree().quit()
	
#func on_menu_complete():
#	menu.queue_free()

func on_load_level():
	enter_level("01")
	
func enter_level(name):
	if current_level:
		scene_to_delete = current_level
		
	current_level = load("res://Scenes/Levels/Level" + name + ".tscn").instance()
	next_scene = current_level
	fade_screen.fade_out()
	
#	if not collectibles_obtained[name]:
#		current_level.spawn_collectible()
