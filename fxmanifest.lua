version '1.3.0'
author 'Concept Collective'
description 'A FiveM RP Chat resource utilising cc-chat.'

lua54 'yes'

server_script 'server/main.lua'
client_script 'client/*.lua'
shared_script 'config.lua'

dependency 'cc-chat'

game 'common'
fx_version 'adamant'
