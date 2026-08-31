extends StaticBody2D

@export var max_health := 100.0
var health

func _ready() -> void:
	health = max_health

func take_damage(amount):
	health -= amount if health >= amount else health
	
	if health <= 0:
		queue_free()

func interact():
	print("Health (Antes): "+str(health))
	take_damage(5)
	print("Health (Depois): "+str(health))
