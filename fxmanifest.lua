fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Concept Collective <contact@conceptcollective.net>'
description 'A FiveM RP Chat resource utilising cc-chat.'
version '1.3.1'

lua54 'yes'

server_script 'server/main.lua'
client_script 'client/*.lua'
shared_script 'config.lua'

dependency 'cc-chat'