extends Node3D

# Use NodePath properties to assign the children in the Inspector
@export var character_body_path: NodePath
@export var animation_player_path: NodePath
@export var resources_ui_path: NodePath

# Create @onready variables to hold references to the children
@onready var character_body: CharacterBody3D = get_node(character_body_path)
@onready var animation_player: AnimationPlayer = get_node(animation_player_path)
@onready var resources_ui = get_node(resources_ui_path)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func select() -> void:
	# Add your selection logic here (e.g., show a highlight).
	print(self.name, " is now selected.")

func deselect() -> void:
	# Add your deselection logic here (e.g., hide the highlight).
	print(self.name, " is now deselected.")
