extends Control

var showingResources = false

signal coalMine
signal uraniumMine
signal solarMine
signal oilMine



func _process(delta):
	
	$Resources/CoalStorage.value = Main.totalCoal
	$Resources/CoalStorage/CoalAmount.text = String(Main.totalCoal)


func _on_CoalMine_pressed():
	emit_signal("coalMine")


func _on_UraniumMine_pressed():
	emit_signal("uraniumMine")


func _on_SolarMine_pressed():
	emit_signal("solarMine")


func _on_OilMine_pressed():
	emit_signal("oilMine")


func _on_ShowResources_pressed():
	if showingResources:
		$AnimationPlayer.play("HideResources")
		showingResources = false
	else:
		$AnimationPlayer.play("ShowResources")
		showingResources = true


func _on_ShowMines_pressed():
	$Mines.show()
	$Generators.hide()


func _on_ShowGenerators_pressed():
	$Generators.show()
	$Mines.hide()
