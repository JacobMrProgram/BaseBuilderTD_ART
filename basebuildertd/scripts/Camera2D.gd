extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("in"):
		print("woowow")
		zoom.x -= 1 
		zoom.y -= 1
	if Input.is_action_pressed("out"):
		zoom.x += 1
		zoom.y += 1
	if Input.is_action_pressed("ui_accept"):
		zoom.x = 2
		zoom.y = 2
