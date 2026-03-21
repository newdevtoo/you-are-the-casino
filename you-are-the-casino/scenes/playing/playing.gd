extends Node2D

@onready var label: Label = $labels/moneylab
@onready var slotsmac: Label = $labels/slotsmac
@onready var pokertables: Label = $labels/pokertables
@onready var bars: Label = $labels/bar
@onready var moneypersec: Label = $labels/moneypersec
@onready var viplounge: Label = $labels/viplounge
@onready var adtimer: Timer = $timers/adtimer
@onready var ad: Button = $buttons/ad
@onready var license: ProgressBar = $license
@onready var day: Label = $labels/day
@onready var notifications: Panel = $notifications
var choosevent = randi_range(1, 45)
@onready var event_show: Panel = $"event show"
@onready var whatevent: Label = $"event show/whatevent"
@onready var description: Label = $"event show/description"
@onready var licensetimer: Timer = $timers/licensetimer
@onready var protest: Timer = $timers/protest
@onready var choice_1: Button = $"event show/choice1"
@onready var choice_2: Button = $"event show/choice2"
@onready var notilabel: Label = $notifications/notilabel


func _process(delta: float) -> void:
	slotsmac.text = "slotmachines: " + str(Gamemanager.slot_machines)
	pokertables.text = "pokertables: " + str(Gamemanager.poker_tables)
	moneypersec.text = "money per sec: " + str(Gamemanager.income_per_second * Gamemanager.income_multiplier - Gamemanager.running_costs_per_second)
	bars.text = "bars: " + str(Gamemanager.bar)
	viplounge.text = "vip lounge: " + str(Gamemanager.vip)
	license.value = Gamemanager.license 
	day.text = "day until tax: " + str(Gamemanager.day_until_tax)
	if license.value < 1:
		hide()
	

#buttons
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("clicked") and get_global_mouse_position().x > 585.0:
		click()
		





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
		ad.hide()
		adtimer.start()
		Gamemanager.money -= 1000000
		Gamemanager.income_multiplier += 25
		label.text = "money: " + str(Gamemanager.money)



func _on_paycompilence_pressed() -> void:
	if Gamemanager.money >= 1000:
		Gamemanager.money -= 1000
		Gamemanager.license += 20



func _on_choice_1_pressed() -> void:
	event_show.hide()
	get_tree().paused =false
	if choice_1.text == "ok":
		get_tree().paused = false
		event_show.hide()
	if choice_1.text == "fight":
		get_tree().paused = false
		var lawsuit = randi_range(0,1)
		if lawsuit == 0:
			notifications.show()
			notilabel.text = "you won the lawsuit!"
		elif lawsuit == 1:
			var moneypay = randi_range(5000, 20000)
			Gamemanager.money -= moneypay
			notifications.show()
			notilabel.text = "you lost the lawsuit"


func _on_choice_2_pressed() -> void:
	event_show.hide()
	get_tree().paused =false
	if choice_2.text == "pay them off":
		get_tree().paused =false
		if Gamemanager.money > 999:
			Gamemanager.money -= 1000
			protest.stop()
			event_show.hide()
			Gamemanager.license_decay_per_minute = 2
			licensetimer.wait_time = 4
	if choice_2.text == "settle":
		Gamemanager.money -= Gamemanager.money * 0.40
		get_tree().paused = false
		event_show.hide()

#timers
func _on_adtimer_timeout() -> void:
	Gamemanager.income_multiplier -= 25
	label.text = "money: " + str(Gamemanager.money)




func _on_addmoney_timeout() -> void:
	Gamemanager.money += Gamemanager.income_per_second * Gamemanager.income_multiplier
	Gamemanager.money -= Gamemanager.running_costs_per_second
	label.text = "money: " + str(Gamemanager.money)

func _on_licensetimer_timeout() -> void:
	Gamemanager.license -= Gamemanager.license_decay_per_minute



func _on_adshowtimer_timeout() -> void:
	if ad.visible:
		ad.visible = false
	else:
		ad.show()


func _on_daytimer_timeout() -> void:
	Gamemanager.tax = Gamemanager.total_buildings *100
	Gamemanager.current_day += 1
	Gamemanager.day_until_tax -= 1
	if Gamemanager.current_day == 7:
		notifications.hide()
		if Gamemanager.money < Gamemanager.tax:
			Gamemanager.license -= 100
			
		else:
			Gamemanager.money -= Gamemanager.tax
			Gamemanager.current_day = 1
			Gamemanager.day_until_tax = 7
	if Gamemanager.current_day == 6:
		notifications.show()
		notilabel.text = "Taxing season coming"

func _on_eventtimer_timeout() -> void:
	choosevent = randi_range(1, 45)
	var table = randi_range(1, 15)
	var people = randi_range(21, 100)
	if choosevent > 0 and choosevent < 11:#lawsuit
		get_tree().paused = true
		var randomname = Gamemanager.names[randi_range(0, Gamemanager.names.size()-1)]
		event_show.show()
		choice_2.show()
		choice_1.text = "fight"
		choice_2.text = "settle"
		whatevent.text = "lawsuit"
		description.text = "Mr " + str(randomname) + " claims he lost 
		his house at Table " + str(table) + "
		His lawyer is very expensive."
	elif choosevent > 10 and choosevent < 21:#jackpot
		get_tree().paused = true
		event_show.show()
		choice_2.hide()
		choice_1.show()
		choice_1.text = "ok"
		whatevent.text = "Jackpot"
		description.text ="table " + str(table) + ". " + str(Gamemanager.money * 0.10) + " He's crying.
		His friends are cheering.
		 You are not"
		Gamemanager.money -= Gamemanager.money * 0.10
	elif choosevent > 20 and choosevent <31:#protest
		choice_2.show()
		licensetimer.wait_time = 1
		Gamemanager.license_decay_per_minute = 4
		get_tree().paused = true
		protest.start()
		event_show.show()
		choice_1.text = "ok"
		choice_2.text = "pay them off"
		whatevent.text = "protest"
		description.text = str(people) + " People with signs
		The news van just pulled up"
	elif  choosevent > 30 and choosevent < 41:
		pass

func _on_protest_timeout() -> void:
	licensetimer.wait_time = 4
	Gamemanager.license_decay_per_minute =2


func click():
	if Gamemanager.income_per_second > 1:
		Gamemanager.money += Gamemanager.income_per_second/2 * Gamemanager.income_multiplier
	else:
		Gamemanager.money += 1
	label.text = "money: " + str(Gamemanager.money)
