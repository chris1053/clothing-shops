ESX = nil
local shopOpen = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Define clothing shop locations
local clothingShops = {
    {x = 72.3, y = -1399.1, z = 29.4},
    {x = -703.8, y = -152.3, z = 37.4},
    {x = -167.9, y = -299.0, z = 39.7},
    {x = 428.7, y = -800.1, z = 29.5},
    {x = -822.2, y = -1073.4, z = 11.3},
    {x = -1193.4, y = -772.3, z = 17.3},
    {x = -1449.1, y = -238.3, z = 49.8},
    {x = 11.6, y = 6514.2, z = 31.9},
    {x = 1696.3, y = 4829.3, z = 42.1},
    {x = 125.8, y = -223.6, z = 54.6},
    {x = 614.2, y = 2762.8, z = 42.1},
    {x = 1196.7, y = 2710.2, z = 38.2},
    {x = -3171.5, y = 1043.5, z = 20.9},
    {x = -1100.0, y = 2710.7, z = 19.1},
    {x = -1207.6, y = -1456.8, z = 4.4}
}

-- Create blips for each shop
Citizen.CreateThread(function()
    for _, shop in pairs(clothingShops) do
        local blip = AddBlipForCoord(shop.x, shop.y, shop.z)
        SetBlipSprite(blip, 73)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 3)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Clothing Shop")
        EndTextCommandSetBlipName(blip)
    end
end)

-- Shop interaction logic
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())

        for _, shop in pairs(clothingShops) do
            local distance = #(playerCoords - vector3(shop.x, shop.y, shop.z))

            if distance < 3.0 then
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to open the clothing shop")
                if IsControlJustPressed(1, 38) then -- E key
                    OpenClothingMenu()
                end
            end
        end
    end
end)

-- Function to open the clothing menu
function OpenClothingMenu()
    if not shopOpen then
        shopOpen = true
        TriggerEvent('esx_skin:openSaveableMenu', function(data)
            shopOpen = false
            TriggerServerEvent('clothing_shop:saveOutfit', data)
        end)
    end
end
