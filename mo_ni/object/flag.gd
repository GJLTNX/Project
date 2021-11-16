tool
extends Area2D

export var next_level:PackedScene

onready var animate_player = $AnimationPlayer

func _get_configuration_warning():
	return '没有设置下一关场景' if not next_level else ''
	
func _on_flag_body_entered(body):
	animate_player.play("start")
	
	yield(animate_player,"animation_finished")
	
	get_tree().change_scene_to(next_level)
