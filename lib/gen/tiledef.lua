blackknightlib = require 'lib.entities.black_knight'
turrentlib = require 'lib.entities.laser_turrent'
spikeballlib = require 'lib.entities.spikeball_trap'
snaillib = require 'lib.entities.snail'
babywormlib = require 'lib.entities.baby_worm'

local module = {}


-- retains HD tilenames
module.HD_TILENAME = {
	["0"] = {
		description = "Empty",
	},
	["#"] = {
		phase_1 = {
			default = {
				function(x, y, l) spawn_grid_entity(ENT_TYPE.ACTIVEFLOOR_POWDERKEG, x, y, l, 0, 0) end
			},
			alternate = {
				[THEME.CITY_OF_GOLD] = {
					function(x, y, l)
						if not options.hd_debug_item_botd_give then
							botdlib.create_botd(x, y, l)
						end
					end
				}
			},
		},
		description = "TNT Box",
	},
	["$"] = {
		description = "Roulette Item",
	},
	["%"] = {
		description = "Roulette Door",
	},
	["&"] = {
		phase_1 = {
			default = {
				function(x, y, l) createlib.create_liquidfall(x, y-2.5, l, "res/floor_jungle_fountain.png") end,
			},
			alternate = {
				[THEME.CITY_OF_GOLD] = {
					function(x, y, l) createlib.create_liquidfall(x, y-3, l, "res/floorstyled_gold_fountain.png", true) end,
				},
				[THEME.TEMPLE] = {
					function(x, y, l) createlib.create_liquidfall(x, y-3, l, "res/floorstyled_temple_fountain.png", true) end,
				},
				[THEME.VOLCANA] = {
					function(x, y, l) createlib.create_liquidfall(x, y-3, l, "res/hell_fountain.png", true) end,
				},
			},
		},
		description = "Waterfall",
	},
	["*"] = {
		phase_1 = {
			default = {
				function(x, y, l) spikeballlib.create_spikeball_trap(x, y, l) end,
			},
			alternate = {
				[THEME.NEO_BABYLON] = {
					function(x, y, l) spawn_entity_snapped_to_floor(ENT_TYPE.ITEM_PLASMACANNON, x, y, l, 0, 0) end,
				},
			},
		},
		-- hd_type = hdtypelib.HD_ENT.TRAP_SPIKEBALL
		-- spawn method for plasma cannon in HD spawned a tile under it, stylized
		description = "Spikeball",
	},
	["+"] = {
		phase_1 = {
			default = { function(x, y, l) return 0 end },--ENT_TYPE.BG_LEVEL_BACKWALL},
			alternate = {
				[THEME.ICE_CAVES] = {
					function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_MOTHERSHIP, x, y, l, 0, 0) end,
				},
			},
		},
		description = "Wooden Background",
	},
	[","] = {
		phase_1 = {
			default = {
				function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0) end,
				function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_MINEWOOD, x, y, l, 0, 0) end,
			},
		},
		description = "Terrain/Wood",
	},
	["-"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.ACTIVEFLOOR_THINICE, x, y, l, 0, 0) end,},
		},
		description = "Cracking Ice",
	},
	["."] = {
		-- S2 doesn't like spawning ANY floor in these places for some reason, so we're going to use S2 gen for this
		phase_1 = {
			default = {
				function(x, y, l)
					local entity = get_entity(spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0))
					entity.flags = set_flag(entity.flags, ENT_FLAG.SHOP_FLOOR)
				end,
			},
			alternate = {
				[THEME.TEMPLE] = {
					function(x, y, l)
						local entity = get_entity(spawn_grid_entity((options.hd_og_floorstyle_temple and ENT_TYPE.FLOORSTYLED_STONE or ENT_TYPE.FLOORSTYLED_TEMPLE), x, y, l, 0, 0))
						entity.flags = set_flag(entity.flags, ENT_FLAG.SHOP_FLOOR)
					end,
				}
			}
		},
		description = "Unmodified Terrain",
	},
	["1"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0) end,},
			alternate = {
				[THEME.EGGPLANT_WORLD] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_GUTS, x, y, l, 0, 0) end,},
				[THEME.ICE_CAVES] = {
					function(x, y, l)
						if (
							feelingslib.feeling_check(feelingslib.FEELING_ID.YETIKINGDOM)
						) then
							if (math.random(6) == 1) then
								spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0)
							else
								spawn_grid_entity(ENT_TYPE.FLOOR_ICE, x, y, l, 0, 0)
							end
						else
							spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0)
						end
					end,
				},
				[THEME.NEO_BABYLON] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_MOTHERSHIP, x, y, l, 0, 0) end,},
				[THEME.OLMEC] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_STONE, x, y, l, 0, 0) end,},
				[THEME.TEMPLE] = {function(x, y, l) spawn_grid_entity((options.hd_og_floorstyle_temple and ENT_TYPE.FLOORSTYLED_STONE or ENT_TYPE.FLOORSTYLED_TEMPLE), x, y, l, 0, 0) end,},
				[THEME.CITY_OF_GOLD] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_COG, x, y, l, 0, 0) end,},
			},
		},
		description = "Terrain",
	},
	["2"] = {
		phase_1 = {
			default = {
				function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0) end,
				function(x, y, l) return 0 end,
			},
			alternate = {
				[THEME.EGGPLANT_WORLD] = {
					function(x, y, l)
						if math.random(2) == 1 then
							if math.random(10) == 1 then
								createlib.create_regenblock(x, y, l)
							else
								spawn_grid_entity(ENT_TYPE.FLOORSTYLED_GUTS, x, y, l, 0, 0)
							end
						else return 0 end
					end,
				},
				[THEME.NEO_BABYLON] = {
					function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_MOTHERSHIP, x, y, l, 0, 0) end,
					function(x, y, l) return 0 end,
				},
				[THEME.OLMEC] = {
					function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_STONE, x, y, l, 0, 0) end,
					function(x, y, l) return 0 end,
				},
				[THEME.TEMPLE] = {
					function(x, y, l) spawn_grid_entity((options.hd_og_floorstyle_temple and ENT_TYPE.FLOORSTYLED_STONE or ENT_TYPE.FLOORSTYLED_TEMPLE), x, y, l, 0, 0) end,
					function(x, y, l) return 0 end,
				},
				[THEME.CITY_OF_GOLD] = {
					function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_COG, x, y, l, 0, 0) end,
					function(x, y, l) return 0 end,
				},
			},
		},
		description = "Terrain/Empty",
	},
	["3"] = {
		phase_3 = {
			default = {
				function(x, y, l)
					local floors = get_entities_at(0, MASK.FLOOR, x, y, l, 0.5)
					if #floors == 0 then
						spawn_liquid(ENT_TYPE.LIQUID_WATER, x, y)
						return ENT_TYPE.LIQUID_WATER
					end
				end,
			},
			alternate = {
				[THEME.EGGPLANT_WORLD] = {
					function(x, y, l)
						local floors = get_entities_at(0, MASK.FLOOR, x, y, l, 0.5)
						if #floors == 0 then
							spawn_liquid(ENT_TYPE.LIQUID_WATER, x, y)
							return ENT_TYPE.LIQUID_WATER
						end
					end,
				},
				[THEME.TEMPLE] = {
					function(x, y, l)
						local floors = get_entities_at(0, MASK.FLOOR, x, y, l, 0.5)
						if #floors == 0 then
							spawn_liquid(ENT_TYPE.LIQUID_LAVA, x, y)
							return ENT_TYPE.LIQUID_LAVA
						end
					end,
				},
				[THEME.CITY_OF_GOLD] = {
					function(x, y, l)
						local floors = get_entities_at(0, MASK.FLOOR, x, y, l, 0.5)
						if #floors == 0 then
							spawn_liquid(ENT_TYPE.LIQUID_LAVA, x, y)
							return ENT_TYPE.LIQUID_LAVA
						end
					end,
				},
				[THEME.VOLCANA] = {
					function(x, y, l)
						local floors = get_entities_at(0, MASK.FLOOR, x, y, l, 0.5)
						if #floors == 0 then
							spawn_liquid(ENT_TYPE.LIQUID_LAVA, x, y)
							return ENT_TYPE.LIQUID_LAVA
						end
					end,
				},
			},
		},
		phase_1 = {
			default = {
				function(x, y, l)
					local uid = spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0)
					-- get_entity(uid):fix_decorations(true, true)
				end,
				function(x, y, l)
				end,
			},
			alternate = {
				[THEME.EGGPLANT_WORLD] = {
					function(x, y, l)
						local uid = spawn_grid_entity(ENT_TYPE.FLOORSTYLED_GUTS, x, y, l, 0, 0)
						-- get_entity(uid):fix_decorations(true, true)
					end,
					function(x, y, l) return ENT_TYPE.LIQUID_WATER end,
				},
				[THEME.TEMPLE] = {
					function(x, y, l)
						local uid = spawn_grid_entity((options.hd_og_floorstyle_temple and ENT_TYPE.FLOORSTYLED_STONE or ENT_TYPE.FLOORSTYLED_TEMPLE), x, y, l, 0, 0)
						-- get_entity(uid):fix_decorations(true, true)
					end,
					function(x, y, l) return ENT_TYPE.LIQUID_LAVA end,
				},
				[THEME.CITY_OF_GOLD] = {
					function(x, y, l)
						local uid = spawn_grid_entity(ENT_TYPE.FLOORSTYLED_COG, x, y, l, 0, 0)
						-- get_entity(uid):fix_decorations(true, true)
					end,
					function(x, y, l) return ENT_TYPE.LIQUID_LAVA end,
				},
				[THEME.VOLCANA] = {
					function(x, y, l)
						local uid = spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0)
						-- get_entity(uid):fix_decorations(true, true)
					end,
					function(x, y, l) return ENT_TYPE.LIQUID_LAVA end,
				},
			},
		},
		description = "Terrain/Water",
	},
	["4"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.ACTIVEFLOOR_PUSHBLOCK, x, y, l, 0, 0) end,},
		},
		description = "Pushblock",
	},
	["5"] = {
		description = "Ground Obstacle Block",
	},
	["6"] = {
		description = "Floating Obstacle Block",
	},
	["7"] = {
		phase_2 = {
			default = {
				function(x, y, l)
					floorsAtOffset = get_entities_at(0, MASK.FLOOR, x, y-1, LAYER.FRONT, 0.5)
					-- # TOTEST: If gems/gold/items are spawning over this, move this method to run after gems/gold/items get embedded. Then here, detect and remove any items already embedded.
					
					if #floorsAtOffset > 0 then
						local floor_uid = floorsAtOffset[1]
						-- local floor = get_entity(floor_uid)
						
						spawn_entity_over(ENT_TYPE.FLOOR_SPIKES, floor_uid, 0, 1)
						-- if state.theme == THEME.EGGPLANT_WORLD then
						-- 	local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_FLOORSTYLED_GUTS_0)
						-- 	deco_texture = define_texture(texture_def)

						-- 	floor:add_decoration(FLOOR_SIDE.TOP)
							
						-- 	if floor.deco_top ~= -1 then
						-- 		local deco = get_entity(floor.deco_top)
						-- 		deco:set_texture(deco_texture)
						-- 	end
						-- end
					end
				end,
				function(x, y, l) return 0 end
			},
		},
		description = "Spikes/Empty",
	},
	["8"] = {
		description = "Door with Terrain Block",
	},
	["9"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					-- need subchunkid of what room we're in
					local roomx, roomy = locatelib.locate_levelrooms_position_from_game_position(x, y)
					local _subchunk_id = roomgenlib.global_levelassembly.modification.levelrooms[roomy][roomx]
					
					if (
						(_subchunk_id == roomdeflib.HD_SUBCHUNKID.ENTRANCE)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.ENTRANCE_DROP)
					) then
						doorslib.create_door_entrance(x, y, l)
					elseif (_subchunk_id == roomdeflib.HD_SUBCHUNKID.YAMA_ENTRANCE) then
						doorslib.create_door_entrance(x+0.5, y, l)
					elseif (
						(_subchunk_id == roomdeflib.HD_SUBCHUNKID.EXIT)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.EXIT_NOTOP)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.RUSHING_WATER_EXIT)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.HAUNTEDCASTLE_EXIT)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.HAUNTEDCASTLE_EXIT_NOTOP)
					) then
						-- spawn an exit door to the next level. Spawn a shopkeeper if agro.
						doorslib.create_door_exit(x, y, l)
					elseif (_subchunk_id == roomdeflib.HD_SUBCHUNKID.MOTHERSHIPENTRANCE_TOP) then
						doorslib.create_door_exit_to_mothership(x, y, l)
					elseif (_subchunk_id == roomdeflib.HD_SUBCHUNKID.RESTLESS_TOMB) then
						-- Spawn king's tombstone
						local block_uid = spawn_grid_entity(ENT_TYPE.FLOOR_JUNGLE_SPEAR_TRAP, x, y, l, 0, 0)
						local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_FLOORMISC_0)
						texture_def.texture_path = "res/floormisc_tombstone_king.png"
						get_entity(block_uid):set_texture(define_texture(texture_def))
						
						-- 2 tiles down
						-- Spawn skeleton
						spawn_entity_snapped_to_floor(ENT_TYPE.ITEM_BONES, x-0.1, y-2, l, 0, 0)
						local skull_uid = spawn_entity_snapped_to_floor(ENT_TYPE.ITEM_SKULL, x+0.1, y-2, l, 0, 0)
						flip_entity(skull_uid)

						-- Spawn Crown
						-- local dar_crown = get_entity(spawn_entity_snapped_to_floor(ENT_TYPE.ITEM_DIAMOND, x, y-2, l, 0, 0))
						local dar_crown_uid = spawn_entity_over(ENT_TYPE.ITEM_DIAMOND, skull_uid, -0.15, 0.42)
						local dar_crown = get_entity(dar_crown_uid)
						-- # TODO: Setting the crown angled results in it staying angled when knocked off.
						-- Make an on frame method to adjust the angle after dismount
						-- dar_crown.angle = -0.15

						local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_ITEMS_0)
						texture_def.texture_path = "res/items_dar_crown.png"
						dar_crown:set_texture(define_texture(texture_def))

						-- 4 tiles down
						-- Spawn hidden entrance
						doorslib.create_door_exit_to_hauntedcastle(x, y-4, l)
					elseif (_subchunk_id == roomdeflib.HD_SUBCHUNKID.YAMA_EXIT) then
						doorslib.create_door_ending(x, y, l)
					end
				end
			},
		},
		description = "Exit/Entrance/Special Door", -- old description: "Door without Platform"
	},
	[":"] = {
		phase_1 = {
			default = {
				function(x, y, l) spawn_grid_entity(ENT_TYPE.MONS_SCORPION, x, y, l, 0, 0) end,
			},
			alternate = {
				[THEME.JUNGLE] = {
					function(x, y, l) spawn_grid_entity(ENT_TYPE.MONS_TIKIMAN, x, y, l, 0, 0) end,
					function(x, y, l) spawn_grid_entity(ENT_TYPE.MONS_CAVEMAN, x, y, l, 0, 0) end,
				},
				[THEME.ICE_CAVES] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.MONS_YETI, x, y, l, 0, 0) end,},
				[THEME.NEO_BABYLON] = {
					function(x, y, l) spawn_grid_entity(ENT_TYPE.MONS_YETI, x, y, l, 0, 0) end,
					function(x, y, l) spawn_grid_entity(ENT_TYPE.MONS_CAVEMAN, x, y, l, 0, 0) end,
				}
			},
		},
		description = "World-specific Enemy Spawn",--"Scorpion from Mines Coffin",
	},
	[";"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					createlib.create_damsel(x, y, l)
					createlib.create_idol(x+1, y, l)
				end,
			},
			alternate = {
				-- force field spawning method, rows of 3.
				[THEME.ICE_CAVES] = {
					function(x, y, l) return 0 end,
				},
				[THEME.NEO_BABYLON] = {
					function(x, y, l) return 0 end,
				},
			}
		},
		description = "Damsel and Idol from Kalipit",
	},
	["="] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_MINEWOOD, x, y, l, 0, 0) end,},
			alternate = {
				[THEME.VOLCANA] = {
					function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_VLAD, x, y, l, 0, 0) end,
				}
			},
		},
		description = "Wood with Background",
	},
	["A"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					local idol_block_first = get_entity(spawn_grid_entity(ENT_TYPE.FLOOR_IDOL_BLOCK, x, y, l, 0, 0))
					local idol_block_second = get_entity(spawn_grid_entity(ENT_TYPE.FLOOR_IDOL_BLOCK, x+1, y, l, 0, 0))

					if state.theme ~= THEME.VOLCANA then
						local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_FLOOR_CAVE_0)
						texture_def.texture_path = "res/idol_platform_generic.png"
						if state.theme == THEME.TEMPLE then
							texture_def.texture_path = "res/idol_platform_temple.png"
						end

						idol_block_first:set_texture(define_texture(texture_def))
						idol_block_second:set_texture(define_texture(texture_def))
					end
					idol_block_second.animation_frame = idol_block_second.animation_frame + 1
				end,
			},
		},
		description = "Idol Platform", --"Mines Idol Platform",
	},
	["B"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					local block_uid = spawn_grid_entity(ENT_TYPE.FLOOR_JUNGLE_SPEAR_TRAP, x, y, l, 0, 0)
					local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_FLOORMISC_0)
					texture_def.texture_path = "res/floormisc_idoltrap_floor.png"
					get_entity(block_uid):set_texture(define_texture(texture_def))
					idollib.idoltrap_blocks[#idollib.idoltrap_blocks+1] = block_uid
				end,
			},
		},
		description = "Jungle/Temple Idol Platform",
	},
	["C"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					local block_uid = spawn(ENT_TYPE.ACTIVEFLOOR_PUSHBLOCK, x, y, l, 0, 0)
					local block = get_entity(block_uid)
					block.flags = set_flag(block.flags, ENT_FLAG.NO_GRAVITY)
					block.more_flags = set_flag(block.more_flags, 17)
					idollib.idoltrap_blocks[#idollib.idoltrap_blocks+1] = block_uid
				end,
			},
			alternate = {
				[THEME.VOLCANA] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_CRATE, x, y, l, 0, 0) end},
			},
		},
		description = "Temple Idol Trap Ceiling Block",--"Nonmovable Pushblock", -- also idol trap ceiling blocks
	},
	["D"] = {
		phase_1 = {
			default = {function(x, y, l)
				local slidingwall_ceiling = get_entity(spawn_entity(ENT_TYPE.FLOOR_SLIDINGWALL_CEILING, x, y, l, 0.0, 0.0))
				local slidingwall_chain = get_entity(spawn_over(ENT_TYPE.ITEM_SLIDINGWALL_CHAIN_LASTPIECE, slidingwall_ceiling.uid, 0, 0))
				local slidingwall = get_entity(spawn_over(ENT_TYPE.ACTIVEFLOOR_SLIDINGWALL, slidingwall_chain.uid, 0, -1.5))
				
				if state.theme == THEME.TEMPLE then
					local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_FLOORSTYLED_PAGODA_0)
					texture_def.texture_path = "res/floorstyled_temple_slidingwall.png"
					slidingwall_ceiling:set_texture(define_texture(texture_def))
					slidingwall_chain:set_texture(define_texture(texture_def))
	
					texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_FLOORSTYLED_PAGODA_1)
					texture_def.texture_path = "res/floorstyled_temple_slidingwall.png"
					slidingwall:set_texture(define_texture(texture_def))
				end

				-- spawn_entity(ENT_TYPE.ITEM_SLIDINGWALL_SWITCH, x+1, y-1, l, 0, 0)

				--[[ this code causes the game to crash
				slidingwall_ceiling.active_floor_part_uid = slidingwall.uid
				slidingwall_ceiling.state = 1
				slidingwall_chain.attached_to_uid = -1
				slidingwall_chain.timer = -1
				slidingwall.ceiling = slidingwall_ceiling
				--]]

			end},
			tutorial = {
				function(x, y, l) createlib.create_damsel(x, y, l) end,
			},
		},
		--#TOTEST: Also used in tutorial level 3 placement {3, 4} as Damsel
		-- # TODO: door creation (should be same door as "%")
		description = "Door Gate", -- also used in temple idol trap
	},
	["E"] = {
		phase_1 = {
			tutorial = {
				function(x, y, l) spawn_entity_snapped_to_floor(ENT_TYPE.ITEM_GOLDBAR, x, y, l, 0, 0) end,
			},
			default = {
				function(x, y, l)
					if math.random(10) == 1 then
						spawn_grid_entity(ENT_TYPE.ITEM_CHEST, x, y, l, 0, 0)
					elseif math.random(5) == 1 then
						spawn_grid_entity(ENT_TYPE.ITEM_CRATE, x, y, l, 0, 0)
					elseif math.random(2) == 2 then
						tile_to_spawn = ENT_TYPE.FLOOR_GENERIC
						if state.theme == THEME.OLMEC then
							tile_to_spawn = ENT_TYPE.FLOORSTYLED_STONE
						elseif state.theme == THEME.CITY_OF_GOLD then
							tile_to_spawn = ENT_TYPE.FLOORSTYLED_COG
						elseif state.theme == THEME.TEMPLE then
							tile_to_spawn = (options.hd_og_floorstyle_temple and ENT_TYPE.FLOORSTYLED_STONE or ENT_TYPE.FLOORSTYLED_TEMPLE)
						end
						spawn_grid_entity(tile_to_spawn, x, y, l, 0, 0)
					else
						return 0
					end
				end,
				-- function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0) end,
				-- function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_CRATE, x, y, l, 0, 0) end,
				-- function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_CHEST, x, y, l, 0, 0) end,
				-- function(x, y, l) return 0 end,
			},
			-- alternate = {
			-- 	[THEME.OLMEC] = {
			-- 		function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_STONE, x, y, l, 0, 0) end,
			-- 		function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_CRATE, x, y, l, 0, 0) end,
			-- 		function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_CHEST, x, y, l, 0, 0) end,
			-- 		function(x, y, l) return 0 end,
			-- 	},
			-- [THEME.TEMPLE] = {
			-- 	function(x, y, l) spawn_grid_entity((options.hd_og_floorstyle_temple and ENT_TYPE.FLOORSTYLED_STONE or ENT_TYPE.FLOORSTYLED_TEMPLE), x, y, l, 0, 0) end,
			-- 	function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_CRATE, x, y, l, 0, 0) end,
			-- 	function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_CHEST, x, y, l, 0, 0) end,
			-- 	function(x, y, l) return 0 end,
			-- },
			-- [THEME.CITY_OF_GOLD] = {
			-- 	function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_COG, x, y, l, 0, 0) end,
			-- 	function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_CRATE, x, y, l, 0, 0) end,
			-- 	function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_CHEST, x, y, l, 0, 0) end,
			-- 	function(x, y, l) return 0 end,
			-- },
			-- },
		},
		description = "Terrain/Empty/Crate/Chest",
	},
	["F"] = {
		description = "Falling Platform Obstacle Block",
	},
	["G"] = {
		phase_1 = {
			default = {
				function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_LADDER, x, y, l, 0, 0) end,
			},
		},
		description = "Ladder (Strict)",
	},
	["H"] = {
		phase_1 = {
			default = {
				function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_LADDER_PLATFORM, x, y, l, 0, 0) end,
			},
		},
		description = "Ladder Platform (Strict)",
	},
	["I"] = {
		phase_2 = {
			default = {
				function(x, y, l)
					-- Idol trap variants
					if state.theme == THEME.DWELLING then
						local statue = get_entity(spawn_entity(ENT_TYPE.BG_BOULDER_STATUE, x+0.5, y+2.5, l, 0, 0))
						local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_DECO_ICE_1)
						texture_def.texture_path = "res/deco_extra_idol_statue.png"
						statue:set_texture(define_texture(texture_def))
					end
					
					-- need subchunkid of what room we're in
					local roomx, roomy = locatelib.locate_levelrooms_position_from_game_position(x, y)
					local _subchunk_id = roomgenlib.global_levelassembly.modification.levelrooms[roomy][roomx]
					
					if (
						(_subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_UNLOCK_RIGHT)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_UNLOCK_LEFT)
					) then
						hdtypelib.create_hd_type(hdtypelib.HD_ENT.TRAP_TIKI, x, y, l, false, 0, 0)
					elseif (
						(_subchunk_id == roomdeflib.HD_SUBCHUNKID.YAMA_SETROOM_3_2)
						-- or (_subchunk_id == genlib.HD_SUBCHUNKID.YAMA_SETROOM_3_3)
					) then
						for i = 0, 10, 2 do
							local uid = hdtypelib.create_hd_type(hdtypelib.HD_ENT.TRAP_TIKI, x, y+i, l, false, 0, 0)
							-- uid = get_entities_at(ENT_TYPE.FLOOR_TRAP_TOTEM, 0, x, y+i, l, .5)[1]
							if uid ~= -1 then
								get_entity(uid).animation_frame = 12
							end
						end
						for i = 0, 10, 2 do
							local uid = hdtypelib.create_hd_type(hdtypelib.HD_ENT.TRAP_TIKI, x+7, y+i, l, false, 0, 0)
							-- uid = get_entities_at(ENT_TYPE.FLOOR_TRAP_TOTEM, 0, x, y+i, l, .5)[1]
							if uid ~= -1 then
								get_entity(uid).animation_frame = 12
							end
						end
					else
						-- SORRY NOTHING 
					end
				end,
			},
		},
		phase_1 = {
			default = {
				function(x, y, l)
					-- need subchunkid of what room we're in
					local roomx, roomy = locatelib.locate_levelrooms_position_from_game_position(x, y)
					local _subchunk_id = roomgenlib.global_levelassembly.modification.levelrooms[roomy][roomx]
					
					if (
						(_subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_COOP)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_COOP_NOTOP)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_COOP_DROP)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_COOP_DROP_NOTOP)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_UNLOCK_RIGHT)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_UNLOCK_LEFT)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.YAMA_SETROOM_3_2)
						or (_subchunk_id == roomdeflib.HD_SUBCHUNKID.YAMA_SETROOM_3_3)
					) then
						-- SORRY NOTHING 
					else
						createlib.create_idol(x+0.5, y, l)
					end
				end,
			},
		},
		description = "Idol", -- sometimes a tikitrap if it's a character unlock
	},
	["J"] = {
		phase_1 = {
			default = {
				function(x, y, l) spawn_entity(ENT_TYPE.MONS_GIANTFISH, x, y, l, 0, 0) end,
			},
		},
		description = "Ol' Bitey",
	},
	["K"] = {
		phase_1 = {
			default = {
				function(x, y, l) spawn_entity(ENT_TYPE.MONS_SHOPKEEPER, x, y, l, 0, 0) end,
			},
		},
		description = "Shopkeeper",
	},
	["L"] = {
		-- phase_4 = {
		-- 	alternate = {
		-- 		[THEME.NEO_BABYLON] = {
		-- 			function(x, y, l)
		-- 				spawn_grid_entity(ENT_TYPE.ACTIVEFLOOR_SHIELD, x, y, l, 0, 0)
		-- 				return 0
		-- 			end,
		-- 		},
		-- 	}
		-- },
		phase_3 = {
			alternate = {
				[THEME.VOLCANA] = {
					function(x, y, l) createlib.create_ceiling_chain(x, y, l) end,
				},
			}
		},
		phase_2 = {
			alternate = {
				[THEME.VOLCANA] = {
					function(x, y, l) return 0 end,
				},
			}
		},
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_LADDER, x, y, l, 0, 0) end,},
			alternate = {
				[THEME.JUNGLE] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_VINE, x, y, l, 0, 0) end,},
				[THEME.EGGPLANT_WORLD] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_VINE, x, y, l, 0, 0) end,},

				[THEME.NEO_BABYLON] = {
					function(x, y, l) return 0 end,
				},
				[THEME.VOLCANA] = {function(x, y, l) return 0 end},
				[THEME.CITY_OF_GOLD] = {
					function(x, y, l)
						local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_FLOOR_CAVE_0)
						texture_def.texture_path = "res/floorstyled_gold_ladders.png"
						local ent_texture = define_texture(texture_def)
						local ent_uid = spawn_grid_entity(ENT_TYPE.FLOOR_LADDER, x, y, l)
						get_entity(ent_uid):set_texture(ent_texture)
					end
				},
			},
		},
		description = "Ladder", -- sometimes used as Vine or Chain
	},
	["M"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					embedlib.embed_item(ENT_TYPE.ITEM_MATTOCK, spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0), 128)
				end,
			},
			alternate = {
				[THEME.ICE_CAVES] = {
					function(x, y, l)
						embedlib.embed_item(ENT_TYPE.ITEM_JETPACK, spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0), 41)
					end
				},
			}
		},
		description = "World-Specific Crust Item", --"Crust Mattock from Snake Pit",
	},
	["N"] = {
		phase_1 = {
			-- # TODO: In HD this seems to be a chance of either a snake or a cobra
			tutorial = {function(x, y, l) spawn_grid_entity(ENT_TYPE.MONS_SNAKE, x, y, l, 0, 0) end,},
			default = {
				function(x, y, l)
					if math.random(4) == 1 then
						spawn_grid_entity(ENT_TYPE.MONS_COBRA, x, y, l, 0, 0)
					else
						spawn_grid_entity(ENT_TYPE.MONS_SNAKE, x, y, l, 0, 0)
					end
				end,
			},
			alternate = {
				[THEME.JUNGLE] = {
					function(x, y, l) spawn_entity(ENT_TYPE.ITEM_LITWALLTORCH, x, y, l, 0, 0) end,
				}
			}
		},
		description = "Snake from Snake Pit",
	},
	["O"] = {
		-- # TODO: Moai ankh respawn mechanics
		-- # TODO: Foreground Entity/Texture
		phase_3 = {
			default = {
				function(x, y, l)
					local moai_texture_indices = { 0, 1, 8, 9, 16, 17, 24, 25, 32 } -- yada yada lazy programming yada yada
					local moai_index = 1
					local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_BORDER_MAIN_0)
					texture_def.texture_path = "res/border_main_moai.png"
					for yi = 0, -3, -1 do
						for xi = 0, 2, 1 do
							if (yi ~= 0 and xi == 1) then
								-- SORRY NOTHING
							else
								local block_uid = get_grid_entity_at(x+xi, y+yi, l)
								if block_uid ~= -1 then
									local moai_block = get_entity(block_uid)
									moai_block:set_texture(define_texture(texture_def))
									moai_block.animation_frame = moai_texture_indices[moai_index]
									moai_index = moai_index + 1
								end
							end
						end
					end
				end
			}
		},
		phase_1 = {
			default = {
				--[[
					# TOFIX: Moai animation_frames get overridden.
						Run global_timeout(s?) to set them.
						>Mr Auto:
							"`local x = 5
							set_global_timeout(function() message(x) end, frames)
							x = nil`
							will print 5 no matter the number of frames you input"
				--]]
				function(x, y, l)
					for yi = 0, -3, -1 do
						for xi = 0, 2, 1 do
							if (yi ~= 0 and xi == 1) then
								-- SORRY NOTHING
							else
								spawn_grid_entity(ENT_TYPE.FLOOR_BORDERTILE_METAL, x+xi, y+yi, l, 0, 0)
							end
						end
					end
					doorslib.create_door_exit_moai(x+1, y-3, l)
					ankhmoailib.create_moai_veil(x, y, l)
				end,
			},
		},
		description = "Moai Head",
	},
	["P"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_LADDER_PLATFORM, x, y, l, 0, 0) end,},
			alternate = {
				[THEME.CITY_OF_GOLD] = {
					function(x, y, l)
						local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_FLOOR_CAVE_0)
						texture_def.texture_path = "res/floorstyled_gold_ladders.png"
						local ent_texture = define_texture(texture_def)
						local ent_uid = spawn_grid_entity(ENT_TYPE.FLOOR_LADDER_PLATFORM, x, y, l)
						get_entity(ent_uid):set_texture(ent_texture)
					end
				},
			}
		},
		description = "Ladder Platform (Strict)",
	},
	["Q"] = {
		phase_3 = {
			alternate = {
				[THEME.VOLCANA] = {function(x, y, l) createlib.create_ceiling_chain_growable(x, y, l) end},
			}
		},
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_GROWABLE_VINE, x, y, l, 0, 0) end,},
			alternate = {
				[THEME.NEO_BABYLON] = {function(x, y, l) spawn_entity(ENT_TYPE.MONS_ALIENQUEEN, x, y, l, 0, 0) end,},
				[THEME.VOLCANA] = {function(x, y, l) return 0 end},
			},
		},
		description = "Variable-Length Ladder/Vine",
	},
	["R"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_RUBY, x, y, l, 0, 0) end,},
		},
		description = "Ruby from Snakepit",
	},
	["S"] = {
		description = "Shop Items",
	},
	["T"] = {
		phase_3 = {
			default = {
				function(x, y, l)
					spawn_tree(x, y, l)
				end,
			},
		},

		description = "Tree",
	},
	["U"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_entity(ENT_TYPE.MONS_VLAD, x+.5, y, l, 0, 0) end,},
			alternate = {
				-- Black Knight
				[THEME.JUNGLE] = {function(x, y, l)
					blackknightlib.create_black_knight(x, y, l)
				end},
			}
		},
		description = "Vlad/Black Knight",
	},
	["V"] = {
		description = "Vines Obstacle Block",
	},
	["W"] = {
		description = "Wanted Poster",--"Unknown: Something Shop-Related",
	},
	["X"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_entity(ENT_TYPE.MONS_GIANTSPIDER, x+0.5, y, l, 0, 0) end,},
			alternate = {
				-- Alien Lord
				--[[
					erictran:
					"he shouldnt be too hard to program, just take something like yeti king / queen,
					disable their AI, retexture them to use the alien lord from s1 and make him
					periodically spawn the anubis projectiles.
					
					well dont literally disable their ai, but set their move_state and state values
					to some arbitrary value to stop them from moving."
					-- Change projectile speed with `ScepterShot::speed`
				--]]

				[THEME.ICE_CAVES] = {function(x, y, l) return 0 end},
				[THEME.NEO_BABYLON] = {function(x, y, l) return 0 end},
				-- Horse Head & Ox Face
				[THEME.VOLCANA] = {function(x, y, l) return 0 end},
			}
		},
		description = "Giant Spider",
	},
	["Y"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_entity(ENT_TYPE.MONS_YETIKING, x, y, l, 0, 0) end,},
			alternate = {
				[THEME.TEMPLE] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.MONS_MUMMY, x, y, l, 0, 0) end,},
				[THEME.CITY_OF_GOLD] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.MONS_MUMMY, x, y, l, 0, 0) end,},
				[THEME.VOLCANA] = {
					function(x, y, l) createlib.create_yama(x, y, l) end
				},
			},
		},
		description = "Yeti King",
	},
	["Z"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_BEEHIVE, x, y, l, 0, 0) end,},
		},
		description = "Beehive Tile with Background",
	},
	["a"] = {
		--#TOTEST: Also used in tutorial:
			-- 2nd level, placement {4,2}.
			-- 3rd level, placement {1,2}.
		phase_1 = {
			default = {
				function(x, y, l)
					local shopkeeper = spawn_shopkeeper(x+3, y, l, ROOM_TEMPLATE.SHOP_LEFT)
					ankh_uid = spawn_grid_entity(ENT_TYPE.ITEM_PICKUP_ANKH, x, y, l)
					add_item_to_shop(ankh_uid, shopkeeper)
					add_custom_name(ankh_uid, "Ankh")
					ankh_mov = get_entity(ankh_uid)
					ankh_mov.flags = set_flag(ankh_mov.flags, ENT_FLAG.SHOP_ITEM)
					ankh_mov.flags = set_flag(ankh_mov.flags, ENT_FLAG.ENABLE_BUTTON_PROMPT)
					spawn_entity_over(ENT_TYPE.FX_SALEICON, ankh_uid, 0, 0)
					spawn_entity_over(ENT_TYPE.FX_SALEDIALOG_CONTAINER, ankh_uid, 0, 0)

					-- if options.hd_og_ankhprice == true then
						ankh_mov.price = 50000
					-- else
						-- ankh_mov.price = -- # TODO: Figure out what S2 does to calculate hedject shop price
					-- end
				end,
			},
			tutorial = {function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_POT, x, y, l, 0, 0) end,},
		},
		description = "Ankh/Pot",
	},
	-- # TODO:
		-- Add alternative shop floor of FLOOR_GENERIC
		-- Modify all HD shop roomcodes to accommodate this.
	["b"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					local entity = get_entity(spawn_grid_entity(ENT_TYPE.FLOORSTYLED_MINEWOOD, x, y, l, 0, 0))
					entity.flags = set_flag(entity.flags, ENT_FLAG.SHOP_FLOOR)
				end,
			},
		},
		description = "Shop Floor",
	},
	["c"] = {
		phase_1 = {
			default = {
				function(x, y, l) createlib.create_idol_crystalskull(x+0.5, y, l) end,
			},
			alternate = {
				[THEME.EGGPLANT_WORLD] = {
					function(x, y, l)
						if (math.random(2) == 2) then
							x = x + 10
						end
						createlib.create_crysknife(x, y, l)
					end
				},
			}
		},
		description = "Crystal Skull",
	},
	["d"] = {
		-- HD may spawn this as wood at times. The solution is to replace that tilecode with "v"
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_JUNGLE, x, y, l, 0, 0) end,},
			alternate = {
				[THEME.EGGPLANT_WORLD] = {function(x, y, l) createlib.create_regenblock(x, y, l) end,},
			},
		},
		description = "Jungle Terrain",
	},
	["e"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_BEEHIVE, x, y, l, 0, 0) end,},
			tutorial = {
				function(x, y, l)
					set_contents(spawn_grid_entity(ENT_TYPE.ITEM_CRATE, x, y, l, 0, 0), ENT_TYPE.ITEM_PICKUP_BOMBBAG)
				end,
			},
		},
		description = "Beehive Tile",
	},
	["f"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.ACTIVEFLOOR_FALLING_PLATFORM, x, y, l, 0, 0) end,},
		},
		description = "Falling Platform",
	},
	["g"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					roomx, roomy = locatelib.locate_levelrooms_position_from_game_position(x, y)
					if roomgenlib.global_levelassembly.modification.levelrooms[roomy] ~= nil then
						local _subchunk_id = roomgenlib.global_levelassembly.modification.levelrooms[roomy][roomx]
					end
					local coffin_uid = nil
					if (
						_subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_COOP
						or _subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_COOP_DROP
						or _subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_COOP_NOTOP
						or _subchunk_id == roomdeflib.HD_SUBCHUNKID.COFFIN_COOP_DROP_NOTOP
					) then
						coffin_uid = createlib.create_coffin_coop(x+0.35, y, l)
					else
						coffin_uid = createlib.create_coffin_unlock(x+0.35, y, l)
					end
					if coffin_uid ~= nil then
						if state.theme == THEME.EGGPLANT_WORLD then
							coffin_e = get_entity(coffin_uid)
							coffin_e.flags = set_flag(coffin_e.flags, ENT_FLAG.NO_GRAVITY)
							coffin_e.velocityx = 0
							coffin_e.velocityy = 0
							local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_COFFINS_0)
							texture_def.texture_path = "res/coffins_worm.png"
							coffin_e:set_texture(define_texture(texture_def))
						end
					end
				end
			},
		},
		description = "Coffin",
	},
	["h"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_VLAD, x, y, l, 0, 0) end,},
			tutorial = {
				function(x, y, l)
					set_contents(spawn_grid_entity(ENT_TYPE.ITEM_CRATE, x, y, l, 0, 0), ENT_TYPE.ITEM_PICKUP_ROPEPILE)
				end,
			},
			alternate = {
				[THEME.JUNGLE] = {
					function(x, y, l)
						local ent_uid = spawn_entity(ENT_TYPE.BG_BASECAMP_SHORTCUTSTATIONBANNER, x+4, y+2, l, 0, 0)
						local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_DECO_BASECAMP_3)
						texture_def.texture_path = "res/deco_basecamp_hauntedcastle_banner.png"
						get_entity(ent_uid):set_texture(define_texture(texture_def))
						
						-- # TODO: I think I'm screwing the sizing on this haunted castle altar bg entirely.
							-- Please fix (both here and the .ase file)
						ent_uid = spawn_entity(ENT_TYPE.BG_KALI_STATUE, x+.5, y+0.6, l, 0, 0)
						local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_DECO_JUNGLE_0)
						texture_def.texture_path = "res/deco_jungle_hauntedcastle.png"
						get_entity(ent_uid):set_texture(define_texture(texture_def))
						get_entity(ent_uid).width = 5.0--5.600
						get_entity(ent_uid).height = 5.0--7.000

						spawn_grid_entity(ENT_TYPE.FLOOR_ALTAR, x, y-1, l, 0, 0)
						spawn_grid_entity(ENT_TYPE.FLOOR_ALTAR, x+1, y-1, l, 0, 0)

						spawn_grid_entity(ENT_TYPE.FLOORSTYLED_STONE, x-1, y, l, 0, 0)
						spawn_grid_entity(ENT_TYPE.FLOORSTYLED_STONE, x-1, y-1, l, 0, 0)
						spawn_grid_entity(ENT_TYPE.FLOORSTYLED_STONE, x+2, y, l, 0, 0)
						spawn_grid_entity(ENT_TYPE.FLOORSTYLED_STONE, x+2, y-1, l, 0, 0)
					end,
				}
			},
		},
		description = "Vlad's Castle Brick",--Hell Terrain",
		--#TODO: in HD it's also the haunted castle altar
	},
	["i"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_ICE, x, y, l, 0, 0) end,},
			alternate = {
				[THEME.JUNGLE] = {
					function(x, y, l)
						spawn_entity_over(ENT_TYPE.ITEM_LAVAPOT, spawn_entity(ENT_TYPE.ITEM_COOKFIRE, x, y, l, 0, 0), 0, 0.675)
					end,
				}
			},
		},
		description = "Ice Block",
	},
	["j"] = {
		phase_1 = {
			default = {
				-- function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_ICE, x, y, l, 0, 0) end,
				function(x, y, l) return 0 end,
			},
		},
		description = "Unused (In classic this was 'Ice Block/Empty'", -- Old description: "Ice Block with Caveman".
	},
	["k"] = { -- Sign creation currently done in S2 gen
		phase_1 = {
			default = {
				function(x, y, l)
					spawn_grid_entity(ENT_TYPE.FLOORSTYLED_MINEWOOD, x, y, l)

					-- #TOTEST: Scripted gen shopsign spawning: For some reason this is really unstable and breaks generation 1/4 of the time.
					-- Steps:
						-- 1.) Uncomment the following code back in
						-- 2.) Uncomment ROOMOBJECT.GENERIC roomcode definitions back in
						-- 3.) Toggle the relevant ignore flag in the Modlunky level editor for the regular shop and gambling shop roomcodes

					
					-- -- need subchunkid of what room we're in
					-- roomx, roomy = locatelib.locate_levelrooms_position_from_game_position(x, y)
					-- _subchunk_id = roomgenlib.global_levelassembly.modification.levelrooms[roomy][roomx]
						
					-- spawn_entity(ENT_TYPE.DECORATION_SHOPSIGN,
					-- (
					-- 	x+(
					-- 		(
					-- 			_subchunk_id == genlib.HD_SUBCHUNKID.SHOP_REGULAR_LEFT or
					-- 			_subchunk_id == genlib.HD_SUBCHUNKID.SHOP_PRIZE_LEFT
					-- 		)
					-- 		and -0.5 or 0.5
					-- 	)
					-- ), y+2.5, l, 0, 0)
					-- -- # TODO: Spawn shop icon
				end,
			},
		},
		description = "Shop Entrance Sign",
	},
	["l"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_LAMP, x, y, l, 0, 0) end,},
		},
		description = "Shop Lantern",
	},
	["m"] = {
		phase_4 = {
			alternate = {
				[THEME.NEO_BABYLON] = {
					function(x, y, l)
						spawn_grid_entity(ENT_TYPE.ACTIVEFLOOR_ELEVATOR, x, y, l)
						-- need subchunkid of what room we're in
						roomx, roomy = locatelib.locate_levelrooms_position_from_game_position(x, y)
						_subchunk_id = roomgenlib.global_levelassembly.modification.levelrooms[roomy][roomx]
						
						if (
							(_subchunk_id == roomdeflib.HD_SUBCHUNKID.ENTRANCE_DROP)
						) then
							spawn_entity(ENT_TYPE.FLOOR_DOOR_PLATFORM, x, y-1, l, 0, 0)
						end
						return 0
					end,
				},
			}
		},
		phase_1 = {
			default = {
				function(x, y, l)
					local entity = get_entity(spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l))
					entity.flags = set_flag(entity.flags, ENT_FLAG.TAKE_NO_DAMAGE)
				end,
			},
			alternate = {
				[THEME.NEO_BABYLON] = {
					function(x, y, l) return 0 end,
				},
			},
		},
		description = "Unbreakable Terrain",
	},
	["n"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					if math.random(10) == 1 then
						spawn_grid_entity(ENT_TYPE.MONS_SNAKE, x, y, l, 0, 0)
					elseif math.random(2) == 1 then
						spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0)
					else
						return 0
					end
				end,
			},
		},
		description = "Terrain/Empty/Snake",
	},
	["o"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_entity_snapped_to_floor(ENT_TYPE.ITEM_ROCK, x, y, l, 0, 0) end,},
		},
		description = "Rock",
	},
	["p"] = {
		-- Appears to go unused.
		-- In HD it has no tilecode case, so I'm pretty sure it's unused.
		-- Appears in corners of the crystal idol room and at the bottom of a few ladders outside in the notop_drop rooms outside of the haunted castle.
		description = "Unused",--Treasure/Damsel",
	},
	["q"] = {
		-- # TODO: Trap Prevention.
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0) end,},
			alternate = {
				[THEME.TEMPLE] = {function(x, y, l) spawn_grid_entity((options.hd_og_floorstyle_temple and ENT_TYPE.FLOORSTYLED_STONE or ENT_TYPE.FLOORSTYLED_TEMPLE), x, y, l, 0, 0) end,},
				[THEME.CITY_OF_GOLD] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_COG, x, y, l, 0, 0) end,},
				[THEME.VOLCANA] = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_VLAD, x, y, l, 0, 0) end,},
			},
		},
		description = "Obstacle-Resistant Terrain",
	},
	["r"] = {
		description = "Terrain/Stone", -- old description: Mines Terrain/Temple Terrain/Pushblock
		-- Used to be used for Temple Obstacle Block but had to be assigned to a new tilecode ("(") to avoid problems
		-- From 
		phase_1 = {
			default = {
				function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_STONE, x, y, l, 0, 0) end,
				function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0) end,
				-- ENT_TYPE.ACTIVEFLOOR_PUSHBLOCK
			},
			alternate = {
				[THEME.VOLCANA] = {
					function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_VLAD, x, y, l, 0, 0) end,
					function(x, y, l) return 0 end,
				}
			},
		},
	},
	["s"] = {
		-- # TODO: Use phase 3 to spawn on bedrock floor
		phase_2 = {
			default = {
				function(x, y, l)
					floorsAtOffset = get_entities_at(0, MASK.FLOOR, x, y-1, LAYER.FRONT, 0.5)
					-- # TOTEST: If gems/gold/items are spawning over this, move this method to run after gems/gold/items get embedded. Then here, detect and remove any items already embedded.
					
					if #floorsAtOffset > 0 then
						local floor_uid = floorsAtOffset[1]
						local floor = get_entity(floor_uid)
						local spikes_uid = spawn_entity_over(ENT_TYPE.FLOOR_SPIKES, floor_uid, 0, 1)
						if state.theme == THEME.EGGPLANT_WORLD then
							local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_FLOOR_EGGPLANT_0)
							deco_texture = define_texture(texture_def)

							floor:add_decoration(FLOOR_SIDE.TOP)
							
							if floor.deco_top ~= -1 then
								local deco = get_entity(floor.deco_top)
								deco:set_texture(deco_texture)
								deco.animation_frame = math.random(101, 103)
							end
						elseif state.theme == THEME.VOLCANA then
							-- need subchunkid of what room we're in
							local roomx, roomy = locatelib.locate_levelrooms_position_from_game_position(x, y)
							local _subchunk_id = roomgenlib.global_levelassembly.modification.levelrooms[roomy][roomx]
							if (
								_subchunk_id == roomdeflib.HD_SUBCHUNKID.VLAD_TOP
								or _subchunk_id == roomdeflib.HD_SUBCHUNKID.VLAD_MIDSECTION
								or _subchunk_id == roomdeflib.HD_SUBCHUNKID.VLAD_BOTTOM
							) then
								local texture_def = get_texture_definition(TEXTURE.DATA_TEXTURES_FLOOR_VOLCANO_0)
								texture_def.texture_path = "res/vladspikes.png"
								get_entity(spikes_uid):set_texture(define_texture(texture_def))
							end
						end
					end
				end,
			}
		},
		description = "Spikes",
	},
	["t"] = {
		phase_1 = {
			default = {
				function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_STONE, x, y, l, 0, 0) end,
			},
			alternate = {
				[THEME.TEMPLE] = {
					function(x, y, l) spawn_grid_entity((options.hd_og_floorstyle_temple and ENT_TYPE.FLOORSTYLED_STONE or ENT_TYPE.FLOORSTYLED_TEMPLE), x, y, l, 0, 0) end,
					function(x, y, l) return 0 end,
				},
				[THEME.CITY_OF_GOLD] = {
					function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_COG, x, y, l, 0, 0) end,
					function(x, y, l) return 0 end,
				},
			}
		},
		-- # TODO: ????? Investigate in HD.
		description = "Temple/Castle Terrain",
	},
	["u"] = {
		phase_1 = {
			tutorial = {function(x, y, l) spawn_entity(ENT_TYPE.MONS_BAT, x, y, l, 0, 0) end,},
			default = {function(x, y, l) spawn_entity(ENT_TYPE.MONS_VAMPIRE, x, y, l, 0, 0) end,},
		},
		description = "Vampire from Vlad's Tower",
	},
	["v"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_MINEWOOD, x, y, l, 0, 0) end,},
		},
		description = "Wood",
	},
	["w"] = {
		phase_3 = {
			default = {function(x, y, l) spawn_liquid(ENT_TYPE.LIQUID_WATER, x, y) return ENT_TYPE.LIQUID_WATER end,},
			alternate = {
				[THEME.TEMPLE] = {function(x, y, l) spawn_liquid(ENT_TYPE.LIQUID_LAVA, x, y) return ENT_TYPE.LIQUID_LAVA end,},
				[THEME.CITY_OF_GOLD] = {function(x, y, l) spawn_liquid(ENT_TYPE.LIQUID_LAVA, x, y) return ENT_TYPE.LIQUID_LAVA end,},
				[THEME.VOLCANA] = {function(x, y, l) spawn_liquid(ENT_TYPE.LIQUID_LAVA, x, y) return ENT_TYPE.LIQUID_LAVA end,},
			},
		},
		description = "Liquid",
	},
	["x"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					spawn_grid_entity(ENT_TYPE.FLOOR_ALTAR, x, y, l, 0, 0)
					spawn_grid_entity(ENT_TYPE.FLOOR_ALTAR, x+1, y, l, 0, 0)
				end,
			},
		},
		description = "Kali Altar",
	},
	["y"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					embedlib.embed_nonitem(ENT_TYPE.ITEM_RUBY, spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, l, 0, 0))
				end
			},
			alternate = {
				[THEME.TEMPLE] = {
					function(x, y, l)
						embedlib.embed_nonitem(ENT_TYPE.ITEM_RUBY, spawn_grid_entity((options.hd_og_floorstyle_temple and ENT_TYPE.FLOORSTYLED_STONE or ENT_TYPE.FLOORSTYLED_TEMPLE), x, y, l, 0, 0))
					end
				},
				[THEME.VOLCANA] = {
					function(x, y, l)
						embedlib.embed_nonitem(ENT_TYPE.ITEM_RUBY, spawn_grid_entity(ENT_TYPE.FLOORSTYLED_VLAD, x, y, l, 0, 0))
					end
				}
			}
		},
		description = "Crust Ruby in Terrain",
	},
	["z"] = {
		phase_1 = {
			tutorial = {
				function(x, y, l) spawn_grid_entity(ENT_TYPE.ITEM_CHEST, x, y, l, 0, 0) end,
			},
			default = {
				function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOORSTYLED_BEEHIVE, x, y, l, 0, 0) end,
				function(x, y, l) return 0 end,
			},
			alternate = {
				[THEME.NEO_BABYLON] = {function(x, y, l)
					turrentlib.spawn_turrent(x, y, l)
				end,},
				[THEME.CITY_OF_GOLD] = {function(x, y, l) return 0 end,},
				[THEME.VOLCANA] = {function(x, y, l) return 0 end,} -- bg columns
			},
		},
		-- # TODO: Temple has bg pillar as an alternative
		description = "Beehive Tile/Empty",
	},
	["|"] = {
		phase_1 = {
			default = {
				function(x, y, l)
					for yi = 0, -3, -1 do
						for xi = 0, 3, 1 do
							if (yi == -1 and (xi == 1 or xi == 2)) or (yi == -2 and (xi == 1 or xi == 2)) then
								-- SORRY NOTHING
							else
								local entity = get_entity(spawn_grid_entity(ENT_TYPE.FLOORSTYLED_STONE, x+xi, y+yi, l, 0, 0))
								entity.flags = set_flag(entity.flags, ENT_FLAG.SHOP_FLOOR)
							end
						end
					end
					spawn_entity(ENT_TYPE.ITEM_VAULTCHEST, x+1, y-2, l, 0, 0)
					spawn_entity(ENT_TYPE.ITEM_VAULTCHEST, x+2, y-2, l, 0, 0)
					local shopkeeper_uid = spawn_entity(ENT_TYPE.MONS_SHOPKEEPER, x+1, y-2, l, 0, 0)
					local shopkeeper = get_entity(shopkeeper_uid)
					
					if state.shoppie_aggro_next <= 0 then
						pick_up(shopkeeper_uid, spawn_entity(ENT_TYPE.ITEM_SHOTGUN, x+1, y-2, l, 0, 0))
					end
					shopkeeper.is_patrolling = true
					shopkeeper.move_state = 9
				end
			},
		},
		description = "Vault",
	},
	["~"] = {
		phase_1 = {
			default = {function(x, y, l) spawn_grid_entity(ENT_TYPE.FLOOR_SPRING_TRAP, x, y, l, 0, 0) end,},
		},
		description = "Bounce Trap",
	},
	["!"] = {
		-- one occasion in tutorial it's an arrow trap
		description = "Tutorial Controls Display",
	},
	["("] = {
		-- Had to create a new tile for Temple's obstacle tile because there were conflictions with "r" in Jungle.
		description = "Temple Obstacle Block",
	}
		-- description = "Unknown",
}


return module