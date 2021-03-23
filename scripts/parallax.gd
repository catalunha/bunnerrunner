tool
extends ParallaxBackground

export(Color) var modulate_layer1 =Color(1,1,1,1) setget set_modulate_layer1
export(Color) var modulate_layer2 =Color(1,1,1,1) setget set_modulate_layer2
export(Color) var modulate_layer3 =Color(1,1,1,1) setget set_modulate_layer3
export(Color) var modulate_layer4 =Color(1,1,1,1) setget set_modulate_layer4

func _ready():

	set_colors()


func set_modulate_layer1(value):
	modulate_layer1 = value
	if is_inside_tree() && Engine.editor_hint:
		set_colors()
func set_modulate_layer2(value):
	modulate_layer2 = value
	if is_inside_tree() && Engine.editor_hint:
		set_colors()
func set_modulate_layer3(value):
	modulate_layer3 = value
	if is_inside_tree() && Engine.editor_hint:
		set_colors()
func set_modulate_layer4(value):
	modulate_layer4 = value
	if is_inside_tree() && Engine.editor_hint:
		set_colors()

func set_colors():
	$layer1/bg_layer1.modulate = modulate_layer1
	$layer2/bg_layer2.modulate = modulate_layer2
	$layer3/bg_layer3.modulate = modulate_layer3
	$layer4/bg_layer4.modulate = modulate_layer4
