extends CanvasLayer

signal switch_scene()

onready var fade_player = $Control/AnimationPlayer

var origin_scene : SceneTree
var destination_scene : SceneTree
var is_reload_scene_call = false

func fade_out():
	fade_player.play("FadeOut")
	get_tree().paused = true

func go_to_scene(var target : SceneTree, previous_scene: SceneTree):
	destination_scene = target
	origin_scene = previous_scene
	fade_player.play("FadeOut")
	get_tree().paused = true
	
func reload_scene():
	fade_player.play("FadeOut")
	get_tree().paused = true
	is_reload_scene_call = true #To let fader know we're reloading scene

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeOut":
		emit_signal("switch_scene")
		fade_player.play("FadeIn")
	if anim_name == "FadeIn":
		get_tree().paused = false

func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "FadeIn":
		get_tree().paused = true
