extends CharacterBody2D

@export var speed := 150.0
@export var zoom := 1.0
@export var temporary_slot_1: ItemData

@onready var interaction_detector: Area2D = $InteractionDetector
@onready var camera2d: Camera2D = $Camera2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var facing: Vector2 = Vector2.DOWN

var selected_item: ItemData

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
	
	if Input.is_action_just_pressed("hotbar_1"):
		toggle_selected_item(temporary_slot_1)
		print(selected_item.display_name if selected_item else "Nada selecionado")

func toggle_selected_item(item: ItemData) -> void:
	if selected_item == item:
		selected_item = null
	else:
		selected_item = item

func get_target_under_mouse() -> Node2D:
	var query := PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	query.collision_mask = interaction_detector.collision_mask
	
	var space_state = get_world_2d().direct_space_state
	var results = space_state.intersect_point(query)
	
	if results.is_empty():
		return null
	
	var area = results[0]["collider"] as Area2D
	
	if area == null:
		return null
	
	return area.get_parent() as Node2D

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
	var target: Node2D = get_target_under_mouse()
	
	if target == null:
		print("Nenhum alvo")
		return
	
	print("Alvo encontrado: " + target.name)

func try_use_item() -> void:
	if selected_item:
		if selected_item is ToolData:
			var tool := selected_item as ToolData
			
	else:
		print("Nenhum item selecionado")
