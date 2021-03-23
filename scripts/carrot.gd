extends Area2D


func _ready():
	pass


func _on_carrot_body_entered(body):
	print('_on_carrot_body_entered')
	print(body.name)
	body.victory()





func _on_deadzone_body_entered(body):
	print('_on_deadzone_body_entered')
	print(body.name)
	body.killed()
