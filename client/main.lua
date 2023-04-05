local function notify(text)
    lib.notify({
        description = text,
        type = 'error'
    })
end

local function getCallsignDigit(callsign, digit)
	local n = 10 ^ digit
	local n1 = 10 ^ (digit - 1)

	return math.floor((callsign % n) / n1)
end

local function setCallsign(vehicle, callsign)
    if not vehicle then 
        notify('No vehicle to change callsign on!')
        return 
    end

    if not callsign then
        notify('No callsign provided!')
        return 
    end

    local length = #callsign

    if length > 3 or length < 3 then
        notify('The length of your callsign must be 3 digits long!')
        return 
    end

    callsign = tonumber(callsign)

    if not callsign then
        notify('Callsign must be a 3 digit number!')
        return
    end

    local one, two, three = getCallsignDigit(callsign, 3), getCallsignDigit(callsign, 2), getCallsignDigit(callsign, 1)

    SetVehicleModKit(vehicle, 0)
    SetVehicleMod(vehicle, 42, one, false)
    SetVehicleMod(vehicle, 44, two, false)
    SetVehicleMod(vehicle, 45, three, false)
end
exports('SetCallsign', setCallsign)

RegisterCommand('callsign', function()
    if not Config.AllowCommand then return end

    local input = lib.inputDialog('Vehicle Identifier', {
        {type = 'input', label = 'Callsign', icon = 'hashtag'},
    })

    if not input then return end

    local callsign = input[1]

    setCallsign(cache.vehicle, callsign)
end)