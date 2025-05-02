extends Node

@export var atom_scene: PackedScene
@export var num_width: int = 20
@export var num_height: int = 10
@export var interatom_spacing: float = 5
func _ready() -> void:
	var test_atom = atom_scene.instantiate()
	var radius = test_atom.radius
	var diameter = radius * 2
	test_atom.queue_free()
		
	var screen_size = get_viewport().get_visible_rect().size
		
	var total_width = diameter * num_width + (num_width - 1) * interatom_spacing
	var total_height = diameter * num_height  + (num_height - 1) * interatom_spacing
	var screen_center = screen_size / 2
	
	var start_x = screen_center.x - total_width / 2 + radius
	var start_y = screen_center.y - total_height / 2 + radius
	
	for row in range(num_width):
		for col in range(num_height):
			var atom = atom_scene.instantiate()
			atom.position = Vector2(
				start_x + row * (diameter + interatom_spacing),
				start_y + col * (diameter + interatom_spacing)
			)
			#atom.linear_velocity = Vector2(randi_range(500, 1000), randi_range(500, 1000))
			
			add_child(atom)

func get_nodes_in_scene(scene:Node) -> Array:
	var nodes = [scene]
	for child in scene.get_children():
		nodes.append_array(get_nodes_in_scene(child))
	
	return nodes

func _process(delta: float) -> void:
	pass
	#print(len(get_nodes_in_scene(get_tree().current_scene)))
