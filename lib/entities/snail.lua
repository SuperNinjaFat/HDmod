--replaces ENT_TYPE.MONS_HERMITCRAB
local module = {}
local hermitcrab_db = get_type(ENT_TYPE.MONS_HERMITCRAB)
hermitcrab_db.life = 1
hermitcrab_db.leaves_corpse_behind = false
set_post_entity_spawn(function(entity)
    entity.move_state = 9
    entity.carried_entity_type = ENT_TYPE.FX_SHADOW
    set_post_statemachine(entity.uid, function(entity)
        entity.carried_entity_uid = -1
    end)
    set_on_destroy(entity.uid, function(entity)
        local x, y, l = get_position(entity.uid)
        for i=1, 4, 1 do
            -- # TODO: polish this effect up a bit more, colors arent spot on
            local rubble = get_entity(spawn(ENT_TYPE.ITEM_RUBBLE, x+math.random(-10, 10)/100, y+(math.random(-10, 10)/100)+0.1, l, math.random(-10, 10)/100, math.random(1, 6)/30))
            rubble.animation_frame = 22
            rubble.color.r = 55
            rubble.color.g = 65
            rubble.color.b = 115
        end
    end)
end, SPAWN_TYPE.ANY, 0, ENT_TYPE.MONS_HERMITCRAB)
return module