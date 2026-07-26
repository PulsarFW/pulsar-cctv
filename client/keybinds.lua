camMoveUp, camMoveDown, camMoveLeft, camMoveRight = false, false, false, false

function RegisterKeyBinds()
	plsr.Keybinds:Add("cctv_disconnect", "ESCAPE", "keyboard", "CCTV - Close Camera", function()
		if plsr.State.flags.inCCTVCam then
			plsr.CCTV:Close()
		end
	end)

	plsr.Keybinds:Add("cctv_previous", "LEFT", "keyboard", "CCTV - Previous Camera", function()
		if plsr.State.flags.inCCTVCam then
            if GlobalState[plsr.State.flags.inCCTVCam.camKey]?.group ~= nil then
				plsr.Callbacks:ServerCallback("CCTV:PreviousInGroup", {})
            end
		end
	end)

	plsr.Keybinds:Add("cctv_next", "RIGHT", "keyboard", "CCTV - Next Camera", function()
		if plsr.State.flags.inCCTVCam then
            if GlobalState[plsr.State.flags.inCCTVCam.camKey]?.group ~= nil then
				plsr.Callbacks:ServerCallback("CCTV:NextInGroup", {})
            end
		end
	end)

	plsr.Keybinds:Add("cctv_up", "W", "keyboard", "CCTV - Rotate Up", function()
		if plsr.State.flags.inCCTVCam then
			camMoveUp = true
		end
	end, function()
		if camMoveUp then
			camMoveUp = false
		end
	end)

	plsr.Keybinds:Add("cctv_down", "S", "keyboard", "CCTV - Rotate Down", function()
		if plsr.State.flags.inCCTVCam then
			camMoveDown = true
		end
	end, function()
		if camMoveDown then
			camMoveDown = false
		end
	end)

	plsr.Keybinds:Add("cctv_left", "A", "keyboard", "CCTV - Rotate Left", function()
		if plsr.State.flags.inCCTVCam then
			camMoveLeft = true
		end
	end, function()
		if camMoveLeft then
			camMoveLeft = false
		end
	end)

	plsr.Keybinds:Add("cctv_right", "D", "keyboard", "CCTV - Rotate Right", function()
		if plsr.State.flags.inCCTVCam then
			camMoveRight = true
		end
	end, function()
		if camMoveRight then
			camMoveRight = false
		end
	end)
end
