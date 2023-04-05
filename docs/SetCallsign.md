# SetCallsign

Change the callsign on your vehicle.
```lua
local ped = PlayerPedId()
local vehicle = GetVehiclePedIsIn(ped, false)
local callsign = '000'

exports.scully_callsign:SetCallsign(vehicle, callsign)
```