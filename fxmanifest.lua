fx_version 'adamant'
game 'gta5'

name 'Clothing Shop'
description 'Custom Clothing Shop for FiveM'
author 'YourName'
version '1.0.0'

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}
