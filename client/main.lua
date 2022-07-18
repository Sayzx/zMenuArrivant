ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

end)

local isMenuOpen = false
local serveur = "zDev" -- Mettre le nom de ton serveur bg

local arrivalmenu = RageUI.CreateMenu("", "Menu pour les novueaux arrivant", 10, 80, 'arrival', 'interaction_bgd')
local keycaps = RageUI.CreateSubMenu(arrivalmenu, "", "Touches du serveur", 10, 80, 'arrival', 'interaction_bgd')
local cmds = RageUI.CreateSubMenu(arrivalmenu, "", "Commandes", 10, 80, 'arrival', 'interaction_bgd')
local social = RageUI.CreateSubMenu(arrivalmenu, "", "Médias du Serveur", 10, 80, 'arrival', 'interaction_bgd')
arrivalmenu.close = function()
    isMenuOpen = false
end



--- PNJ 
local peds = true -- False si tu ne veux pas de ped

if peds == true then
        CreateThread(function()
            local hash = GetHashKey("s_f_y_airhostess_01") -- Model du ped
            while not HasModelLoaded(hash) do -- Vérifie si le modèle du ped est valide
            RequestModel(hash)
            Wait(40)
            end
            local coords = vector3(-1008.5223388672,-2748.3557128906,12.757274627686) -- Pos Ped
            local ped = CreatePed(4, hash, coords, false, false) -- Spawn du ped
            local heading = 265.0 -- Orientation
            SetEntityInvincible(ped, true) -- Met le ped invicible
            SetEntityHeading(ped, heading) -- Met l'orientation du ped
            SetEntityAsMissionEntity(ped, true, true) --
            SetPedHearingRange(ped, 0.0) -- 
            SetPedSeeingRange(ped, 0.0) -- 
            SetPedAlertness(ped, 0.0) -- 
            SetPedFleeAttributes(ped, 0, 0) --
            SetBlockingOfNonTemporaryEvents(ped, true) --
            SetPedCombatAttributes(ped, 46, true)  -- 
            SetPedFleeAttributes(ped, 0, 0) --
            SetBlockingOfNonTemporaryEvents(ped, true) -- le ped ne peux plus bouger
            FreezeEntityPosition(ped, true) -- le ped n'est plus affrayé par les armes
            SetEntityInvincible(ped, true) -- le ped est invincible
            SetEntityAnimCurrentTime(ped, sit, true, 10)
        end)
    elseif peds == false then
end

CreateThread(function()
    while true do
        local interval = 850
        local playerco = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(playerco.x, playerco.y, playerco.z, -1008.3607177734,-2748.3024902344,13.757195472717)
        if dist < 3.0 then
            interval = 1 
            ESX.ShowHelpNotification("~b~Appuyez sur ~y~ ~INPUT_CONTEXT~  ~b~pour intéragir")
            if IsControlJustPressed(0, 51) then
                OpenArrivalMenu()
            end
        elseif dist < 5.0  then
            isMenuOpen = false
            RageUI.Visible(arrivalmenu, false)
        end
        Wait(interval)
    end
end)


-- Menu 

function OpenArrivalMenu()
    if isMenuOpen then
        isMenuOpen = false
        RageUI.Visible(arrivalmenu, false)
    else
        isMenuOpen = true
        RageUI.Visible(arrivalmenu, true)
        CreateThread(function()
            while isMenuOpen do
                Wait(1)
                RageUI.IsVisible(arrivalmenu, function()
                    RageUI.Separator("~o~Author ~s~- ~p~Sayzx ")  
                    RageUI.Separator("~r~Menu Arrivant ~b~- ~p~0.00ms ")
                    RageUI.Separator("~r~↓  ~r~↓")
                    RageUI.Button("~b~>> ~s~Touches", "~g~Touches utilise du serveur", {RightLabel= ">>"}, true, {}, keycaps)   
                    RageUI.Button("~b~>> ~s~Commandes", "~g~Commandes utilise du serveur", {RightLabel= ">>"}, true, {}, cmds) 
                    RageUI.Button("~b~>> ~s~Médias", "~g~Voir les réseaux du serveur", {RightLabel= ">>"}, true, {}, social) 
                    RageUI.Separator("~r~↓  ~r~↓")
                    RageUI.Separator("~b~100% ~g~Configurable")
                end)

                -- Menu Touches
                RageUI.IsVisible(keycaps, function()
                RageUI.Button("~b~>> ~s~Ouverture du Téléphone", "", {RightLabel= "~r~F1"}, true, {}) 
                RageUI.Button("~b~>> ~s~Menu Emotes", "", {RightLabel= "~r~F2"}, true, {}) 
                RageUI.Button("~b~>> ~s~Menu Informations", "", {RightLabel= "~r~F3"}, true, {}) 
                RageUI.Button("~b~>> ~s~Menu Personel", "", {RightLabel= "~r~F5"}, true, {}) 
                RageUI.Button("~b~>> ~s~Menu Travail", "", {RightLabel= "~r~F6"}, true, {}) 
                RageUI.Button("~b~>> ~s~Menu Faction / Gangs", "", {RightLabel= "~r~F7"}, true, {}) 
                RageUI.Button("~b~>> ~s~Console", "", {RightLabel= "~r~F8"}, true, {}) 
                RageUI.Button("~b~>> ~s~Screen", "", {RightLabel= "~r~F10"}, true, {}) 
                RageUI.Button("~b~>> ~s~Ceinture", "", {RightLabel= "~r~,"}, true, {})       
                RageUI.Button("~b~>> ~s~Tomber", "", {RightLabel= "~r~K"}, true, {})      
                RageUI.Separator("~r~↓  ~r~↓")
                RageUI.Separator("~b~100% ~g~Configurable") 
                end)          
                 

                       
                -- Menu Commandes
                RageUI.IsVisible(cmds, function()  
                RageUI.Separator()
                RageUI.Button("~b~>> ~s~/report", "~g~Permet d'appeler un staff", {RightLabel= ""}, true, {})
                RageUI.Button("~b~>> ~s~/twt", "~g~Permet de faire un tweet", {RightLabel= ""}, true, {})
                RageUI.Button("~b~>> ~s~/zdev", "~g~Permet de rejoindre le discord de zDev", {RightLabel= ""}, true, {})
                RageUI.Separator("~r~↓  ~r~↓")
                RageUI.Separator("~b~100% ~g~Configurable")
                end)
                
                --Menu Reseaux
                local name = GetPlayerName(PlayerId())
                RageUI.IsVisible(social, function()  
                RageUI.Separator("~b~Joueurs : ~r~"..name)
                RageUI.Separator("~b~Serveur : ~r~"..serveur)
                RageUI.Separator()
                RageUI.Button("~b~>> ~p~Discord", "~g~Permet de rejoindre le discord", {RightLabel= ""}, true, {
                onSelected = function()
                    ESX.ShowNotification("~p~Discord ~b~dsc.gg/zdev")
                end})
                RageUI.Button("~b~>> ~o~TopServeur", "~g~Permet de rejoindre le top serveur", {RightLabel= ""}, true, {
                    onSelected = function()
                        ESX.ShowNotification("~o~Top Serveur ~b~TonLien")
                    end})
                RageUI.Button("~b~>> ~r~Site", "~g~Permet de rejoindre le site", {RightLabel= ""}, true, {
                onSelected = function()
                    ESX.ShowNotification("~g~Site ~b~TonSite")
                end})
               
                end)
            end
            
        end)
    end
end
