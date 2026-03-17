extends Node


#other
var casino_name: String = "My Casino"

# Money
var money: float = 1000
var income_per_second: float = 1
var income_multiplier: float = 1
var running_costs_per_second: float = 0

# License
var license: float = 100
var license_decay_per_minute: float = 2

# Buildings
var total_buildings: int = 0
var slot_machines: int = 2
var poker_tables: int = 1
var dealers: int = 0
var bars: int = 0

# Time
var current_day: int = 1
var day_progress: float = 0
var day_length_seconds: float = 120

# Events
var protest_active: bool = false
