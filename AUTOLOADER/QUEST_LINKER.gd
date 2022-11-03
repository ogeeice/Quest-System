extends Node

#           CURRENT QUEST DETAILS
#################################
var QUEST_TARGET_ITEM_NAME = "NONE"
var QUEST_ID = "NONE"
var QUEST_OBJECTIVE = "NONE"
var QUEST_TARGET_AMOUNT = 0
var CURRENT_NUMBER = 0
#################################

#           CURRENT QUEST STATES
#################################
enum QUEST_BEHAVIOUR {ACTIVE,COMPLETE}
var QUEST_STAT = QUEST_BEHAVIOUR.ACTIVE
#################################



func _process(_delta):
#           QUEST PROGRESS CALCULATION
#################################
	if QUEST_ID != null:
		if  CURRENT_NUMBER < QUEST_TARGET_AMOUNT:
			QUEST_STAT = QUEST_BEHAVIOUR.ACTIVE
		elif CURRENT_NUMBER >= QUEST_TARGET_AMOUNT:
			QUEST_STAT = QUEST_BEHAVIOUR.COMPLETE
#################################
	
	
#           QUEST PROGRESS OUTCOME
#################################
	if QUEST_STAT == QUEST_BEHAVIOUR.ACTIVE:
		print("CURRENT AMOUNT:    ",CURRENT_NUMBER)
	elif QUEST_STAT == QUEST_BEHAVIOUR.COMPLETE:
		print("COMPLETE AMOUNT:     ",CURRENT_NUMBER)
#################################
