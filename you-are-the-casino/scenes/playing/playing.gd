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



func _on_addmoney_timeout() -> void:
	Gamemanager.money += Gamemanager.income_per_second
	Gamemanager.money -= Gamemanager.running_costs_per_second
	label.text = "money: " + str(Gamemanager.money)
	print(Gamemanager.income_per_second)


func _on_button_pressed() -> void:
	if Gamemanager.money > 499:
		Gamemanager.money -= 500
		Gamemanager.income_per_second += 50
		Gamemanager.running_costs_per_second += 20
		Gamemanager.slot_machines +=1
		Gamemanager.total_buildings += 1
