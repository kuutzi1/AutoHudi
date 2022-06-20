-- MPH paska älä käytä :D
local mph = 2.2369
-- KMH kannattaa käyttää :D
local kmph = 3.6

-- teksti joka näkyy in-game
function showText(text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(1.9,1.9)
    SetTextOutline()
    SettextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.02,0.70) --X ja Y
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local speed = (GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*kmph)
        if (IsPedAnyVehicle(GetPlayerPed(-1), false)) then
            if speed < 1 then
                showText("0")
            else
                showText(math.floor(speed))
            end
        end
    end
end)