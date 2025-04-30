extends Area2D

enum States {
	DECAY,
	DECAY_EMIT,
	URANIUM,
	XENON
}

@export var radius = 10
@export var decay_color = Color(0, 255, 0)
@export var uranium_color = Color(255, 0, 0)
@export var xenon_color = Color(0, 0, 0)
@export var neutron_scene: PackedScene
var curr_state = States.DECAY

func _ready() -> void:
	$CollisionShape2D.shape.radius = radius

func _draw() -> void:
	var color = decay_color
	match curr_state:
		States.URANIUM:
			color = uranium_color
		States.XENON:
			color = xenon_color
			
	draw_circle(Vector2(0, 0), radius, color, true, -1, true)
	#draw_arc(position, 10, 0, 2*PI, 200, Color(0, 0, 255), 3, true)
func spawn_neutron():
	var neutron = neutron_scene.instantiate()
	neutron.position = position
	var angle = randf_range(0, 2*PI)
	var vel_scale = 20
	neutron.linear_velocity = Vector2(cos(angle) * vel_scale, sin(angle) * vel_scale)
	get_tree().get_root().add_child(neutron)

func _process(delta: float) -> void:
	if curr_state == States.DECAY:
		if randi_range(0, 100) == 1:
			spawn_neutron()
