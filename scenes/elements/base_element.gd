extends Node2D

#func _draw() -> void:
	#draw_rect(Rect2(0, 0, 10, 10), Color(0, 0, 0))

@export
var texture: Texture2D
@export
var texture_scale: float = 1.0
@onready var space_state = get_world_2d().direct_space_state
#var follow_speed = 25
var selected = false
var height_order = -1

func _ready() -> void:
	var sprite = $Area2D/Sprite2D
	sprite.texture = texture
	sprite.scale = Vector2(texture_scale, texture_scale)
	var size = Vector2(
		sprite.texture.get_width(), 
		sprite.texture.get_height()
	) * sprite.scale
	print(size)
	$Area2D/CollisionShape2D.shape.size = size * (5/3)
	print($Area2D/CollisionShape2D.shape.size)
	print(sprite.texture.get_width())

func _on_area_2d_input_event(viewport, event, shape_idx) -> void:
	if Input.is_action_just_pressed("click") and _is_topmost_under_mouse():
		selected = true
	if Input.is_action_just_released("click"):
		selected = false

func _physics_process(delta: float) -> void:
	var grid_size = get_tree().root.get_child(1).grid_size
	var mouse_pos = get_global_mouse_position()
	var target_pos = Vector2(snapped(mouse_pos.x, grid_size.x), snapped(mouse_pos.y, grid_size.y))
	
	if selected:
		#global_position = lerp(target_pos, get_global_mouse_position(), follow_speed * delta)
		global_position = target_pos

# FIXME This doesn't work
func _is_topmost_under_mouse() -> bool:
	var mouse_pos = get_global_mouse_position()
	#var result = space_state.intersect_point(mouse_pos, 64, [], collision_mask, true)
	var params = PhysicsPointQueryParameters2D.new()
	params.collide_with_areas = true
	params.position = get_global_mouse_position()
	var result = space_state.intersect_point(params)

	for hit in result:
		var other = hit.collider
		
		if other.z_index > self.z_index:
			return false
		if other == self:
			print(":????")
		
		#if other != self and other.z_index > self.z_index:
			#return false  # Another sprite is above this one
	return true  # This sprite is topmost
