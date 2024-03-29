-- upvalues
local strgfind = string.gfind

local function ShowColorPicker(r, g, b, callback)
   ColorPickerFrame:SetColorRGB(r, g, b)
   ColorPickerFrame.previousValues = {r, g, b}
   ColorPickerFrame.func, ColorPickerFrame.cancelFunc = callback, callback
   ColorPickerFrame:Hide()
   ColorPickerFrame:Show()
end

local function ColorPickerCallback(restore)
   local r, g, b
   if restore then
      r, g, b = unpack(restore)
   else
      r, g, b = ColorPickerFrame:GetColorRGB()
   end

   Flyout_Config['border_color'][1] = r
   Flyout_Config['border_color'][2] = g
   Flyout_Config['border_color'][3] = b
end

SLASH_FLYOUT1 = "/flyout"
SlashCmdList['FLYOUT'] = function(msg)
   local args = {}
   local i = 1
   for arg in strgfind(strlower(msg), "%S+") do
      args[i] = arg
      i = i + 1
   end

   if not args[1] then
      DEFAULT_CHAT_FRAME:AddMessage("/flyout size [number] - set flyout button size")
      DEFAULT_CHAT_FRAME:AddMessage("/flyout color - adjust the color of the flyout border")
      DEFAULT_CHAT_FRAME:AddMessage("/flyout hover - toggle between opening flyouts by hovering or clicking")
      DEFAULT_CHAT_FRAME:AddMessage("/flyout reset - reset config to default values")
      DEFAULT_CHAT_FRAME:AddMessage(" ")
   elseif args[1] == 'size' then
      if args[2] and type(tonumber(args[2])) == 'number' then
         Flyout_Config['button_size'] = tonumber(args[2])

         DEFAULT_CHAT_FRAME:AddMessage("Flyout button size has been set to " .. args[2] .. ".")
      end
   elseif args[1] == 'color' then
      ShowColorPicker(Flyout_Config['border_color'][1], Flyout_Config['border_color'][2], Flyout_Config['border_color'][3], ColorPickerCallback)

      DEFAULT_CHAT_FRAME:AddMessage("Use the color picker to pick a border color. Click 'Okay' once you're done or 'Cancel' to keep the current color.")
   elseif args[1] == 'hover' then
      Flyout_Config['hover'] = not Flyout_Config['hover']

      Flyout_UpdateBars()

      DEFAULT_CHAT_FRAME:AddMessage("Opening flyouts by hovering has been " .. (Flyout_Config['hover'] and "enabled" or "disabled") .. ".")
   elseif args[1] == 'reset' then
      Flyout_Config = nil
      Flyout_Config = {
         ['button_size'] = 24,
         ['border_color'] = { 0, 0, 0 },
         ['hover'] = false
      }

      DEFAULT_CHAT_FRAME:AddMessage("Flyout config has been reset.")
   end
end