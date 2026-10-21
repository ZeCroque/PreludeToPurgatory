ScriptName LichNecroActorScript Extends ActiveMagicEffect
{ Abilities and FX for Lich }

;-- Variables ---------------------------------------
Float PlayerMG
Int iStaffKeyCode
Int doOnce = 0
Float DragonPriestHealth
Actor selfRef
Float PlayerST
Float PlayerHP
Int iFavoriteKeyCode

;-- Properties --------------------------------------
Armor Property DragonPriestArmor01 Auto
{ Glowing cape and mouth streams armor }
Spell Property NecroRevert Auto
Race Property LichRace Auto
Quest Property NecroTrackingQuest Auto
Race Property playerRace Auto
Explosion Property FXDragonPriestLargeExplosion Auto
{ large dust fabric and metal bits explosion played on dying }
Message Property NecroUCLUnequipAmmoMsg Auto
Armor Property NecroLichForm Auto
MagicEffect Property NecroRevertEffect Auto
Actor Property PlayerRef Auto
Explosion Property FXDragonPriestSmallExplosion Auto
{ dust and fabric explosion played on state change }
Faction Property LichFaction Auto
Message Property NecroUCLUnequipWpnMsg Auto
Int Property Stamina Auto
GlobalVariable Property NecroUCLKeyCodeInt Auto
Int Property Magicka Auto
Int Property HP Auto
Spell Property NecroDeathGrip Auto
GlobalVariable Property NecroUCLFavoriteKeyCodeInt Auto
Spell Property NecroUCLIceCoffin Auto
Activator Property AshPileObject Auto
{ The object we use as a pile. }
Weapon Property NecroStaffOfWorms Auto
VisualEffect Property FXfallingSandDragonPriestEffect Auto
{ falling sand from holes fx }
GlobalVariable Property NecroLichEyeFXValue Auto

;-- Functions ---------------------------------------

Event OnDying(Actor akKiller)
  selfRef.placeAtMe(FXDragonPriestLargeExplosion as Form, 1, False, False)
  selfRef.PlaySubGraphAnimation("stage3")
  selfRef.unequipitem(DragonPriestArmor01 as Form, False, False)
  (NecroTrackingQuest as necrotrackingquestscript).UCLStopEyeFX(selfRef)
  Utility.wait(1.0)
  selfRef.AttachAshPile(AshPileObject as Form)
  Utility.wait(2.0)
  FXfallingSandDragonPriestEffect.Stop(selfRef as ObjectReference)
EndEvent

Function OnKeyDown(Int KeyCode)
  If PlayerRef.GetRace() == LichRace && !Utility.IsInMenuMode()
    If KeyCode == iStaffKeyCode
      If(!(NecroTrackingQuest as necrotrackingquestscript).Staff)
        PlayerRef.equipspell(NecroUCLIceCoffin, 0)
        PlayerRef.equipspell(NecroDeathGrip, 1)
        PlayerRef.equipspell(NecroRevert, 2)
      Else
        PlayerRef.equipspell(NecroUCLIceCoffin, 0)
        PlayerRef.EquipItemEx((NecroTrackingQuest as necrotrackingquestscript).Staff, 0, False, False)
        PlayerRef.equipspell(NecroRevert, 2)
      EndIf            
      PlayerRef.DrawWeapon()        
      Debug.SendAnimationEvent(PlayerRef as ObjectReference, "Magic_Equip")
    ElseIf KeyCode == iFavoriteKeyCode
      Game.SetBeastForm(False)
      Self.RegisterForMenu("FavoritesMenu")
      ui.InvokeString("HUD Menu", "_global.skse.OpenMenu", "FavoritesMenu")
    EndIf
  EndIf
EndFunction

; Skipped compiler generated GotoState

Event OnUpdate()
  If !Self.RegisterForAnimationEvent(selfRef as ObjectReference, "IdleStop")
    Debug.trace("UCL: IdleStop registration still failed, trying again....", 0)
    Self.RegisterForSingleUpdate(3.0)
  EndIf
