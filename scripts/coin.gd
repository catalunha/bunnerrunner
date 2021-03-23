extends Area2D


func _ready():
	get_tree().call_group('game','add_stage_coins')


func _on_coin_body_entered(body):
	$audio.play()
	$sprite.visible=false
	collision_mask=0
	$timer_queue.start()
	$particles.emitting=true
	get_tree().call_group('coin_counter','coin_collected')


func _on_timer_queue_timeout():
	queue_free()
	
