extends Area2D

var placed = false
var selff = self
var coal = 0
var correct_biome

signal up(coal)
signal check_biome(object, target, x, y)
signal update_coal(coal)

func _ready():
	pass
	#connect("up", main, )

func _process(delta):
	#print(coal) 
	if !placed:
		position = get_global_mouse_position()
		if fmod(position.x , 64) != 0:
				position.x -= fmod(position.x, 64)
		if fmod(position.y , 64) != 0:
			position.y -= fmod(position.y, 64)
			emit_signal("check_biome", selff, 1, position.x / 14, position.y / 14)
		if Input.is_action_just_pressed("left_click"):
			
			placed = true
			$CoalTimer.start()
	

func biome_check(object, value):
	emit_signal("up")
	if object == selff:
		if value:
			correct_biome = true
			coal = 2
		else:
			correct_biome = false
			coal = 1


func _on_CoalTimer_timeout():
	Main.update_Coal(coal)
