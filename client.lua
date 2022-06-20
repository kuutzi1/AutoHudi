-- MPH paska älä käytä :D
local mph = 2.2369
-- KMH kannattaa käyttää :D
local kmph = 3.6
-- vakio nopeuden säädin
local vakkari = false

-- teksti joka näkyy in-game
function showText(text, x, y, r, g, b)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(1.2,1.2)
    SetTextOutline()
    SetTextColour(r, g, b, 255)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y) --X ja Y
end

function notify(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
            -- nopeusmittari
        local speed = (GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*kmph)
        showText("KMP/H", 0.16,0.90, 155, 155, 155)
            if speed < 1 then
                showText("0", 0.24,0.90, 155, 155, 155)
            elseif speed >= 120 then
                showText(math.floor(speed), 0.24,0.90, 200, 0, 0)
            else
                showText(math.floor(speed), 0.24,0.90, 255, 255, 255)
            end

            -- vakkari
            if IsControlJustPressed(1, 311) then -- vakio nappi on Y voi vaihtaa halutessaan
                if vakkari == false then
                    vakkari = true
                    local currentSpeed = (GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
                    SetVehicleMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), currentSpeed)
                    notify("VakioNopeuden säädin päällä")
                elseif vakkari == true then
                    vakkari = false
                    SetVehicleMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0)
                    notify("VakioNopeuden säädin pois päältä")
                end
            end
        end
    end
end)