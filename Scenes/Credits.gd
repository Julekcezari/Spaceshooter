
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		print("out.")
		get_tree().change_scene("res://Scenes/menu.tscn")
