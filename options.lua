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

   Flyout_Config['BORDER_COLOR'][1] = r
   Flyout_Config['BORDER_COLOR'][2] = g
   Flyout_Config['BORDER_COLOR'][3] = b
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
      DEFAULT_CHAT_FRAME:AddMessage("/flyout size [number||reset] - set flyout button size")
      DEFAULT_CHAT_FRAME:AddMessage("/flyout color [reset] - adjust the color of the flyout border")
      DEFAULT_CHAT_FRAME:AddMessage("/flyout arrow [number||reset] - adjust the relative size of the flyout arrow")
      DEFAULT_CHAT_FRAME:AddMessage(" ")
   elseif args[1] == 'size' then
      if args[2] then
         if type(tonumber(args[2])) == 'number' then
            Flyout_Config['BUTTON_SIZE'] = tonumber(args[2])
         elseif args[2] == 'reset' then
            Flyout_Config['BUTTON_SIZE'] = FLYOUT_DEFAULT_CONFIG['BUTTON_SIZE']
         end
         DEFAULT_CHAT_FRAME:AddMessage("Flyout button size has been set to " .. Flyout_Config['BUTTON_SIZE'] .. ".")
      end
   elseif args[1] == 'color' then
      if args[2] == 'reset' then
         Flyout_Config['BORDER_COLOR'][1] = FLYOUT_DEFAULT_CONFIG['BORDER_COLOR'][1]
         Flyout_Config['BORDER_COLOR'][2] = FLYOUT_DEFAULT_CONFIG['BORDER_COLOR'][2]
         Flyout_Config['BORDER_COLOR'][3] = FLYOUT_DEFAULT_CONFIG['BORDER_COLOR'][3]
         DEFAULT_CHAT_FRAME:AddMessage("Flyout border color has been reset.")
      else
         ShowColorPicker(Flyout_Config['BORDER_COLOR'][1], Flyout_Config['BORDER_COLOR'][2], Flyout_Config['BORDER_COLOR'][3], ColorPickerCallback)
         DEFAULT_CHAT_FRAME:AddMessage("Use the color picker to pick a border color. Click 'Okay' once you're done or 'Cancel' to keep the current color.")
      end
   elseif args[1] == 'arrow' then
      if args[2] then
         if type(tonumber(args[2])) == 'number' then
            Flyout_Config['ARROW_SCALE'] = tonumber(args[2])
         elseif args[2] == 'reset' then
            Flyout_Config['ARROW_SCALE'] = FLYOUT_DEFAULT_CONFIG['ARROW_SCALE']
         end
         DEFAULT_CHAT_FRAME:AddMessage("Flyout arrow scale has been set to " .. Flyout_Config['ARROW_SCALE'] .. ".")
         Flyout_UpdateBars()
      end
   end
end