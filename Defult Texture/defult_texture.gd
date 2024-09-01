@tool
extends EditorPlugin
#Change the path to whatever texture you want as teh defult ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
@export_file("*.tres") var default_material_path: String = "res://addons/Defult Texture/Missing_Texture.tres"
var default_material: Material

func _ready():
	load_default_material()
	apply_material_to_children()
	
	if Engine.is_editor_hint():
		get_tree().node_added.connect(_on_node_added)

func load_default_material():
	default_material = load(default_material_path)

func _on_node_added(node):
	if node is MeshInstance3D:
		apply_material(node)

func apply_material_to_children():
	for child in get_children():
		if child is MeshInstance3D:
			apply_material(child)

func apply_material(node: MeshInstance3D):
	node.material_override = default_material

func _exit_tree():
	if Engine.is_editor_hint():
		get_tree().node_added.disconnect(_on_node_added)
