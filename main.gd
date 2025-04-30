extends Node

#@export var atom_scene: PackedScene
@export var atom_scene: PackedScene
var neutron
func _ready() -> void:
	for i in range(500):
		var atom = atom_scene.instantiate()
		atom.position = Vector2(randi_range(100, 500), randi_range(100, 500))
		#atom.linear_velocity = Vector2(randi_range(500, 1000), randi_range(500, 1000))
		
		add_child(atom)

func _process(delta: float) -> void:
	pass
