-- MyMod

local envy = mods["MGReturns-ENVY"]
envy.auto()
mods["RoRRModdingToolkit-RoRR_Modding_Toolkit"].auto()

PATH = _ENV["!plugins_mod_folder_path"]

local seed = 1 --EDIT TO SEED YOU WANT UNTIL MENU IS IMPLEMENTED

--gm.variable_global_set("game_seed", seed)

-- ========== Main ==========

local function initialize()
    -- Initialization of content goes here
    -- https://github.com/RoRRModdingToolkit/RoRR_Modding_Toolkit/wiki/Initialize
end
Initialize(initialize)

-- ** Uncomment the two lines below to re-call initialize() on hotload **
-- if hotload then initialize() end
-- hotload = true

gm.pre_script_hook(gm.constants.rng_create, function(self, other, result, args)
    print("rng_create")
    gm.random_set_seed(seed)
end)

gm.pre_script_hook(gm.constants.treasure_boss_roll, function(self, other, result, args)
    print("treasure_boss_roll")
    local tp = gm.instance_find(gm.constants.pTeleporter, 0)
    gm.random_set_seed(seed * tp.x + tp.y)
end)

gm.pre_script_hook(gm.constants.item_equipment_enigma_reroll, function(self, other, result, args)
    print("enigma_reroll")
    gm.random_set_seed(seed)
end)

gm.pre_script_hook(gm.constants.stage_roll_next, function(self, other, result, args)
    print("stage_roll")
    gm.random_set_seed(seed)
end)

gm.pre_script_hook(gm.constants.pickup_roll, function(self, other, result, args)
    print("pickup_roll")
    gm.random_set_seed(seed)
end)

gm.pre_script_hook(gm.constants.director_select_elite_type, function(self, other, result, args)
    print("select_elite_type")
    gm.random_set_seed(seed)
end)

gm.pre_script_hook(gm.constants.mapobject_spawn, function(self, other, result, args)
    print("spawn_mapobject")
    gm.random_set_seed(seed)
end)

gm.pre_script_hook(gm.constants.director_spawn_monster_card, function(self, other, result, args)
    print("spawn_monster")
    gm.random_set_seed(seed)
end)

gm.pre_script_hook(gm.constants.director_do_boss_spawn, function(self, other, result, args)
    print("do_boss_spawn")
    gm.random_set_seed(seed)
end)

gm.pre_script_hook(gm.constants.item_drop, function(self, other, result, args)
    print("item_drop")
    if self.x then
        gm.random_set_seed(seed * self.x + self.y)
    else
        gm.random_set_seed(seed)
    end
end)

gm.pre_script_hook(gm.constants.drop_gold_and_exp, function(self, other, result, args)
    print("gold_and_exp")
    if self.x then
        gm.random_set_seed(seed * self.x + self.y)
    else
        gm.random_set_seed(seed)
    end
end)

gm.post_script_hook(gm.constants.rng_random_seed, function(self, other, result, args)
    print("random_seed")
    if self.x then
        gm.random_set_seed(seed * self.x + self.y)
    else
        gm.random_set_seed(seed)
    end
end)

gm.pre_script_hook(gm.constants.treasure_loot_pool_roll, function(self,other,result,args)
    print("loot_rolled")
    Helper.log_hook(self, other, result, args)
    local tp = gm.instance_find(gm.constants.pTeleporter, 0)
    if gm.actor_is_boss(self) then
        gm.random_set_seed(seed * tp.x + tp.y)
    else
        if self.cost then
            gm.random_set_seed(seed * self.x + self.y * self.cost)
        else
        gm.random_set_seed(seed * self.x + self.y)
        end
    end

end)

gm.pre_script_hook(gm.constants.interactable_set_active, function(self,other,result,args)
    print("interactable_set_active")
    if self.cost then
        gm.random_set_seed(seed * self.x + self.y * self.cost)
    else
        gm.random_set_seed(seed * self.x + self.y)
    end
end)

gm.pre_script_hook(gm.constants.treasure_weights_roll_pickup, function(self, other, result, args)
    print("weight_roll_pickup")
    gm.random_set_seed(seed)
end)

gm.pre_script_hook(gm.constants.treasure_boss_clear, function(self, other, result, args)
    print("boss_clear_treasure")
    local tp = gm.instance_find(gm.constants.pTeleporter, 0)
    gm.random_set_seed(seed * tp.x + tp.y)
end)

Callback.add(Callback.TYPE.onGameStart, "SetStartingSeed", function()
    gm.varialbe_global_set("game_seed", seed)
end)

-- gm.post_script_hook(gm.constants.__input_system_tick, function(self, other, result, args)
--     -- This is an example of a hook
--     -- This hook in particular will run every frame after it has finished loading (i.e., "Hopoo Games" appears)
--     -- You can hook into any function in the game
--     -- Use pre_script_hook instead to run code before the function
--     -- https://github.com/return-of-modding/ReturnOfModding/blob/master/docs/lua/tables/gm.md
    
-- end)

-- memory.dynamic_hook_mid("gml_Script_treasure_loot_pool_roll", {"rdx", "[rbp+57h+18h]"}, {"RValue*", "CInstance*"}, 0,
--     gm.get_object_function_address("gml_Script_treasure_loot_pool_roll"):add(480), function(args)
--         Helper.log_hook(args)
--     end)