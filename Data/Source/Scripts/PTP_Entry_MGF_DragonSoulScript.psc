Scriptname PTP_Entry_MGF_DragonSoulScript extends activemagiceffect  

Perk Property PTP_Entry_PRK_DragonSoul Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    Actor playerRef = Game.GetPlayer()
    playerRef.RemovePerk(PTP_Entry_PRK_DragonSoul)
    playerRef.ModAV("DragonSouls", 1.0)
    
    Int iTweenKey = Input.GetMappedKey("Tween Menu", 0)
    If iTweenKey > 0
        Input.TapKey(iTweenKey)
    EndIf
EndEvent