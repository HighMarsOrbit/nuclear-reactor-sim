extends Button

@export
var element_to_spawn: PackedScene

func _pressed() -> void:
	var element = element_to_spawn.instantiate()
	
	if "selected" in element:
		element.selected = true
		#element.height_order = Globals.topmost
	else:
		element.get_child(0).selected = true
		#element.get_child(0).height_order = Globals.topmost
	element.z_index = Globals.topmost
	Globals.topmost += 1
	
	var root_node = get_tree().root.get_child(1)
	root_node.add_child(element)
	
	
