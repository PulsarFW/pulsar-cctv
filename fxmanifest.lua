fx_version 'cerulean'
game 'gta5'

name 'Pulsar Cctv'
description 'CCTV camera network'
author 'Artmines - maintained for Pulsar Framework'
url 'https://pulsarframe.work'
version 'v1.0.0'

version_check 'yes'
github 'https://github.com/PulsarFW/pulsar_cctv'

client_script '@pulsar_core/components/cl_error.lua'
shared_script '@pulsar_core/core/sh_pulsar.lua'
client_script '@pulsar_pwnzor/client/check.lua'

client_scripts({
	'config/client.lua',
	'config/shared.lua',
	'client/**/*.lua',
})

server_scripts({
	'config/server.lua',
	'config/shared.lua',
	'server/**/*.lua',
})

lua54 'yes'