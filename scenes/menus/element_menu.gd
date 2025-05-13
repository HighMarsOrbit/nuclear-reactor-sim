extends Control

var element_button: BaseButton

func _ready() -> void:
	element_button = $VBoxContainer.get_child(0)
	#$VBoxContainer.remove_child(element_button)
	#element_button.set_text("Test2")
	#$VBoxContainer.add_child(element_button)
	#print($VBoxContainer.get_child(0))
	#var button_2 = element_button.duplicate()
	#button_2.set_text("2nd button")
	#$VBoxContainer.add_child(button_2)
