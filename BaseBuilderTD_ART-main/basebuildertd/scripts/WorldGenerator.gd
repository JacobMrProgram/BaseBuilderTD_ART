extends Node2D

onready var tilemap = $TileMap
var temperature = {}
var moisture = {}
var altitude = {}
var biome = {}
var openSimplexNoise = OpenSimplexNoise.new()
var xpos = 0
var ypos = 0
var one = false
var seeds = rand_range(0, OS.get_system_time_secs())
var seedm = rand_range(0, OS.get_system_time_secs())
var seeda = rand_range(0, OS.get_system_time_secs())
var seedt = rand_range(0, OS.get_system_time_secs())
var started = false
signal get_map(tilemap)

func generate_map(per, oct, seedy):
	#print("hi")
	seeds = OS.get_system_time_msecs()
	seedm = OS.get_system_time_msecs()
	seeda = OS.get_system_time_msecs()
	seedt = OS.get_system_time_msecs()
	openSimplexNoise.seed = seedy
	openSimplexNoise.octaves = oct
	openSimplexNoise.period = per
	var gridName = {}
	#fix this
	for x in range(-5, 5):
		for y in range(-5, 5):
				var rand = 2*(abs(openSimplexNoise.get_noise_2d(x + 30, y + 30)))
				gridName[Vector2(x, y)] = rand
	return gridName
	
func generate_map1(per, oct, xco, yco, seedy):
	openSimplexNoise.seed = seedy
	openSimplexNoise.octaves = oct
	openSimplexNoise.period = per
	var gridName = {}
	#fix this
	for x in range(xco - 50, xco + 50):
		for y in range(yco - 50, yco + 50):
				var rand = 2*(abs(openSimplexNoise.get_noise_2d(x + 30, y + 30)))
				gridName[Vector2(x, y)] = rand
	return gridName


func _ready():
	
	temperature = generate_map(300, 5, seedt)
	moisture = generate_map(300, 5, seedm)
	altitude= generate_map(150, 5, seeda)
	
	temperature = generate_map1(300, 5, 0, 0, seedt)
	moisture = generate_map1(300, 5, 0, 0, seedm)
	altitude= generate_map1(150, 5, 0, 0, seeda)
	set_tilex_start()
	set_tilex_absolute()
	started = true

func set_tilex_start():
	for x in range(-5, 5):
		for y in range(-5,5):
			if tilemap.get_cell(x, y) == tilemap.INVALID_CELL:
				var pos = Vector2(x, y)
				var alt = altitude[pos]
				var temp = temperature[pos]
				var moist = moisture[pos]
				if alt < 0.2:
					print(seeda)
					_ready()
	
func set_tilex_absolute():
	for x in range((xpos / 14) - 50, (xpos / 14) + 50):
		for y in range((ypos / 14) - 50, (ypos / 14) + 50):
			if tilemap.get_cell(x, y) == tilemap.INVALID_CELL:
				var pos = Vector2(x, y)
				var alt = altitude[pos]
				var temp = temperature[pos]
				var moist = moisture[pos]
				if alt < 0.2:
					tilemap.set_cellv(pos, 2)
				elif 0.2 < alt and alt < 0.25:
					tilemap.set_cellv(pos, 5)
				elif moist < 0.25:
					tilemap.set_cellv(pos, 4)
				elif moist > 0.4 and temp < 0.3:
					tilemap.set_cellv(pos, 3)
				else:
					tilemap.set_cellv(pos, 1)

func _on_Area2D_pos(x, y):
	xpos = x 
	ypos = y

func _process(delta):
	emit_signal("get_map", $TileMap)
	if fmod(xpos, 350 / 2) == 0 or fmod(ypos, 350 / 2) == 0:
		if started and xpos != 0 and ypos != 0:
			temperature = generate_map1(300, 5, xpos / 14, ypos / 14, seedt)
			moisture = generate_map1(300, 5, xpos / 14, ypos / 14, seedm)
			altitude= generate_map1(150, 5, xpos / 14, ypos / 14, seeda)
			set_tilex_absolute()
