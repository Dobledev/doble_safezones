local inSafeZone = false

Citizen.CreateThread(function()
    while true do
        Wait(500)

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local isInZone = false

        for _, zone in pairs(Config.SafeZones) do
            local dist = #(playerCoords - zone.coords)
            if dist < zone.radius then
                isInZone = true
                break
            end
        end

        if isInZone and not inSafeZone then
            inSafeZone = true
            SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
            SendNUIMessage({ action = "show" })
        elseif not isInZone and inSafeZone then
            inSafeZone = false
            SendNUIMessage({ action = "hide" })
        end
    end
end)

-- Bloquear acciones agresivas
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if inSafeZone then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 69, true)
            DisableControlAction(0, 92, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 45, true)
            DisablePlayerFiring(PlayerPedId(), true)
        end
    end
end)
