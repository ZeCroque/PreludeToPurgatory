# Prelude to Purgatory - Fixes & Tweaks

## Index:

1. Overview
2. Details
3. Frequently Asked Questions
4. Known Issues
5. Mod content
6. Installation
7. Compatibility
8. My other mods
9. Recommended Mods
10. Credits
11. Tools used
12. Licensing/Legal 
13. Feedback

## 1. OVERVIEW

My personal tweaks for the great "Prelude to Purgatory" mod by SeaSparrow.

## 2. DETAILS

I really like the mod "Prelude to Purgatory", but I feel like some features are a bit too cheaty or not lore-friendly. This mod is a attempt to fix that, alongside some QoL changes.

The mod makes some general changes to your lich condition, tweaks some perks, improves the equipment logic while transforming and even carries a little fix. Here's the full details.

### General changes

- You can change your lich appearance or relocate your phylactery at any time (no requirements)
- Health potion will heal you as normal (but still with a 50% efficiency malus without the "Transcendence" perk)
- Lich transformation will always turn NPCs hostile, no perk will change this behavior
- Food doesn't have any effect, no perk will change this behavior
- Your lich transformation will always turn NPC hostile, no perk will change this behavior
- There's no level cap for the lich skill tree (useful for the "Dragon Soul" perk)

### Perk Changes

- Reconstruct form: it is now called "Necrotic Rejuvenation" and is rank based. The bonus goes from 20% to 100% and the final ranks makes Restoration spell efficient again
- Transcendence: 
    - The XP boost has been lowered from 25% down to 10%
    - Potions goes from 50% duration/magnitude to 100% with the perk
- Frozen Cadavers: The undead minions hit by your frost spells are now temporarily immune to frost damage
- Dragon Soul: Gives Dragon Souls for perk points. Can be used indefinitely.

### Lich Equipping Logic

I found very frustrating the lich transformation always changes your equipped spells. It was somewhat required to make sure the player doesn't hold a staff in the left hand (which is not supported by the Dragon Priests animations), but I managed to find a less intrusive way to circumvent the issue. 

If you equip yourself correctly before transforming, nothing will be changed. Otherwise, the mod will auto-correct with the following logic:
- If you have a staff in the left hand, then:
    - If you also have one in the right hand, it will be replaced by the "Ice Coffin" spell
    - Else, your hands will be switched
- Any non-staff weapon will then be replaced by a default spell ("Ice Coffin" for left or "Death Grip" for right)

Additionally, if you equip a staff in the left hand while you're in lich form, it will be moved to the right hand, setting the left hand to the spell that was previously on the right side if applicable (otherwise it will be set to "Ice Coffin"). Any non-staff equipment will be replaced by the appropriate default spell.

Finally, the keybind that resets your lich equipment now takes into account the setup you had when you transformed:
- If you had a staff and a spell, then resetting will yield that staff in the right hand and Ice Coffin in the left hand
- If you had two spell, then resetting will yield Ice Coffin in the left hand and Death Grip in the right hand

That logic technically don't require "Prelude to Purgatory" to work, but I needed to override the same scripts so I made it a dependency anyway (let me know if you're absolutely interested by this but don't want PtP).

### Misc fix

Eventually, I also fixed the duplicated "Lich Sight" power. The default one added by Classical Lichdom will be gone upon your next transformation and you'll have access to the improved version once you take the perk from PtP.

### Supported languages

The mod is available in the following languages:
- English
- French

## 3. REQUIREMENTS

- [SKSE64](https://www.nexusmods.com/skyrimspecialedition/mods/30379)
- [Address Library for SKSE Plugins](https://www.nexusmods.com/skyrimspecialedition/mods/32444)
- [Custom Skills Framework](https://www.nexusmods.com/skyrimspecialedition/mods/41780)
- [Undeath Remastered](https://www.nexusmods.com/skyrimspecialedition/mods/6180)
- [Undeath - Classical Lichdom v4](https://www.nexusmods.com/skyrimspecialedition/mods/40802)
- [Prelude to Purgatory - A Lich Custom Skill Tree](https://www.nexusmods.com/skyrimspecialedition/mods/53143)

## 4. KNOWN ISSUES

None. Please let me know if you find any.

## 5. MOD CONTENT

This mod consists of three main files : 
- *PreludeToPurgatory.esp* (small master)
- *PreludeToPurgatory.bsa*
- *SKSE/Plugins/CustomSkills/Lichdom.json*

## 6. INSTALLATION

**Automatic (Recommended)**
- Use the Mod Manager Download button. Install and enable the file(s) in your favorite mod manager (ModOrganizer2 is my personal preference).

**Manual**
- Extract the required files (cf. `5. MOD CONTENT`) from the archive to your Data folder and activate them in the in-game Creations menu.

## 7. COMPATIBILITY

No known incompatibility. Please let me know if you find any.

## 8. MY OTHER MODS

- [Undeath - Alternate Lichdom Paths](https://www.nexusmods.com/skyrimspecialedition/mods/197102)
- [Undeath - Shouts and Hotkeys Enabled](https://www.nexusmods.com/skyrimspecialedition/mods/197101)
- [Soul Cairn Patches](https://www.nexusmods.com/skyrimspecialedition/mods/197103)

## 9. CREDITS

- Thanks to Bethesda Softworks for this great game
- Thanks to the authors of the patched mods
- Thanks to the authors of the tools listed below
- Thanks to xtcrefugee for answering my questions about mid/small masters on the Starfield Modding Discord

## 10. TOOLS USED

- Creation Kit
- xEdit
- Visual Studio Code
- xTranslator
- Bethesda Archive Extractor
- Champollion
- Gimp & Photopea

## 11. LICENSING/LEGAL

If you want to modify and/or redistribute this mod, I would like to be contacted first please. Note that it is under GPL3 licensing, thus you have the obligation to make any modification done to the original source code available somewhere publicly.

You can find the source code [here](https://github.com/ZeCroque/PreludeToPurgatory).

## 12. FEEDBACK

*Found a bug or have an idea for new features? Let me know in the comment section!*