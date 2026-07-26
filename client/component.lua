createdCamera = 0
globalWait = 10
globalCamera = 0
hacking = false
inCamera = false
low = "CAMERA_secuirity"
offlineCam = "Broken_camera_fuzz"

local cameraActive = false
local allowedToSwitch = false
local currentCameraIndex = 0
local currentCameraIndexIndex = 0
local currentTimecycle = nil
local offline = false
local canrotate = false

CreateThread(function()
	plsr.State.flags.inCCTVCam = false
	RegisterKeyBinds()
end)

_CCTV = {
	View = function(self, camId)
		local camKey = string.format("CCTV:Camera:%s", camId)
		EnterCam(camId)
	end,
	Close = function(self)
		if plsr.State.flags.inCCTVCam then
			ExitCam()
		end
	end,
}

AddEventHandler("Proxy:Shared:RegisterReady", function(component)
	exports["pulsar_core"]:RegisterComponent("CCTV", _CCTV)
end)
