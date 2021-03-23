extends Area2D

export var time = 10.0

func _ready():
	pass


func _on_fly_powerup_body_entered(body):
	print('_on_fly_powerup_body_entered')
	print(body.name)
	get_tree().call_group('power_up_bar','start',time)
	body.fly()
	queue_free()
