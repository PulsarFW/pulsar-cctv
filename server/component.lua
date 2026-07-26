CreateThread(function()
	RegisterChatCommands()
	SetupCameras()

	plsr.Callbacks:RegisterServerCallback("CCTV:PreviousInGroup", function(source, data, cb)
		local cam = plsr.State:Player(source).inCCTVCam
		if cam then
			for i = cam.camId - 1, 0, -1 do
				if i ~= cam.camId and GlobalState[cam.camKey]?.group == Config.Cameras[i]?.group then
					return plsr.CCTV:View(source, i)
				end
			end

			for i = #Config.Cameras, 0, -1 do
				if i ~= cam.camId and GlobalState[cam.camKey]?.group == Config.Cameras[i]?.group then
					return plsr.CCTV:View(source, i)
				end
			end
		end
	end)

	plsr.Callbacks:RegisterServerCallback("CCTV:NextInGroup", function(source, data, cb)
		local cam = plsr.State:Player(source).inCCTVCam
		if cam then
			for i = cam.camId + 1, #Config.Cameras do
				if i ~= cam.camId and GlobalState[cam.camKey]?.group == Config.Cameras[i]?.group then
					return plsr.CCTV:View(source, i)
				end
			end

			for i = 1, #Config.Cameras do
				if i ~= cam.camId and GlobalState[cam.camKey]?.group == Config.Cameras[i]?.group then
					return plsr.CCTV:View(source, i)
				end
			end
		end
	end)

	plsr.Callbacks:RegisterServerCallback("CCTV:ViewGroup", function(source, data, cb)
		plsr.CCTV:ViewGroup(source, data)
	end)
end)

_CCTV = {
    View = function(self, source, camId)
        if Config.AllowedJobs[plsr.State:Player(source).onDuty] or plsr.Fetch:Source(source).Permissions:IsAdmin() then
			TriggerClientEvent("CCTV:Client:View", source, camId)
		end
    end,
	ViewGroup = function(self, source, camGroup)
		for k, v in ipairs(Config.Cameras) do
			if v?.group == camGroup then
				return plsr.CCTV:View(source, k)
			end
		end

		return nil
	end,
	State = {
		Online = function(self, camId)
			local camKey = string.format("CCTV:Camera:%s", camId)
			if GlobalState[camKey] ~= nil then
				GlobalState[camKey].isOnline = true
			end
		end,
		Offline = function(self, camId)
			local camKey = string.format("CCTV:Camera:%s", camId)
			if GlobalState[camKey] ~= nil then
				GlobalState[camKey].isOnline = false
			end
		end,
		Group = {
			Online = function(self, groupId)
				for k, v in pairs(Config.Cameras) do
					if v.group == groupId then
						plsr.CCTV.State:Online(k)
					end
				end
			end,
			Offline = function(self, groupId)
				for k, v in pairs(Config.Cameras) do
					if v.group == groupId then
						plsr.CCTV.State:Offline(k)
					end
				end
			end,
		}
	},
}

AddEventHandler("Proxy:Shared:RegisterReady", function(component)
	exports["pulsar_core"]:RegisterComponent("CCTV", _CCTV)
end)