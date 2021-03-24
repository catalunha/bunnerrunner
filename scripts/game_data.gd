extends Node

var file_prize = 'user://prize'
var prizes = {}

func save_prize(stage,prize):
	print(stage,prize)
	prizes[stage]=prize
	print(prizes)
	var file = File.new()
	var err = file.open(file_prize,File.WRITE)
	if err == OK:
		file.store_string(to_json(prizes))
		file.close()
		print('file save')
