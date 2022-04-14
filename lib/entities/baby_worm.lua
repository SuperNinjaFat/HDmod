local celib = require "lib.entities.custom_entities"

local module = {}
local baby_worm_texture_def
do
    baby_worm_texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_MONSTERSBASIC01_0)
    baby_worm_texture_def.texture_path = 'res/baby_worm.png'
    baby_worm_texture_id = define_texture(baby_worm_texture_def)
end
local function baby_worm_set(uid)
    local ent = get_entity(uid)
    ent:set_texture(baby_worm_texture_id)
end
local function baby_worm_update(ent)
    ent.jump_timer = 180
end
function module.create_babyworm(x, y, l)
    local baby_worm = spawn(ENT_TYPE.MONS_ALIEN, x, y, l, 0, 0)
    baby_worm_set(baby_worm)
    set_post_statemachine(baby_worm, baby_worm_update)
end

-- register_option_button("spawn_baby_worm", "spawn_baby_worm", 'spawn_baby_worm', function ()
--     local x, y, l = get_position(players[1].uid)
--     module.create_babyworm(x-5, y, l)
--end)

return module