local ccChat = exports['cc-chat']

RegisterNetEvent('cc-rpchat:addMessage')
AddEventHandler('cc-rpchat:addMessage', function(color, icon, subtitle, msg)
    timestamp = ccChat:getTimestamp()
    TriggerEvent('chat:addMessage', { templateId = 'ccChat', multiline = false, args = { color, icon, subtitle, timestamp, msg } })
end)