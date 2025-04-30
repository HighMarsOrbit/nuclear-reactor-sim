extends RigidBody2D

@export var radius = 10
@export var inner_color = Color(0, 255, 255)
@export var outer_color = Color(0, 0, 255)
@export var outer_radius_thickness = 2

func _ready() -> void:
	$CollisionShape2D.shape.radius = radius
	#get_node("VisibleOnScreenNotifier2D") \
		#.connect("screen_exited", _on_visible_on_screen_notifier_2d_screen_exited)

func _draw() -> void:
	draw_circle(Vector2(), radius, inner_color, true, -1, true)
	draw_circle(Vector2(), radius, outer_color, false, outer_radius_thickness, true)
	#draw_arc(position, 10, 0, 2*PI, 200, Color(0, 0, 255), 3, true)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
