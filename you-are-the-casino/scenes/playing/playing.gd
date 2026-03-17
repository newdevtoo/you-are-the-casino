extends Node2D

@onready var label: Label = $labels/moneylab
@onready var slotsmac: Label = $labels/slotsmac
@onready var pokertables: Label = $labels/pokertables
@onready var dealers: Label = $labels/dealers

@onready var moneypersec: Label = $labels/moneypersec


func _process(delta: float) -> void:
	slotsmac.text = "slotmachines: " + str(Gamemanager.slot_machines)
	pokertables.text = "pokertables: " + str(Gamemanager.poker_tables)
	dealers.text = "dealers: " + str(Gamemanager.dealers)
	moneypersec.text = "money per sec: " + str(Gamemanager.income_per_second - Gamemanager.running_costs_per_second)
	if Input.is_action_just_pressed("clicked") and get_global_mouse_position().x > 585.0:
		click()
		print("itworked!")

func _on_addmoney_timeout() -> void:
	Gamemanager.money += Gamemanager.income_per_second * Gamemanager.income_multiplier
	Gamemanager.money -= Gamemanager.running_costs_per_second
	label.text = "money: " + str(Gamemanager.money)



func _on_button_pressed() -> void:
	if Gamemanager.money > 499:
		Gamemanager.money -= 500
		Gamemanager.income_per_second += 10
		Gamemanager.running_costs_per_second += 1
		Gamemanager.slot_machines +=1
		Gamemanager.total_buildings += 1


func _on_pokertable_pressed() -> void:
	if Gamemanager.money > 1999:
		Gamemanager.money -= 2000
		Gamemanager.income_per_second += 35
		Gamemanager.running_costs_per_second += 9
		Gamemanager.poker_tables +=1
		Gamemanager.total_buildings += 1



func click():
	if Gamemanager.income_per_second == 1:
		Gamemanager.money += 1
	elif Gamemanager.income_per_second > 1:
		Gamemanager.money += Gamemanager.income_per_second/2
