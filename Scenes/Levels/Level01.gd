extends Node2D

var collectible = preload("res://Scenes/Collectibles/LevelOneCollectible.tscn")

func _ready():
	if !get_parent().is_level_01_collectible_held:
		self.add_child(collectible)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
