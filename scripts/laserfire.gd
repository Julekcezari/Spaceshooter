
extends Sprite

func _ready():
	set_process(true)
func _process(delta):

	var laserPos = get_pos()
	laserPos.y = laserPos.y - 600 * delta
	set_pos(laserPos)
	
