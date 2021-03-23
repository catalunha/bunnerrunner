extends Area2D


func _ready():
	pass


func _on_coil_body_entered(body):
	$animSprite.play('action')
	$sound.play()
	body.jump(1500,false)
