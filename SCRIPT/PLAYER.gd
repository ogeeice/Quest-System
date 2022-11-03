extends KinematicBody2D

var QuestLog = false
var Questing = false

const SPEED = 180
var motion =Vector2()

func _input(event):
	if event.is_action_pressed("Quest"):
		QuestLog = !QuestLog

func _physics_process(_delta):
	$CanvasLayer/Quest_Bubble.visible = QuestLog
	Quest_Log()
	
	if Input.is_action_pressed('ui_right'):
		motion.x= SPEED
	elif Input.is_action_pressed('ui_left'):
		motion.x= -SPEED
	else:
		motion.x=0
	
	if Input.is_action_pressed('ui_up'):
		motion.y = -SPEED
	elif Input.is_action_pressed('ui_down'):
		motion.y = SPEED
	else:
		motion.y = 0

	motion = move_and_slide(motion)



func Quest_Log():
#           QUEST INFO COLLECTING
#################################
	$CanvasLayer/Quest_Bubble/QuestTarget.text = str($"/root/QuestLinker".QUEST_TARGET_ITEM_NAME)
	$CanvasLayer/Quest_Bubble/QuestID.text = str($"/root/QuestLinker".QUEST_ID)
	$CanvasLayer/Quest_Bubble/QuestOBJ.text = str($"/root/QuestLinker".QUEST_OBJECTIVE)
	$CanvasLayer/Quest_Bubble/ItemAmount.text = str($"/root/QuestLinker".CURRENT_NUMBER," / ",$"/root/QuestLinker".QUEST_TARGET_AMOUNT)
#################################
