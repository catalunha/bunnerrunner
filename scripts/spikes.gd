tool
extends Area2D

var textures = [
	"res://sprites/Environment/spikes_top.png",
	"res://sprites/Environment/spikes_bottom.png"
]
export(int,'Top','Bottom') var texture = 0 setget set_texture

func _ready():
	pass

func _draw():
	$sprite.texture = load(textures[texture])

func set_texture(value):
	texture = value
	if is_inside_tree() and Engine.editor_hint:
		update()


func _on_spikes_body_entered(body):
	print('_on_spikes_body_entered')
	print(body.name)
	body.killed()
