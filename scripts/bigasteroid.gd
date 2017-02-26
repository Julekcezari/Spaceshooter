
extends Sprite

# member variables here, example:
var bigasteroidhealth = 4
var randomnumber = 0
func _ready():
	randomize()
	randomnumber = rand_range(-100, 100)
	set_process(true)
func _process(delta):

	var bigasteroidPos = get_pos()
	bigasteroidPos.y = bigasteroidPos.y + 200 * delta
	bigasteroidPos.x = bigasteroidPos.x + randomnumber * delta
	set_pos(bigasteroidPos)
