config = {}

config.esx = false                        -- Set this to true if using ESX (requires esx_identity)

config.qbcore = false                     -- Set this to true if using QBCore

config.discord = false                    -- Set this to true if using ccDiscordWrapper and want Role Names added as a prefix to the Players Name

config.connectionMessages = true          -- set this to true if you would like join and leave messages

config.antiSpam = false                   -- set this to true if you would like to use the cc chat antispam system                      

config.DiscordWebhook = false             -- Set to your true if you would like to log to Discord Webhook ***REQUIRES ccDiscordWrapper!***

config.emoji = {
    chatMessage = true, -- enable emojis for text (ooc)
    ooc = true, -- enable emojis for /ooc
    me = true, --  enable emojis for /me
    doo = true, --  enable emojis for /do
    news = true, --  enable emojis for /news
    ad = true, --  enable emojis for /ad
    twt = true, --  enable emojis for /twt
    anon = true, --  enable emojis for /anon
}

function import(file) -- require doesnt work without ox_lib so we need to use this to keep this standalone
	local name = ('%s.lua'):format(file)
	local content = LoadResourceFile(GetCurrentResourceName(),name)
	local f, err = load(content)
	return f()
end
