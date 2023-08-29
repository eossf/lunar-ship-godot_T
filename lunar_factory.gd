extends Node2D

@export var scene: PackedScene = preload("res://lunar.tscn")

func _unhandled_input(event):
	if event.is_echo():
		return
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			spawn(get_global_mouse_position())


func spawn(spawn_global_position):
	var instance = scene.instantiate()
	instance.global_position = spawn_global_position
	add_child(instance)
