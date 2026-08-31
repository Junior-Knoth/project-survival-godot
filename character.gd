extends CharacterBody2D

@export var speed := 150.0
@export var zoom := 1.0

@onready var interaction_detector: Area2D = $InteractionDetector
@onready var camera2d: Camera2D = $Camera2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var facing: Vector2 = Vector2.DOWN

func _ready() -> void:
	sprite.play("idle_down")

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)
	
	velocity = direction * speed
	move_and_slide()
	
	if direction != Vector2.ZERO:
		if abs(direction.x) < abs(direction.y):
			if direction.y > 0:
				facing = Vector2.DOWN
			else:
				facing = Vector2.UP
		else:
			if direction.x > 0:
				facing = Vector2.RIGHT
			else:
				facing = Vector2.LEFT
		
		update_animation()
	
	if Input.is_action_just_pressed("interaction"):
		try_interact()
	
	if Input.is_action_just_pressed("use_item"):
		try_use_item()
	
	if Input.is_action_just_pressed("zoom_in"):
		camera2d.zoom += Vector2(zoom,zoom)
	
	if Input.is_action_just_pressed("zoom_out"):
		camera2d.zoom -= Vector2(zoom,zoom)

func update_animation() -> void:
	
	if facing.x > 0:
		sprite.play("idle_right")
	elif facing.x < 0:
		sprite.play("idle_left")
	elif facing.y > 0:
		sprite.play("idle_down")
	elif facing.y < 0:
		sprite.play("idle_up")

func try_interact() -> void:
	var areas = interaction_detector.get_overlapping_areas()
	
	if not areas.is_empty():
		for area: Area2D in areas:
			var interactable = area.get_parent()
		
			if interactable.has_method("interact"):
				interactable.interact()

func try_use_item() -> void:
	print("Tentou usar um item")
