fx_version 'cerulean'
game 'gta5'

author 'Carbon#1002'
description 'qb-breakroom'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'locales/en.lua',
    'config.lua'
}

client_script {
    'client/cl_*.lua'
}

server_script {
    'server/sv_*.lua'
}
