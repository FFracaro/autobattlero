extends Node3D

@export var camera_path: NodePath
@onready var main_camera = get_node(camera_path)

var selected_character: Node3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_or_deselect"):
		deselect_character()

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_origin = main_camera.project_ray_origin(mouse_pos)
		var ray_end = ray_origin + main_camera.project_ray_normal(mouse_pos) * 1000

		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.new()
		query.from = ray_origin
		query.to = ray_end

		var result = space_state.intersect_ray(query)

		if result:
			var collider = result.collider
			if collider is CharacterBody3D:
				select_character(collider.get_parent())

func select_character(character: Node3D):
	# Deselect the previous character if one exists
	if selected_character:
		# Trigger deselection logic (e.g., hide highlight, change material)
		if selected_character.has_method("deselect"):
			selected_character.deselect()

	# Select the new character
	selected_character = character

	# Trigger selection logic (e.g., show highlight, update UI)
	if selected_character.has_method("select"):
		selected_character.select()

	# Get its unique instance ID.
	var character_id = selected_character.get_instance_id()
	print("Character's unique instance ID is: ", character_id)

func deselect_character() -> void:
	# Check if a character is currently selected.
	if selected_character:
		# Call a public function on the character's root node to handle the deselection.
		if selected_character.has_method("deselect"):
			selected_character.deselect()
			
		print("Deselected character: ", selected_character.get_instance_id())
		# Clear the reference to the selected character.
		selected_character = null
		
	else:
		print("No character is currently selected.")
