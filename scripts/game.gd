extends Node

enum {MENU,LOADING,LOADED}
var status = MENU
var current_stage
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
	print(stage_coins)

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
	exit_stage()
	print($HUD/controls/coin_counter.coins)

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
	
func play_music():
	if current_music:
		$music.play()
		
func stop_music():
	if current_music:
		$music.stop()

func add_stage_coins():
	stage_coins += 1
