## How to

1. Open your macros and create a new macro
2. In the macro body, start by typing `/flyout` and then the names of the spells separated by a semicolon

   - To use a specific rank, you can write `Frostbolt(Rank 1)` (omitting the rank will use the highest rank)
   - Example: `/flyout Summon Imp; Summon Voidwalker; Summon Felhunter`
     
3. Drag the newly created macro to one of your action bars and you're good to go

Clicking the flyout or using the keybind of the action button that the flyout is assigned to will use the flyout's default action. The default action of a flyout is the first action (spell or macro) in the flyout macro. You can right-click a flyout action to set it as the default action on the fly.

The macro command also supports certain modifiers that modify the behavior of the macro:
- `[sticky]` - flyout will remain opened after using one of its items
- `[icon]` - flyout icon will use the icon of its default action

## Compatibility

The add-on relies on functions provided by the default action bar and action button logic implemented by Blizzard. Some add-ons override these functions or use their own and therefore may not work together with this add-on.

Tested and confirmed working with:
- ElvUI
- pfUI
- Bartender2
- Bongos
- Roid-Macros
- CleverMacro
- MacroExtender
