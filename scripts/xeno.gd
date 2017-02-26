
extends Sprite

var laser = preload("res://Scenes/laserfire.xml")
var randomnumber = 0
var randomtime = 0
var directionx = 0
func _ready():
	randomize()
	directionx = rand_range(0, 1)
	set_process(true)
func _process(delta):
	var xenoPos = get_pos()
	directionx = directionx + delta
	if directionx > 1.5:
		randomize()
		randomnumber = rand_range(-1, 1)
		directionx = rand_range(0.4, 1)
	xenoPos.x = xenoPos.x + (randomnumber * 150) * delta
	xenoPos.y = xenoPos.y + 40 * delta
	set_pos(xenoPos)