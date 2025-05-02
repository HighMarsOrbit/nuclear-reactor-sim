extends RigidBody2D

@export var radius = 10
@export var outer_radius_thickness: float = 2
@export var inner_color = Color(0, 255, 255)
@export var outer_color = Color(0, 0, 255)
@export var low_speed_threshold: float = 50

var damping = 0.005
var initial_speed

func _ready() -> void:
	$CollisionShape2D.shape.radius = radius + outer_radius_thickness
	initial_speed = linear_velocity.length()
	#get_node("VisibleOnScreenNotifier2D") \
		#.connect("screen_exited", _on_visible_on_screen_notifier_2d_screen_exited)

func _draw() -> void:
	var curr_speed = linear_velocity.length()
	var color_lerp = 1.0 - clamp((curr_speed - low_speed_threshold) / (initial_speed - low_speed_threshold), 0.0, 1.0)
	
	var inner_color_adj = inner_color.lerp(outer_color, color_lerp)
	
	draw_circle(Vector2(), radius, inner_color_adj, true, -1, true)
	draw_circle(Vector2(), radius, outer_color, false, outer_radius_thickness, true)
	#draw_arc(position, 10, 0, 2*PI, 200, Color(0, 0, 255), 3, true)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _physics_process(delta: float) -> void:
	if linear_velocity.length() > low_speed_threshold:
		linear_velocity *= 1-damping
		queue_redraw()
