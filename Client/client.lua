local Config = require('../config')

if Config.Framework == "ESX" then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == "QBCORE" then
    QBCore = exports['qb-core']:GetCoreObject()
else
    print("[ERROR] Yout framework is not valid!")
end

Citizen.CreateThread(function()
    while true do
        Wait(Config.UpdateTime * 1000)

        if Config.Framework == "ESX" then
            local Gender = ESX.PlayerData.sex == "m" and Config.Strings.Male or Config.Strings.Female
            local Health = GetEntityHealth(PlayerPedId()) == 0 and Config.Strings.Dead or GetEntityHealth(PlayerPedId()) - 100
            local job = ESX.PlayerData.job ~= nil and ESX.PlayerData.job.label or Config.Strings.Loading

            UpdateDiscordStatus({
                Gender = Gender,
                Health = Health,
                Job = job,
            })
        elseif Config.Framework == "QBCORE" then
            local Data = QBCore.Functions.GetPlayerData()
            local Gender = Data.charinfo.gender == 0 and Config.Strings.Male or Config.Strings.Female
            local Health = GetEntityHealth(PlayerPedId()) == 0 and Config.Strings.Dead or GetEntityHealth(PlayerPedId()) - 100
            local job = Data.job ~= nil and Data.job.label or Config.Strings.Loading

            UpdateDiscordStatus({
                Gender = Gender,
                Health = Health,
                Job = job,
            })
        end
    end
end)

function UpdateDiscordStatus(playerData)
    local replacements = {
        ["{ServerPlayers}"] = #GetActivePlayers() .. "/" .. GetConvarInt("sv_maxClients", 48),
        ["{PlayerID}"] = GetPlayerServerId(PlayerId()),
        ["{PlayerName}"] = GetPlayerName(PlayerId()),
        ["{PlayerCharacterFirstName}"] = ESX.PlayerData.firstName or Data.charinfo.firstname,
        ["{PlayerCharacterLastName}"] = ESX.PlayerData.lastName or Data.charinfo.lastname,
        ["{PlayerCharacterGender}"] = playerData.Gender,
        ["{PlayerCharacterJob}"] = playerData.Job,
        ["{PlayerCharacterStreet}"] = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(PlayerPedId(), true)))),
        ["{PlayerCharacterArea}"] = GetLabelText(GetNameOfZone(table.unpack(GetEntityCoords(PlayerPedId(), true)))),
        ["{PlayerCharacterHealth}"] = playerData.Health,
    }

    local result = Config.Text:gsub("{(.-)}", function(key)
        return replacements['{' .. key .. '}'] or key
    end)

    DiscordStatus(result)
end

function DiscordStatus(result)
    SetRichPresence(result)

    SetDiscordAppId(Config.ApplicationID)
    SetDiscordRichPresenceAsset(Config.Assets.BigAsset.ID)
    SetDiscordRichPresenceAssetText(Config.Assets.BigAsset.Text)
    SetDiscordRichPresenceAssetSmall(Config.Assets.SmallAsset.ID)
    SetDiscordRichPresenceAssetSmallText(Config.Assets.SmallAsset.Text)

    if Config.Buttons.FirstButton.Enabled then
        SetDiscordRichPresenceAction(0, Config.Buttons.FirstButton.Text, Config.Buttons.FirstButton.Link)
    end

    if Config.Buttons.SecondButton.Enabled then
        SetDiscordRichPresenceAction(1, Config.Buttons.SecondButton.Text, Config.Buttons.SecondButton.Link)
    end
end
