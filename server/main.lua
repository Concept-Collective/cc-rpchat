local ccChat = exports['cc-chat']
ESX = nil
QBCore = nil
local emoji = import 'emoji'


Citizen.CreateThread(function()
    SetConvar('chat_showJoins', '0')
    SetConvar('chat_showQuits', '0')
    if config.esx then
        ESX = exports["es_extended"]:getSharedObject()
        StopResource('esx_rpchat')
    elseif config.qbcore then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == 'esx_rpchat' then
        StopResource(resourceName)
    end
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    PerformHttpRequest('https://api.github.com/repos/Concept-Collective/cc-rpchat/releases/latest', function (err, data, headers)
        if data == nil then
            print('An error occurred while checking the version. Your firewall may be blocking access to "github.com". Please check your firewall settings and ensure that "github.com" is allowed to establish connections.')
            return
        end
        
        local data = json.decode(data)
        if data.tag_name ~= 'v'..GetResourceMetadata(GetCurrentResourceName(), 'version', 0) then
            print('\n^1================^0')
            print('^1CC RP Chat ('..GetCurrentResourceName()..') is outdated!^0')
            print('Current version: (^1v'..GetResourceMetadata(GetCurrentResourceName(), 'version', 0)..'^0)')
            print('Latest version: (^2'..data.tag_name..'^0) '..data.html_url)
            print('Release notes: '..data.body)
            print('^1================^0')
        end
    end, 'GET', '')
end)

-- OOC
RegisterCommand('ooc', function(source, args, rawCommand)
    local playerName
    local msg = rawCommand:sub(5)
    if config.emoji.ooc then
        for _, em in ipairs(emoji) do
            for _, code in ipairs(em[1]) do
                local emojiCode = string.gsub(code, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1") -- Escape special characters in the emoji code
                msg = string.gsub(msg, emojiCode, em[2]) -- Replace the emoji code with the corresponding emoji character
            end
        end
    end
    if ccChat:checkSpam(source, msg) and config.antiSpam == true then
        TriggerClientEvent('cc-rpchat:addMessage', source, '#e67e22', 'fa-solid fa-triangle-exclamation', "Please Don't Spam", '', false)
        return
    end
    if config.discord then
        playerName = "["..exports.ccDiscordWrapper:getPlayerDiscordHighestRole(source, "name").."] "..GetPlayerName(source)
    elseif config.esx then
        local xPlayer = ESX.GetPlayerFromId(source)
        playerName = xPlayer.getName()
    elseif config.qbcore then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
    else
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 3), '**Command arguments**: '..msg..'\n\n'.."**Identifiers**: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n<@"..GetPlayerIdentifier(source, 2):sub(9)..">\n"..GetPlayerIdentifier(source, 3), 'add a custom footer')
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#3498db', 'fa-solid fa-globe', 'OOC | '..playerName, msg)
end, false)

AddEventHandler('chatMessage', function(source, name, message)
    CancelEvent()
    local playerName
    if message:sub(1, 1) == '/' then
        return
    else
        if config.emoji.chatMessage then
            for _, em in ipairs(emoji) do
                for _, code in ipairs(em[1]) do
                    local emojiCode = string.gsub(code, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1") -- Escape special characters in the emoji code
                    message = string.gsub(message, emojiCode, em[2]) -- Replace the emoji code with the corresponding emoji character
                end
            end
        end
    if ccChat:checkSpam(source, message) and config.antiSpam == true then
        TriggerClientEvent('cc-rpchat:addMessage', source, '#e67e22', 'fa-solid fa-triangle-exclamation', "Please Don't Spam", '', false)
        return
    end
    if config.discord then
        playerName = "["..exports.ccDiscordWrapper:getPlayerDiscordHighestRole(source, "name").."] "..GetPlayerName(source)
    elseif config.esx then
        local xPlayer = ESX.GetPlayerFromId(source)
        playerName = xPlayer.getName()
    elseif config.qbcore then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
    else
        playerName = GetPlayerName(source)
    end
        TriggerClientEvent('cc-rpchat:addMessage', -1, '#3498db', 'fa-solid fa-globe', 'OOC | '..playerName, message) 
        if config.DiscordWebhook then
            sendToDiscord(16753920, playerName.." sent the following message", "**Message**: \n"..message.."\n\n**Identifiers**: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n<@"..GetPlayerIdentifier(source, 2):sub(9)..">\n"..GetPlayerIdentifier(source, 3), 'add a custom footer')
        end
    end
end)

-- Me
RegisterCommand('me', function(source, args, rawCommand)
    local playerName
    local msg = rawCommand:sub(4)
    if config.emoji.me then
        for _, em in ipairs(emoji) do
            for _, code in ipairs(em[1]) do
                local emojiCode = string.gsub(code, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1") -- Escape special characters in the emoji code
                msg = string.gsub(msg, emojiCode, em[2]) -- Replace the emoji code with the corresponding emoji character
            end
        end
    end
    if ccChat:checkSpam(source, msg) and config.antiSpam == true then
        TriggerClientEvent('cc-rpchat:addMessage', source, '#e67e22', 'fa-solid fa-triangle-exclamation', "Please Don't Spam", '', false)
        return
    end
    if config.discord then
        playerName = "["..exports.ccDiscordWrapper:getPlayerDiscordHighestRole(source, "name").."] "..GetPlayerName(source)
    elseif config.esx then
        local xPlayer = ESX.GetPlayerFromId(source)
        playerName = xPlayer.getName()
    elseif config.qbcore then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
    else
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 2), '**Command arguments**: '..msg..'\n\n'.."**Identifiers**: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n<@"..GetPlayerIdentifier(source, 2):sub(9)..">\n"..GetPlayerIdentifier(source, 3), 'add a custom footer')
    end
    TriggerClientEvent('cc-rpchat:addProximityMessage', -1, '#f39c12', 'fa-solid fa-person', 'Me | '..playerName, msg, source, GetEntityCoords(GetPlayerPed(source)))
    --TriggerClientEvent('cc-rpchat:addMessage', -1, '#f39c12', 'fa-solid fa-person', 'Me | '..playerName, msg)
end, false)