EndEvent

Function OnMenuClose(String MenuName)
  If PlayerRef.GetRace() == LichRace
    If MenuName == "MagicMenu"
      Game.SetBeastForm(True)
      Game.UpdateThirdPerson()
    ElseIf MenuName == "FavoritesMenu"
      Game.SetBeastForm(True)
      Game.UpdateThirdPerson()
    ElseIf MenuName == "InventoryMenu"
      Game.SetBeastForm(True)
      Game.UpdateThirdPerson()
    EndIf
  EndIf
EndFunction

Event OnGetUp(ObjectReference akFurniture)
  Debug.Notification("Player just got up.")
  selfRef.equipitem(DragonPriestArmor01 as Form, False, False)
  (NecroTrackingQuest as necrotrackingquestscript).UCLHandleEyeFX(selfRef)
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
  (NecroTrackingQuest as necrotrackingquestscript).UCLStopEyeFX(selfRef)
EndEvent

Function UCLSpellMenuHack()
  Game.SetBeastForm(False)
  ui.InvokeString("HUD Menu", "_global.skse.OpenMenu", "MagicMenu")
  Self.RegisterForMenu("MagicMenu")
  Self.RegisterForMenu("InventoryMenu")
EndFunction

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
  DragonPriestHealth = selfRef.GetActorValuePercentage("health")
  If DragonPriestHealth <= 0.3 && doOnce < 1
    selfRef.placeAtMe(FXDragonPriestSmallExplosion as Form, 1, False, False)
    FXfallingSandDragonPriestEffect.play(selfRef as ObjectReference, -1 as Float, None)
    selfRef.PlaySubGraphAnimation("stage2")
    doOnce += 1
  EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
  If akBaseObject as Weapon
    Weapon W = akBaseObject as Weapon
    Int WeaponType = W.GetWeaponType()
    If WeaponType == 8
      If(PlayerRef.GetEquippedWeapon(true))
        Spell oldSpell = PlayerRef.GetEquippedSpell(1)
        If(oldSpell)
          PlayerRef.EquipSpell(oldSpell, 0)
        Else
          PlayerRef.EquipSpell(NecroUCLIceCoffin, 0)
        EndIf
        PlayerRef.EquipItemEx(w, 0, False, False)
      EndIf
    ElseIf WeaponType != 0
      If(PlayerRef.GetEquippedWeapon(true) == w)
        PlayerRef.equipspell(NecroUCLIceCoffin, 0)
      Else
        PlayerRef.equipspell(NecroDeathGrip, 1)
      EndIf
      NecroUCLUnequipWpnMsg.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
    EndIf
  ElseIf akBaseObject as Ammo
    Ammo A = akBaseObject as Ammo
    PlayerRef.unequipitem(A as Form, False, False)
    NecroUCLUnequipAmmoMsg.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
  EndIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, String asEventName)
  If asEventName == "IdleStop" && akSource == PlayerRef as ObjectReference
    Self.UCLSpellMenuHack()
  EndIf
EndEvent

Event OnEffectStart(Actor Target, Actor Caster)
  selfRef = Caster
  If selfRef.GetSleepState() == 3
    
  Else
    (NecroTrackingQuest as necrotrackingquestscript).UCLHandleEyeFX(selfRef)
  EndIf
  iStaffKeyCode = NecroUCLKeyCodeInt.GetValueInt()
  iFavoriteKeyCode = NecroUCLFavoriteKeyCodeInt.GetValueInt()
  Self.RegisterForKey(iStaffKeyCode)
  Self.RegisterForKey(iFavoriteKeyCode)
  If !Self.RegisterForAnimationEvent(selfRef as ObjectReference, "IdleStop")
    Debug.trace("UCL: Could not register for IdleStop, trying again on update....", 0)
    Self.RegisterForSingleUpdate(3.0)
  EndIf
EndEvent

Event OnAnimationEventUnregistered(ObjectReference akSource, String asEventName)
  ; Empty function
EndEvent

; Skipped compiler generated GetState
