ESX = nil

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    PerformHttpRequest('https://api.github.com/repos/Concept-Collective/cc-rpchat/releases/latest', function (err, data, headers)
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
    if config.DefaultPrefix then
        AddEventHandler('chatMessage', function(source, name, message)
            local playerName
            local xPlayer = ESX.GetPlayerFromId(source)
            if config.identity then
                playerName = xPlayer.getName()
            else 
                playerName = GetPlayerName(source)
            end
            if config.DefaultPrefix == 'ooc' then
                TriggerClientEvent('cc-rpchat:addMessage', -1, '#3498db', 'fa-solid fa-globe', 'OOC | '..playerName, message)
            elseif config.DefaultPrefix == 'me' then
                TriggerClientEvent('cc-rpchat:addMessage', -1, '#f39c12', 'fa-solid fa-person', 'Me | '..playerName, message)
            elseif config.DefaultPrefix == 'do' then
                TriggerClientEvent('cc-rpchat:addMessage', -1, '#2ecc71', 'fa-solid fa-person-digging', 'Do | '..playerName, message)
            elseif config.DefaultPrefix == 'twt' then
                TriggerClientEvent('cc-rpchat:addMessage', -1, '#2980b9', 'fa-brands fa-twitter', '@'..playerName, message)
            end
            CancelEvent()
        end)
    end
    if config.identity then
        ESX = exports["es_extended"]:getSharedObject()
    end 
end)

RegisterCommand('ooc', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName
    local msg = rawCommand:sub(5)
    if config.identity then
        playerName = xPlayer.getName()
    else 
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 3), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#3498db', 'fa-solid fa-globe', 'OOC | '..playerName, msg)
end, false)

RegisterCommand('me', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName
    local msg = rawCommand:sub(4)
    if config.identity then
        playerName = xPlayer.getName()
    else 
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 2), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#f39c12', 'fa-solid fa-person', 'Me | '..playerName, msg)
end, false)

RegisterCommand('do', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName
    local msg = rawCommand:sub(4)
    if config.identity then
        playerName = xPlayer.getName()
    else 
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 2), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#2ecc71', 'fa-solid fa-person-digging', 'Do | '..playerName, msg)
end, false)

RegisterCommand('news', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName
    local msg = rawCommand:sub(5)
    if config.identity then
        playerName = xPlayer.getName()
    else 
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 4), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#c0392b', 'fa-solid fa-newspaper', 'News | '..playerName, msg)
end, false)

RegisterCommand('ad', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName
    local msg = rawCommand:sub(4)
    if config.identity then
        playerName = xPlayer.getName()
    else 
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 2), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#f1c40f', 'fas fa-ad', 'Ad | '..playerName, msg)
end, false)

RegisterCommand('twt', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName
    local msg = rawCommand:sub(5)
    if config.identity then
        playerName = xPlayer.getName()
    else 
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 3), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#2980b9', 'fa-brands fa-twitter', '@'..playerName, msg)
end, false)

RegisterCommand('anon', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerName
    local msg = rawCommand:sub(5)
    if config.identity then
        playerName = xPlayer.getName()
    else 
        playerName = GetPlayerName(source)
    end
    if config.DiscordWebhook then
        sendToDiscord(16753920, playerName.." has executed /"..rawCommand:sub(1, 4), '**Command arguments**: '..msg, "Identifiers: \n"..GetPlayerIdentifier(source, 0).."\n"..GetPlayerIdentifier(source, 1).."\n"..GetPlayerIdentifier(source, 2).."\n"..GetPlayerIdentifier(source, 3))
    end
    TriggerClientEvent('cc-rpchat:addMessage', -1, '#2c3e50', 'fa-solid fa-mask', 'Anonymous | '.. source, msg)
end, false)

AddEventHandler('chatMessage', function(source, name, message)
    CancelEvent()
end)

function sendToDiscord(color, name, message, footer)
    local embed = {
        {
            ['color']       = color,
            ['title']       = '**'..name..'**',
            ['description'] = message,
            ['footer']      = {
                ['text']    = footer,
            },
        }
    }
    PerformHttpRequest(config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({username = 'New Command Executed!', embeds = embed}), { ['Content-Type'] = 'application/json' })
end
