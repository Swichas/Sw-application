fx_version 'cerulean'
game 'gta5'

name "Swichas jobs"
author "Swichas"
lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'shared/*.lua',
	'@qb-core/shared/locale.lua',
	'locales/en.lua',
	'locales/*.lua'
}
server_script '@oxmysql/lib/MySQL.lua'

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/main.lua'
}
