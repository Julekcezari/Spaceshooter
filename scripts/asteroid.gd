
extends Sprite

var randomnumber = 0
func _ready():
	randomize()
	randomnumber = rand_range(-300, 300)
	set_process(true)
func _process(delta):

	var asteroidPos = get_pos()
	asteroidPos.y = asteroidPos.y + 450 * delta
	asteroidPos.x = asteroidPos.x + randomnumber * delta
	set_pos(asteroidPos)