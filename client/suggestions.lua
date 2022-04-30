Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/ooc', 'Out of character command', {
      { name="Message", help="The message you would like to send to the chat" }
    })

    TriggerEvent('chat:addSuggestion', '/me', 'Me command', {
        { name="Message", help="The message you would like to send to the chat" }
    })

    TriggerEvent('chat:addSuggestion', '/do', 'Do', {
    { name="Message", help="What are you doing?" }
    })

    TriggerEvent('chat:addSuggestion', '/news', 'News command', {
        { name="Message", help="The news you would like to share" }
    })
  
    TriggerEvent('chat:addSuggestion', '/ad', 'Advertisement command', {
      { name="Message", help="The message you would like to send to the chat" }
    })
  
    TriggerEvent('chat:addSuggestion', '/twt', 'Twitter command', {
      { name="Message", help="The message you would like to send as a tweet" }
    })
  
    TriggerEvent('chat:addSuggestion', '/anon', 'Anonymous message', {
      { name="Message", help="The message you would like to send Anonymously" }
    })
end)