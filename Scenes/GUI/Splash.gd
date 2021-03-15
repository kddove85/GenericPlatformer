extends Control

signal splash_complete()

onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("PoweredByGodot")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "PoweredByGodot":
		animation_player.play("Doveware")
	if anim_name == "Doveware":
		emit_signal("splash_complete")
