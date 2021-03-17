extends Polygon2D

# Nodes
onready var rtl = $RichTextLabel
onready var aniplayer = $AnimationPlayer

# Enums
enum state {OPENING, ACTIVE, CLOSING, CLOSED}

# Member Variables
onready var current_state = state.CLOSED
onready var page = 0

export (Array) var dialog_entry = [
			{
				"text": "You know? I'm gonna let him go." 
			},
			{
				"text": "Come back tomorrow and bring your friends!" 
			},
		]

func _input(event):
	if dialog_entry != null:
		continue_text(event, dialog_entry)

func start():
	get_tree().paused = true
	open(dialog_entry)
	
func get_text(dialog):
	rtl.set_bbcode(dialog[page]["text"])
	rtl.set_visible_characters(0)
	rtl.set_process_input(true)
	
func open(dialog_entry):
	var previous_state = current_state
	if previous_state == state.CLOSED:
		aniplayer.play("Open")
		current_state = state.OPENING
		
func continue_text(event, dialog):
	var previous_state = current_state
	if previous_state == state.ACTIVE and not aniplayer.is_playing():
		if event.is_action_pressed("ui_accept"):
			if rtl.get_visible_characters() > rtl.get_total_character_count():
				if page < dialog.size() - 1:
					page += 1
					rtl.set_bbcode(dialog[page]["text"])
					rtl.set_visible_characters(0)
				else:
					close()
		elif event.is_action_pressed("ui_start"):
			rtl.set_visible_characters(rtl.get_total_character_count())
		current_state = state.ACTIVE
	
func close():
	var previous_state = current_state
	aniplayer.play("Close")
	current_state = state.CLOSING

func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "Open":
		get_tree().paused = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Open":
		var previous_state = current_state
		if previous_state == state.OPENING:
			current_state = state.ACTIVE
		get_text(dialog_entry)
	if anim_name == "Close":
		page = 0
		rtl.clear()
		var previous_state = current_state
		current_state = state.CLOSED
		get_tree().paused = false

func _on_Timer_timeout():
	rtl.set_visible_characters(rtl.get_visible_characters() + 1)
