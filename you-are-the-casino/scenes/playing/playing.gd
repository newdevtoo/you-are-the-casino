extends Node2D

@onready var label: Label = $labels/moneylab
@onready var slotsmac: Label = $labels/slotsmac
@onready var pokertables: Label = $labels/pokertables
@onready var dealers: Label = $labels/dealers
@onready var bars: Label = $labels/bar
@onready var moneypersec: Label = $labels/moneypersec
@onready var viplounge: Label = $labels/viplounge
@onready var adtimer: Timer = $timers/adtimer


func _process(delta: float) -> void:
	slotsmac.text = "slotmachines: " + str(Gamemanager.slot_machines)
	pokertables.text = "pokertables: " + str(Gamemanager.poker_tables)
	dealers.text = "dealers: " + str(Gamemanager.dealers)
	moneypersec.text = "money per sec: " + str(Gamemanager.income_per_second * Gamemanager.income_multiplier - Gamemanager.running_costs_per_second)
	bars.text = "bars: " + str(Gamemanager.bar)
	viplounge.text = "vip lounge: " + str(Gamemanager.vip)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("clicked") and get_global_mouse_position().x > 585.0:
		click()
		

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
		label.text = "money: " + str(Gamemanager.money)


func _on_pokertable_pressed() -> void:
	if Gamemanager.money > 1999:
		Gamemanager.money -= 2000
		Gamemanager.income_per_second += 35
		Gamemanager.running_costs_per_second += 9
		Gamemanager.poker_tables +=1
		Gamemanager.total_buildings += 1
		label.text = "money: " + str(Gamemanager.money)

func _on_bars_pressed() -> void:
	if Gamemanager.money > 4999 and Gamemanager.bar < 1:
		Gamemanager.money -= 5000
		Gamemanager.running_costs_per_second += 20
		Gamemanager.bar +=1
		Gamemanager.income_multiplier += 3
		Gamemanager.total_buildings += 1
		label.text = "money: " + str(Gamemanager.money)

func _on_viplounge_pressed() -> void:
	if Gamemanager.money > 499999 and Gamemanager.vip < 1:
		Gamemanager.money -= 500000
		Gamemanager.running_costs_per_second += 1000
		Gamemanager.vip +=1
		Gamemanager.income_multiplier += 15
		Gamemanager.total_buildings += 1
		label.text = "money: " + str(Gamemanager.money)

func _on_ad_pressed() -> void:
	if Gamemanager.money >= 1000000:
		adtimer.hide()
		adtimer.start()
		Gamemanager.money -= 1000000
		Gamemanager.income_multiplier += 25
		label.text = "money: " + str(Gamemanager.money)

func _on_adtimer_timeout() -> void:
	Gamemanager.income_multiplier -= 25
	label.text = "money: " + str(Gamemanager.money)



func click():
	if Gamemanager.income_per_second > 1:
		Gamemanager.money += Gamemanager.income_per_second/2 * Gamemanager.income_multiplier
	else:
		Gamemanager.money += 1
	label.text = "money: " + str(Gamemanager.money)
