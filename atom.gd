extends Area2D

enum States {
	DECAY,
	DECAY_EMIT,
	URANIUM,
	XENON,
	UNUSED,
}

@export var radius = 10
@export var decay_color = Color(0, 255, 0)
@export var uranium_color = Color(255, 0, 0)
@export var xenon_color = Color(0, 0, 0)
@export var neutron_scene: PackedScene
@export var neutron_spawn_probability: float = 0.001
@export var neutron_velocity_scale: float = 20
@export var water_color_cold = Color(0, 0, 255, 255)
@export var water_color_hot = Color(255, 0, 0, 255)
@export var water_box_width: float = 10

var curr_state = States.DECAY
var curr_temp = 0

var prev_temp = -1
var prev_state = States.UNUSED

func _ready() -> void:
	$AtomCollision.shape.radius = radius

func _draw() -> void:
	var water_origin = water_box_width / 2
	var water_color
	if curr_temp <= 1:
		water_color = water_color_cold.lerp(water_color_hot, curr_temp)
	else:
		water_color = Color(0, 0, 0, 0)
	draw_rect(Rect2(-water_origin, -water_origin, water_box_width, water_box_width), water_color)
	
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
	neutron.linear_velocity = Vector2.from_angle(angle) * neutron_velocity_scale
	get_tree().get_root().add_child(neutron)

func _physics_process(delta: float) -> void:
	if curr_state == States.DECAY:
		if randi_range(0, round(1/neutron_spawn_probability)) == 1:
			spawn_neutron()
	curr_temp += 0.01
	
	if prev_temp != curr_temp or prev_state != curr_state:
		queue_redraw()
	#print(curr_temp)
