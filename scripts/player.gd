extends KinematicBody2D

onready var mask = collision_mask
onready var layer = collision_layer
const gravity = 1500
const VELOCITY_X = 	200

enum {IDLE,RUNNING,FLYING,DEAD,VICTORY}
var status = IDLE
var velocity = Vector2(500,0)
var jump = false
var jump_release = false
var was_on_floor = false
var controled_jump = false

func _ready():
	$sprite.play('idle')
	set_process_input(true)

func _physics_process(delta):
	if status == RUNNING:
		running(delta)
	elif status == FLYING:
		flying(delta)
	elif status == DEAD:
		dead(delta)
		
	if status != DEAD:
		if position.y > ProjectSettings.get_setting('display/window/size/height'):
			killed()
	jump = false
	jump_release = false

func running(delta):
	velocity.y += gravity * delta
	velocity.x = VELOCITY_X
	velocity = move_and_slide(velocity,Vector2(0,-1))
	if is_on_floor():
		if not was_on_floor:
			$anim_landed.play("boing")
			$dust/anim_smoke.play("dust")
		$sprite.play('walk')
		if jump:
			jump(1500,true)
			$jump.play()
	else:
		$sprite.play('jump')
		if jump_release and velocity.y < 0 and controled_jump:
			velocity.y *= 0.3
			
	was_on_floor = is_on_floor()

func _input(event):
	if event is InputEventScreenTouch or event.is_action("jump"):
		if event.pressed:
			jump = true
		else:
			jump_release = true

func jump(force, controled):
	velocity.y = -force
	controled_jump = controled

func killed():
	if status != DEAD:
		status = DEAD
		collision_mask = 0 
		collision_layer = 0
		velocity = Vector2(0,-1000)
		$dead.play()
		get_tree().call_group('power_up_bar', 'stop')
		get_tree().call_group('game', 'player_dying')
		
func dead(delta):
	$sprite.play('hurt')
	translate(velocity*delta)
	velocity.y += gravity * delta
	if position.y > ProjectSettings.get_setting('display/window/size/height')+100:
		get_tree().call_group('game','player_died')

func fly():
	$sprite.play('jump')
	jump(400,false)
	status = FLYING
	$wings.visible = true
	
func flying(delta):
	velocity.y += gravity * delta
	velocity.x = VELOCITY_X
	velocity = move_and_slide(velocity,Vector2(0,-1))
	if jump:
		$wings/anim.play("flap")
		jump(400,false)
		$flap.play()
	if is_on_floor():
		get_tree().call_group('power_up_bar', 'stop')
		powerup_finished()
		
		
func victory():
	$sprite.play('victory')
	status = VICTORY
	get_tree().call_group('game','player_victory')
	
func powerup_finished():
	if status != DEAD:
		status = RUNNING
		$wings.visible =false

func start():
	status = RUNNING
