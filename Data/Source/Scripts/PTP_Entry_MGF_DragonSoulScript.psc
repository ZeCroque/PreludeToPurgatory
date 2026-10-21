Scriptname PTP_Entry_MGF_DragonSoulScript extends activemagiceffect  

Perk Property PTP_Entry_PRK_DragonSoul Auto
Quest Property PTP_Framework_QST_MaintenanceQuest Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    Actor playerRef = Game.GetPlayer()
    playerRef.RemovePerk(PTP_Entry_PRK_DragonSoul)
    playerRef.ModAV("DragonSouls", 1.0)

    PTP_QuestMaintenanceScript questMaintenanceScript = PTP_Framework_QST_MaintenanceQuest as PTP_QuestMaintenanceScript
    Input.TapKey(questMaintenanceScript.iTweenKey)
    Input.TapKey(questMaintenanceScript.iTweenControllerKey)
EndEvent