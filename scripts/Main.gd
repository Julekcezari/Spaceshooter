
extends Node2D
var dead = load("res://sprites/deadplayer.png")
var player = load("res://sprites/player.png")
var shiphealth = 2
var highscore = 0
var gamerun = true
var score = 0
var firebutton = false
var laser = preload("res://Scenes/laserfire.xml")
var firecount = 0
var laserarray = []
var asteroidcount = 0
var asteroid = preload("res://Scenes/asteroid.xml")
var asteroidarray = []
var bigasteroidcount = 0
var xenocount = 0
var xenohealth = []
var xenoarray = []
var bigasteroid = preload("res://Scenes/bigasteroid.xml")
var bigasteroidarray = []
var timespawnbigasteroids = 0
var timespawnasteroids = 0
var timespawnxeno = 0
var timefire = 0
var bigasteroidhealth = 4
var firenumber = 0
var screensize = 0
var randomnumber = 0
var xeno = preload("res://Scenes/xeno.xml")
var scorelose = 0

func _ready():
	screensize = get_viewport_rect().size
	set_process(true)
	get_node("score").set_text(str(score))
	get_node("highscore").set_text("highscore = " + str(highscore))
	print(screensize)
	get_node("StreamPlayer").play()
	
func _process(delta):
	if gamerun == true:
		game(delta)
	else:
		if Input.is_action_pressed("ui_accept"):
			resetgame()
		if Input.is_action_pressed("ui_cancel"):
			get_tree().change_scene("res://Scenes/menu.tscn")
