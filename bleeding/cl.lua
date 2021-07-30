local effect = false

function Bleeding(active, ped)
    if active then
        SetEntityHealth(ped, GetEntityHealth(ped)-2)

        if not effect then
            StartScreenEffect('Rampage', 0, true)
            effect = true
        end

        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)

        InfoRanny(Config.text)
        Citizen.Wait(7000)
    else
        effect = false
        StopScreenEffect('Rampage')
        SetPlayerHealthRechargeMultiplier(PlayerId(), 1.0)
    end
end

 
Citizen.CreateThread(function()
    while true do
        local player = PlayerPedId()
        local Health = GetEntityHealth(player)
        
        if Health <= 139 then
            Bleeding(true, player)
        else
            Bleeding(false)
        end

        Citizen.Wait(2000)
    end
end)
  
function InfoRanny(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
