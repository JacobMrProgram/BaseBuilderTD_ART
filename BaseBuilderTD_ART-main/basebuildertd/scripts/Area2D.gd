extends Area2D

signal pos(x, y)
signal movex
signal movey
var moved = true;
var speed = 10
var num = 0
var showing = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("pos", position.x, position.y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x = position.x
	#print(fmod(x, 100) == 0)
	if num - 100 == 0:
		num = 0
		if moved:
			emit_signal("movex")
			moved = false
	elif int(position.y) % 100 == 0:
		if moved:
			emit_signal("movey")
			moved = false
	
	emit_signal("pos", position.x, position.y)
	if Input.is_action_pressed("ui_up"):
		position.y -= speed
		num -= speed
		moved = true
	if Input.is_action_pressed("ui_down"):
		position.y += speed
		num += speed
		moved = true
	if Input.is_action_pressed("ui_left"):
		position.x -= speed
		num -= speed
		moved = true
	if Input.is_action_pressed("ui_right"):
		position.x += speed
		num += speed
		moved = true
	
	if showing:
		#var slope = position.y / position.x
		if (position.x != 0):
			var angle = atan((position.y) /( position.x))
			if position.x >= 0 and position.y > 0:
				$AnimatedSprite.rotation = angle 
			elif position.x >= 0 and position.y < 0:
				$AnimatedSprite.rotation = angle 
			elif position.x <= 0 and position.y >= 0:
				angle = atan((position.y) /( position.x))
				$AnimatedSprite.rotation = angle + 135
			else:
				angle = atan((position.y) /( position.x))
				$AnimatedSprite.rotation = angle + 135


func _on_Crystal_show():
	$AnimatedSprite.show()
	showing = true