-- Do
RegisterCommand('do', function(source, args, rawCommand)
    local playerName
    local msg = rawCommand:sub(4)
    if config.emoji.doo then
        for _, em in ipairs(emoji) do
            for _, code in ipairs(em[1]) do
                local emojiCode = string.gsub(code, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1") -- Escape special characters in the emoji code
                msg = string.gsub(msg, emojiCode, em[2]) -- Replace the emoji code with the corresponding emoji character
            end
        end
    end
    if ccChat:checkSpam(source, msg) and config.antiSpam == true then
        TriggerClientEvent('cc-rpchat:addMessage', source, '#e67e22', 'fa-solid fa-triangle-exclamation', "Please Don't Spam", '', false)
        return
    end
    if config.discord then
        playerName = "["..exports.ccDiscordWrapper:getPlayerDiscordHighestRole(source, "name").."] "..GetPlayerName(source)
    elseif config.esx then
        local xPlayer = ESX.GetPlayerFromId(source)
        playerName = xPlayer.getName()
    elseif config.qbcore then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
    else
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 2), '**Command arguments**: '..msg..'\n\n'.."**Identifiers**: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n<@"..GetPlayerIdentifier(source, 2):sub(9)..">\n"..GetPlayerIdentifier(source, 3), 'add a custom footer')
    end
    TriggerClientEvent('cc-rpchat:addProximityMessage', -1, '#2ecc71', 'fa-solid fa-person-digging', 'Do | '..playerName, msg, source, GetEntityCoords(GetPlayerPed(source)))
end, false)

-- News
RegisterCommand('news', function(source, args, rawCommand)
    local playerName
    local msg = rawCommand:sub(5)
    if config.emoji.news then
        for _, em in ipairs(emoji) do
            for _, code in ipairs(em[1]) do
                local emojiCode = string.gsub(code, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1") -- Escape special characters in the emoji code
                msg = string.gsub(msg, emojiCode, em[2]) -- Replace the emoji code with the corresponding emoji character
            end
        end
    end
    if ccChat:checkSpam(source, msg) and config.antiSpam == true then
        TriggerClientEvent('cc-rpchat:addMessage', source, '#e67e22', 'fa-solid fa-triangle-exclamation', "Please Don't Spam", '', false)
        return
    end
    if config.discord then
        playerName = "["..exports.ccDiscordWrapper:getPlayerDiscordHighestRole(source, "name").."] "..GetPlayerName(source)
    elseif config.esx then
        local xPlayer = ESX.GetPlayerFromId(source)
        playerName = xPlayer.getName()
    elseif config.qbcore then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
    else
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 4), '**Command arguments**: '..msg..'\n\n'.."**Identifiers**: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n<@"..GetPlayerIdentifier(source, 2):sub(9)..">\n"..GetPlayerIdentifier(source, 3), 'add a custom footer')
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#c0392b', 'fa-solid fa-newspaper', 'News | '..playerName, msg)
end, false)

-- Ad
RegisterCommand('ad', function(source, args, rawCommand)
    local playerName
    local msg = rawCommand:sub(4)
    if config.emoji.ad then
        for _, em in ipairs(emoji) do
            for _, code in ipairs(em[1]) do
                local emojiCode = string.gsub(code, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1") -- Escape special characters in the emoji code
                msg = string.gsub(msg, emojiCode, em[2]) -- Replace the emoji code with the corresponding emoji character
            end
        end
    end
    if ccChat:checkSpam(source, msg) and config.antiSpam == true then
        TriggerClientEvent('cc-rpchat:addMessage', source, '#e67e22', 'fa-solid fa-triangle-exclamation', "Please Don't Spam", '', false)
        return
    end
    if config.discord then
        playerName = "["..exports.ccDiscordWrapper:getPlayerDiscordHighestRole(source, "name").."] "..GetPlayerName(source)
    elseif config.esx then
        local xPlayer = ESX.GetPlayerFromId(source)
        playerName = xPlayer.getName()
    elseif config.qbcore then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
    else
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 2), '**Command arguments**: '..msg..'\n\n'.."**Identifiers**: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n<@"..GetPlayerIdentifier(source, 2):sub(9)..">\n"..GetPlayerIdentifier(source, 3), 'add a custom footer')
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#f1c40f', 'fas fa-ad', 'Ad | '..playerName, msg)
end, false)

