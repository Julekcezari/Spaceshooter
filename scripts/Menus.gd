
extends VBoxContainer

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	pass

func _on_Startgame_pressed():
	print("presstart")
	get_tree().change_scene("res://Scenes/Main.scn")

func _on_Quit_pressed():
	get_tree().quit()


func _on_Credits_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")
