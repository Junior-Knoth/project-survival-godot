class_name ToolData
extends ItemData

enum ToolType {
	NONE, PICKAXE, AXE, SHOVEL, SWORD
}

@export var tool_type: ToolType
@export var power: float
@export var use_range: float = 10
