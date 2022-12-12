local ccChat = exports['cc-chat']

RegisterNetEvent('cc-rpchat:addMessage')
AddEventHandler('cc-rpchat:addMessage', function(color, icon, subtitle, msg, showTime)
    if showTime ~= false then
        timestamp = ccChat:getTimestamp()
    else
        timestamp = ''
    end
    TriggerEvent('chat:addMessage', { templateId = 'ccChat', multiline = false, args = { color, icon, subtitle, timestamp, msg } })
end)

RegisterNetEvent('cc-rpchat:addProximityMessage')
AddEventHandler('cc-rpchat:addProximityMessage', function(color, icon, subtitle, msg, id, pCords)
  timestamp = ccChat:getTimestamp()
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chat:addMessage', { templateId = 'ccChat', multiline = false, args = { color, icon, subtitle, timestamp, msg } })
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), pCords, true) < 19.999 then
    TriggerEvent('chat:addMessage', { templateId = 'ccChat', multiline = false, args = { color, icon, subtitle, timestamp, msg } })
  end
end)