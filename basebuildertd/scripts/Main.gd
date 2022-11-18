extends Node

var placed = false
var map

var totalCoal = 0
var totalUranium = 0
var totalOil = 0
var TotalSun = 0
var totalEnergy = 0

var maxCoal = 100
var maxOil = 100
var maxUranium = 100
var maxSun = 100
var maxEnergy = 100

signal biome_check(object, value)

###################  BUILDING COSTS ###########################
#-------------------------------------------------------------#
						#FORMAT#
			#[Metal, Wood, Brick, Scraps, Energy]
#-------------------------------------------------------------#
########################## MINES ##############################
#-------------------------------------------------------------#
var COAL_MINE_COST = [2, 10, 10, 15, 10] #2 metal, 10 brick, 10 wood, 15 scaps, 10 energy
var OIL_MINE_COST = [5, 20, 20, 30, 20] #5 metal, 20 brick, 20 wood, 30 scaps, 20 energy
var URANIUM_MINE_COST = [20, 100, 50, 60, 100] #20 metal, 100 brick, 50 wood, 60 scaps, 100 energy
var SUN_MINE_COST = [0, 20, 50, 25, 50] #2 metal, 20 brick, 10 wood, 25 scaps, 50 energy
#-------------------------------------------------------------#
######################## GENERATORS ###########################
#-------------------------------------------------------------#
var COAL_GENERATOR_COST = [2, 10, 10, 15, 10] #2 metal, 10 brick, 10 wood, 15 scaps, 10 energy
var OIL_GENERATOR_COST = [5, 20, 20, 30, 20] #5 metal, 20 brick, 20 wood, 30 scaps, 20 energy
var URANIUM_GENERATOR_COST = [20, 100, 50, 60, 100] #20 metal, 100 brick, 50 wood, 60 scaps, 100 energy
var SUN_GENERATOR_COST = [0, 20, 50, 25, 50] #2 metal, 20 brick, 10 wood, 25 scaps, 50 energy

var poop
# Called when the node enters the scene tree for the first time.
func _ready():
	poop = preload("res://scenes/CoalMine.tscn")


func craft_coalMine():
	var p1 = poop.instance()
	add_child(p1)
	p1.connect("check_biome", self, "check_biome")
	p1.connect("update_Coal", self, "update_Coal")
	connect("biome_check", p1, "biome_check")

func update_Coal(coal):
	if totalCoal < maxCoal:
		totalCoal += coal
	if totalCoal == 101:
		totalCoal = 100

func get_map(tilemap):
	map = tilemap

func check_biome(object, target, x, y):
	print(target)
	print(map.get_cell(x, y))
	if int(map.get_cell(x, y)) == target:
		emit_signal("biome_check", object, true)
	else: 
		emit_signal("biome_check", object, false)
