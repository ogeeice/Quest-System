extends Area2D

var active = false
var started = false
var Info_Pass = true

export(String) var QUEST_ID
export(String) var QUEST_OBJECTIVE

export(String) var NAME_OF_TARGET
export var TARGET_AMOUNT = 0

export var DIALOGUES = PoolStringArray()

enum QUEST_STATES {INACTIVE,DECLINE,ACTIVE,COMPLETE,DISABLED}
var QUEST_STATUS = QUEST_STATES.INACTIVE

onready var Message_Label = $CanvasLayer/Decision/Message
onready var Message_Box = $CanvasLayer/Decision
onready var Decision_Box = $CanvasLayer/Decision/Options

var outcome
func _process(_delta):
#################################
	$INTERACT.visible = active  #   TOGGLES TEXT VISIBILITY
#################################
	outcome = get_node("/root/QuestLinker")
	
	
	if active == true:
		if Input.is_action_just_pressed("Interact"):
			Message_Box.visible = active
			
			if outcome.QUEST_ID == "NONE":
				if started == false:
					QUEST_STATUS = QUEST_STATES.INACTIVE
			elif outcome.QUEST_ID == QUEST_ID:
				if outcome.QUEST_STAT == outcome.QUEST_BEHAVIOUR.COMPLETE:
					QUEST_STATUS = QUEST_STATES.COMPLETE
			elif outcome.QUEST_ID != QUEST_ID:
				if outcome.QUEST_ID != "NONE":
					QUEST_STATUS = QUEST_STATES.DECLINE

	if QUEST_STATUS == QUEST_STATES.INACTIVE:
		Message_Label.text = str(DIALOGUES[0])
		Decision_Box.show()
	elif QUEST_STATUS == QUEST_STATES.DECLINE:
		Message_Label.text = str(DIALOGUES[3])
		Decision_Box.hide()
	elif QUEST_STATUS == QUEST_STATES.ACTIVE:
		if Info_Pass == true:
			Send_Info()
		Message_Label.text = str(DIALOGUES[1])
	elif QUEST_STATUS == QUEST_STATES.COMPLETE:
		Message_Label.text = str(DIALOGUES[2])
		Reward()
	elif QUEST_STATUS == QUEST_STATES.DISABLED:
		$CollisionShape2D.disabled = true


func Send_Info():
	get_node("/root/QuestLinker").QUEST_ID = QUEST_ID
	get_node("/root/QuestLinker").QUEST_OBJECTIVE = QUEST_OBJECTIVE
	get_node("/root/QuestLinker").QUEST_TARGET_ITEM_NAME = NAME_OF_TARGET
	get_node("/root/QuestLinker").QUEST_TARGET_AMOUNT = TARGET_AMOUNT
	Info_Pass = false

func Reward():
	yield(get_tree().create_timer(0.5),"timeout")
	get_node("/root/QuestLinker").QUEST_ID = "NONE"
	get_node("/root/QuestLinker").QUEST_OBJECTIVE = "NONE"
	get_node("/root/QuestLinker").QUEST_TARGET_ITEM_NAME = "NONE"
	get_node("/root/QuestLinker").QUEST_TARGET_AMOUNT = 0
	get_node("/root/QuestLinker").CURRENT_NUMBER = 0
	QUEST_STATUS = QUEST_STATES.DISABLED

#           BEGINS CONVERSATION
#################################
func _on_NPC_body_entered(body):
	if body.is_in_group("PLAYER"):
		active = true
#################################

#           END CONVERSATION
#################################
func _on_NPC_body_exited(body):
	if body.is_in_group("PLAYER"):
		active = false
		Message_Box.visible = active
		Message_Label.text = str("")
#################################

#           ACCEPT QUEST
#################################
func _on_Y_pressed():
	started = true
	QUEST_STATUS = QUEST_STATES.ACTIVE
	Decision_Box.hide()
#################################

#           DECLINE QUEST
#################################
func _on_N_pressed():
	active = false
	Message_Label.text = str("")
	Decision_Box.hide()
#################################
