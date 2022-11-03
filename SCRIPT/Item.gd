extends Area2D
#           VARIABLE DECLEARATION
#################################
export(String) var Name_Of_Item
onready var amoun = 1
#################################

func _ready():
	$Label.text = str(Name_Of_Item)

func _on_Item_body_entered(body):
#           DETECTION AND VALIDATION OF ITEM
#################################
	if body.is_in_group("PLAYER"):
		if Name_Of_Item == get_node("/root/QuestLinker").QUEST_TARGET_ITEM_NAME:
			get_node("/root/QuestLinker").CURRENT_NUMBER +=1
			queue_free()
		queue_free()
#################################
