extends Node2D

var timer= Timer
@onready var timmer = $life
@onready var move = $move
var move_speed = 40

var color = 0
@onready var numbers: Label = $numbers

func _ready() -> void:
	numbers.text = str(Gamemanager.incomewithclick)
	color = randi_range(0, 3)
	if color == 0:
		numbers.self_modulate = Color.YELLOW
	elif color == 1:
		numbers.self_modulate = Color.GREEN
	else:
		numbers.self_modulate = Color.BLUE
	timmer.start()
	if move.is_stopped():
		move.start()
	




func _on_move_timeout() -> void:
	position += Vector2.UP * move_speed
	numbers.rotation += 20
	move.start()


func _on_life_timeout() -> void:
	queue_free()