func game(delta):
	if Input.is_action_pressed("space") and firenumber < 4:
		if firebutton == false:
			laserfire()
			firebutton = true
	else:
		firebutton = false
		


	var shipPos = get_node("ship").get_pos()
	if Input.is_action_pressed("ui_up"):
		shipPos.y = shipPos.y - 500 * delta
	if Input.is_action_pressed("ui_down"):
		shipPos.y = shipPos.y + 500 * delta
	if Input.is_action_pressed("ui_left"):
		shipPos.x = shipPos.x - 500 * delta
	if Input.is_action_pressed("ui_right"):
		shipPos.x = shipPos.x + 500 * delta
	if shipPos.x < 20:
		shipPos.x = shipPos.x + 500 * delta
	if shipPos.x > screensize.x -20:
		shipPos.x = shipPos.x - 500 * delta
	if shipPos.y < 50:
		shipPos.y = shipPos.y + 500 * delta
	if shipPos.y > screensize.y - 40:
		shipPos.y = shipPos.y - 500 * delta
	get_node("ship").set_pos(shipPos)
	var lasercount = 0
	for laser in laserarray:
		var laserPos = get_node(laser).get_pos()
		if laserPos.y < 0:
			remove_child(get_node(laser))
			laserarray.remove(lasercount)
			firenumber = firenumber - 1
		lasercount = lasercount + 1

	scorelose = scorelose + delta
	if scorelose > 2:
		score = score - 1
		scorelose = 0
		get_node("score").set_text(str(score))

	timespawnasteroids = timespawnasteroids + delta
	if timespawnasteroids > 0.5:
		asteroidspawn()
		timespawnasteroids = 0

	timespawnxeno = timespawnxeno + delta
	if timespawnxeno > 6:
		xenospawn()
		timespawnxeno = 0

	timespawnbigasteroids = timespawnbigasteroids + delta
	if timespawnbigasteroids > 3:
		bigasteroidspawn()
		timespawnbigasteroids = 0

	var bigasteroidnumber = 0
	for bigasteroid in bigasteroidarray:
		var bigasteroidPos = get_node(bigasteroid).get_pos()
		if bigasteroidPos.y > screensize.y + 60:
			bigasteroidhealth = 4
			remove_child(get_node(bigasteroid))
			bigasteroidarray.remove(bigasteroidnumber)
		bigasteroidnumber = bigasteroidnumber + 1

	var xenonumber = 0
	for xeno in xenoarray:
		var xenoPos = get_node(xeno).get_pos()
		get_node(xeno)
		if xenoPos.y > screensize.y + 60:
			xenohealth = 5
			remove_child(get_node(xeno))
			xenoarray.remove(xenonumber)
		xenonumber = xenonumber + 1

	var asteroidnumber = 0
	for asteroid in asteroidarray:
		var asteroidPos = get_node(asteroid).get_pos()
		get_node(asteroid)
		if asteroidPos.y > screensize.y + 60:
			remove_child(get_node(asteroid))
			asteroidarray.remove(asteroidnumber)
		asteroidnumber = asteroidnumber + 1

	var lasercount = 0
	for laser in laserarray:
		var laserPos = get_node(laser).get_pos()
		var bigasteroidnumber = 0

		for bigasteroid in bigasteroidarray:
			var bigasteroidPos = get_node(bigasteroid).get_pos()
			if laserPos.y < bigasteroidPos.y and bigasteroidPos.y < shipPos.y:
				if laserPos.x > bigasteroidPos.x - 70:
					if laserPos.x < bigasteroidPos.x + 70:
						bigasteroidhealth = bigasteroidhealth - 1
						print (bigasteroidhealth)
						remove_child(get_node(laser))
						laserarray.remove(lasercount)
						firenumber = firenumber - 1
						if bigasteroidhealth < 1:
							remove_child(get_node(bigasteroid))
							bigasteroidarray.remove(bigasteroidnumber)
							bigasteroidhealth = 4
							score = score + 5
							get_node("SamplePlayer2D").play("Point")
							get_node("score").set_text(str(score))
							if score > highscore:
								highscore = score
								get_node("highscore").set_text("highscore = " + str(highscore))
			bigasteroidnumber = bigasteroidnumber +1

		var asteroidnumber = 0
		for asteroid in asteroidarray:
			var asteroidPos = get_node(asteroid).get_pos()
			if laserPos.y < asteroidPos.y and asteroidPos.y < shipPos.y:
				if laserPos.x > asteroidPos.x - 25:
					if laserPos.x < asteroidPos.x + 25:
						remove_child(get_node(asteroid))
						asteroidarray.remove(asteroidnumber)
						remove_child(get_node(laser))
						laserarray.remove(lasercount)
						firenumber = firenumber - 1
						score = score + 1
						get_node("SamplePlayer2D").play("Point")
						get_node("score").set_text(str(score))
						if score > highscore:
							highscore = score
							get_node("highscore").set_text("highscore = " + str(highscore))
			asteroidnumber = asteroidnumber +1

		var xenonumber = 0
		for xeno in xenoarray:
			var xenoPos = get_node(xeno).get_pos()
			if laserPos.y < xenoPos.y and xenoPos.y < shipPos.y:
				if laserPos.x > xenoPos.x - 70:
					if laserPos.x < xenoPos.x + 70:
						xenohealth = xenohealth - 1
						print (xenohealth)
						remove_child(get_node(laser))
						laserarray.remove(lasercount)
						firenumber = firenumber - 1
						if xenohealth < 1:
							remove_child(get_node(xeno))
							xenoarray.remove(xenonumber)
							xenohealth = 4
							score = score + 10
							get_node("SamplePlayer2D").play("score")
							get_node("score").set_text(str(score))
							if score > highscore:
								highscore = score
								get_node("highscore").set_text("highscore = " + str(highscore))
			xenonumber = xenonumber + 1

		lasercount = lasercount + 1

	var asteroidnumber = 0
	for asteroid in asteroidarray:
		var asteroidPos = get_node(asteroid).get_pos()
		var shipPos = get_node("ship").get_pos()
		if asteroidPos.y > shipPos.y - 20 and asteroidPos.y < shipPos.y + 50:
			if (asteroidPos.x - 25) < (shipPos.x + 25):
				if (asteroidPos.x + 25) > (shipPos.x - 25):
					get_node("SamplePlayer2D").play("Explosionship")
					get_node("gameover").set_text(str("Game over. Thanks for playing!"))
					get_node("ship").set_texture(dead)
					get_node("ship/fuelscape").set_emitting(1)
					get_node("ship/fuelscape").set_time_scale(1)
					gamerun = false

	var bigasteroidnumber = 0
	for bigasteroid in bigasteroidarray:
		var bigasteroidPos = get_node(bigasteroid).get_pos()
		var shipPos = get_node("ship").get_pos()
		if bigasteroidPos.y + 20 > shipPos.y -25 and bigasteroidPos.y - 25 < shipPos.y + 50:
			if (bigasteroidPos.x - 65) < (shipPos.x + 25):
				if (bigasteroidPos.x + 65) > (shipPos.x - 25):
					get_node("SamplePlayer2D").play("Explosionship")
					get_node("gameover").set_text(str("Game over. Thanks for playing!"))
					get_node("ship").set_texture(dead)
					get_node("ship/fuelscape").set_emitting(1)
					get_node("ship/fuelscape").set_time_scale(1)
					gamerun = false

	var xenonumber = 0
	for xeno in xenoarray:
		var xenoPos = get_node(xeno).get_pos()
		var shipPos = get_node("ship").get_pos()
		if xenoPos.y + 15 > shipPos.y -25 and xenoPos.y - 15 < shipPos.y + 30:
			if (xenoPos.x - 45) < (shipPos.x + 25):
				if (xenoPos.x + 45) > (shipPos.x - 25):
					get_node("gameover").set_text(str("Game over. Thanks for playing!"))
					get_node("SamplePlayer2D").play("Explosionship")
					get_node("ship").set_texture(dead)
					get_node("ship/fuelscape").set_emitting(1)
					get_node("ship/fuelscape").set_time_scale(1)
					gamerun = false