-- Tweet
RegisterCommand('twt', function(source, args, rawCommand)
    local playerName
    local msg = rawCommand:sub(5)
    if config.emoji.twt then
        for _, em in ipairs(emoji) do
            for _, code in ipairs(em[1]) do
                local emojiCode = string.gsub(code, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1") -- Escape special characters in the emoji code
                msg = string.gsub(msg, emojiCode, em[2]) -- Replace the emoji code with the corresponding emoji character
            end
        end
    end
    if ccChat:checkSpam(source, msg) and config.antiSpam == true then
        TriggerClientEvent('cc-rpchat:addMessage', source, '#e67e22', 'fa-solid fa-triangle-exclamation', "Please Don't Spam", '', false)
        return
    end
    if config.discord then
        playerName = "["..exports.ccDiscordWrapper:getPlayerDiscordHighestRole(source, "name").."] "..GetPlayerName(source)
    elseif config.esx then
        local xPlayer = ESX.GetPlayerFromId(source)
        playerName = xPlayer.getName()
    elseif config.qbcore then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
    else
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 3), '**Command arguments**: '..msg..'\n\n'.."**Identifiers**: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n<@"..GetPlayerIdentifier(source, 2):sub(9)..">\n"..GetPlayerIdentifier(source, 3), 'add a custom footer')
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#2980b9', 'fa-brands fa-twitter', '@'..playerName, msg)
end, false)

-- Anon
RegisterCommand('anon', function(source, args, rawCommand)
    local playerName
    local msg = rawCommand:sub(5)
    if config.emoji.anon then
        for _, em in ipairs(emoji) do
            for _, code in ipairs(em[1]) do
                local emojiCode = string.gsub(code, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1") -- Escape special characters in the emoji code
                msg = string.gsub(msg, emojiCode, em[2]) -- Replace the emoji code with the corresponding emoji character
            end
        end
    end
    if ccChat:checkSpam(source, msg) and config.antiSpam == true then
        TriggerClientEvent('cc-rpchat:addMessage', source, '#e67e22', 'fa-solid fa-triangle-exclamation', "Please Don't Spam", '', false)
        return
    end
    if config.discord then
        playerName = "["..exports.ccDiscordWrapper:getPlayerDiscordHighestRole(source, "name").."] "..GetPlayerName(source)
    elseif config.esx then
        local xPlayer = ESX.GetPlayerFromId(source)
        playerName = xPlayer.getName()
    elseif config.qbcore then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        playerName = xPlayer.PlayerData.charinfo.firstname .. "," .. xPlayer.PlayerData.charinfo.lastname 
    else
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 4), '**Command arguments**: '..msg..'\n\n'.."**Identifiers**: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n<@"..GetPlayerIdentifier(source, 2):sub(9)..">\n"..GetPlayerIdentifier(source, 3), 'add a custom footer')
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#2c3e50', 'fa-solid fa-mask', 'Anonymous | '.. source, msg)
end, false)

-- Player join and leave messages
if config.connectionMessages then
    AddEventHandler('playerJoining', function()
        local playerName
        playerName = GetPlayerName(source)
        TriggerClientEvent('cc-rpchat:addMessage', -1, '#2ecc71', 'fa-solid fa-plus', playerName..' joined.', '', false)
        if config.DiscordWebhook then
            sendToDiscord(3329330, playerName.." has joined!", "**Identifiers**: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n<@"..GetPlayerIdentifier(source, 2):sub(9)..">\n"..GetPlayerIdentifier(source, 3), 'add a custom footer')
        end
    end)

    AddEventHandler('playerDropped', function(reason)
        local playerName
        playerName = GetPlayerName(source)
        TriggerClientEvent('cc-rpchat:addMessage', -1, '#e74c3c', 'fa-solid fa-minus', playerName..' left (' .. reason .. ')', '', false)
        if config.DiscordWebhook then
            sendToDiscord(13644844, playerName.." has disconnected ("..reason..")!", "**Identifiers**: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n<@"..GetPlayerIdentifier(source, 2):sub(9)..">\n"..GetPlayerIdentifier(source, 3), 'add a custom footer')
        end
    end)
end

-- Discord webhook *** REQUIRED ccDiscordWrapper ***
function sendToDiscord(color, name, message, footer)
    exports["ccDiscordWrapper"]:webhookSendNewMessage(color, name, message, footer)
end
