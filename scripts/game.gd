extends Node

enum {MENU,LOADING,LOADED}
var prize_carrots = [
	{	'average': 0.3,
		'prize':1
	},
	{	'average': 0.6,
		'prize':2
	},
	{	'average': 1,
		'prize':3
	}
]
var pre_golden_carrots = preload("res://scenes/golden_carrots.tscn")
var golden_carrots
var status = MENU
var current_stage
var current_stage_name
var current_music
var loaded_stage
var ref_stage
var stage_coins

func _ready():
 $HUD/stage_exit.visible = false

func stage_selected(button):
	print('stage_selected')
	print(button.stage=='')
	if status == MENU:
		status = LOADING
		current_stage = button.stage
		current_stage_name = button.stage_name
		current_music = button.music
		$interface.visible = false
		load_stage()
		$HUD/controls.visible = true
		$HUD/stage_exit.visible = true
		status = LOADED

func load_stage():
	stage_coins = 0
	$HUD/controls/coin_counter.coins = 0
	if loaded_stage != null && ref_stage.get_ref() != null:
		loaded_stage.queue_free()
	loaded_stage = load(current_stage).instance()
	ref_stage = weakref(loaded_stage)
	if current_music:
		$music.stream = load(current_music)
	add_child(loaded_stage)
	$HUD/count_down/anim.play("count")
	yield($HUD/count_down/anim,'animation_finished')
	get_tree().call_group('player','start')
	play_music()

	
func player_died():
	load_stage()
	stop_music()

func player_dying():
	stop_music()
	

func player_victory():
	stop_music()
	$stream_victory.play()
	var timer = get_tree().create_timer(4)
	yield(timer,"timeout")
	var carrots_average = float($HUD/controls/coin_counter.coins)/float(stage_coins)
	var prize = 0
	for item in prize_carrots:
		if carrots_average >= item['average']:
			prize = item['prize']
	#print('prize:',prize)
	GameData.save_prize(current_stage_name,prize)
	golden_carrots = pre_golden_carrots.instance()
	$HUD.add_child(golden_carrots)
	golden_carrots.play(prize)
	yield(golden_carrots,'carrots_finished')
	yield(get_tree().create_timer(5),"timeout")
	exit_stage()
	

func _on_stage_exit_pressed():
	exit_stage()

func exit_stage():
	stop_music()
	loaded_stage.queue_free()
	$interface.visible = true
	$HUD/controls.visible = false
	$HUD/stage_exit.visible = false
	$HUD/count_down.visible = false
	status = MENU
	if golden_carrots != null and weakref(golden_carrots):
		golden_carrots.queue_free()
	
func play_music():
	if current_music:
		$music.play()
		
func stop_music():
	if current_music:
		$music.stop()

func add_stage_coins():
	stage_coins += 1
