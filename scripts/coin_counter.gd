extends Node2D

var coins = 0 setget set_coin

func _ready():
	update_label()
	add_to_group('coin_counter')


func coin_collected():
	self.coins += 1

func update_label():
	$label.text = str(coins)

func set_coin(value):
	coins = value
	update_label()
	
