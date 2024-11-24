fx_version 'cerulean'
game 'gta5'

author 'Teck Scripts'
description 'Advanced K9 System for QBCore'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/commands.lua',
    'client/animations.lua'
}

server_scripts {
    'server/main.lua',
    'server/version.lua'
}

lua54 'yes'
