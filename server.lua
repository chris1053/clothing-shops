ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Save the outfit
RegisterServerEvent('clothing_shop:saveOutfit')
AddEventHandler('clothing_shop:saveOutfit', function(outfitData)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
            ['@skin'] = json.encode(outfitData),
            ['@identifier'] = xPlayer.identifier
        })
    end
end)