func laserfire():
	firecount = firecount + 1
	firenumber = firenumber + 1
	print("shot")
	print(firecount)
	var laser_instance = laser.instance()
	laser_instance.set_name("laser"+str(firecount))
	add_child(laser_instance)
	var laserPos = get_node("laser"+str(firecount)).get_pos()
	var shipPos = get_node("ship").get_pos()
	laserPos.y = shipPos.y
	laserPos.x = shipPos.x
	get_node("laser"+str(firecount)).set_pos(laserPos)
	laserarray.push_back("laser"+str(firecount))
	print(laserarray)
	get_node("SamplePlayer2D").play("Laser")

func asteroidspawn():
	randomnumber = rand_range(-300,300)
	var screensize = get_viewport_rect().size
	asteroidcount = asteroidcount + 1
	print("asteroid")
	print(asteroidcount)
	var asteroid_instance = asteroid.instance()
	asteroid_instance.set_name("asteroid"+str(asteroidcount))
	add_child(asteroid_instance)
	var asteroidPos = get_node("asteroid"+str(asteroidcount)).get_pos()
	asteroidPos.y = -5
	asteroidPos.x = rand_range(0, screensize.x)
	get_node("asteroid"+str(asteroidcount)).set_pos(asteroidPos)
	asteroidarray.push_back("asteroid"+str(asteroidcount))
	print(asteroidarray)

func resetgame():
	for asteroid in asteroidarray:
		remove_child(get_node(asteroid))
	asteroidarray.clear()
	for bigasteroid in bigasteroidarray:
		remove_child(get_node(bigasteroid))
	bigasteroidarray.clear()
	for xeno in xenoarray:
		remove_child(get_node(xeno))
	xenoarray.clear()
	for laser in laserarray:
		remove_child(get_node(laser))
	laserarray.clear()
	var shipPos = get_node("ship").get_pos()
	shipPos.x = screensize.x/2
	shipPos.y = screensize.y + 20
	get_node("ship").set_pos(shipPos)
	score = 0
	get_node("score").set_text(str(score))
	get_node("gameover").set_text(str())
	gamerun = true
	firenumber = 0
	get_node("ship").set_texture(player)
	get_node("ship/fuelscape").set_emitting(0)
	get_node("ship/fuelscape").set_time_scale(20)

func bigasteroidspawn():
	var screensize = get_viewport_rect().size
	bigasteroidcount = bigasteroidcount + 1
	print("bigasteroid")
	print(bigasteroidcount)
	var bigasteroid_instance = bigasteroid.instance()
	bigasteroid_instance.set_name("bigasteroid"+str(bigasteroidcount))
	add_child(bigasteroid_instance)
	var bigasteroidPos = get_node("bigasteroid"+str(bigasteroidcount)).get_pos()
	bigasteroidPos.y = -5
	bigasteroidPos.x = rand_range(0, screensize.x)
	get_node("bigasteroid"+str(bigasteroidcount)).set_pos(bigasteroidPos)
	bigasteroidarray.push_back("bigasteroid"+str(bigasteroidcount))
	print(bigasteroidarray)

func xenospawn():
	var screensize = get_viewport_rect().size
	xenocount = xenocount + 1
	xenohealth = 5
	print(xenocount)
	print("xenoscum")
	var xeno_instance = xeno.instance()
	xeno_instance.set_name("xeno"+str(xenocount))
	add_child(xeno_instance)
	var xenoPos = get_node("xeno"+str(xenocount)).get_pos()
	xenoPos.y = -80
	xenoPos.x = rand_range(50, screensize.x - 50)
	get_node("xeno"+str(xenocount)).set_pos(xenoPos)
	xenoarray.push_back("xeno"+str(xenocount))
	print(xenoarray)