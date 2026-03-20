extends Node


#other
var casino_name: String = "My Casino"

# Money
var money: int = 20
var income_per_second: int = 55
var income_multiplier: int = 1
var running_costs_per_second: int = 8
var tax: int = 1

# License
var license: int = 100
var license_decay_per_minute: int = 2

# Buildings
var total_buildings: int = 3
var slot_machines: int = 2
var poker_tables: int = 1
var bar: int = 0
var vip: int = 0

# Time
var current_day: int = 1
var day_length_seconds: int = 60
var day_until_tax: int = 7

# Events
var protest_active: bool = false
