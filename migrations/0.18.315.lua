require "scripts.common"


-- Edit generation settings on the lab to make it infinite
for _, surface in pairs(game.surfaces) do
    if IsLab(surface) then
        local surface = game.create_surface(labName, {
            width = 2*LabRadius*32, height = 2*LabRadius*32
        })
        
        surface.always_day = true
        surface.generate_with_lab_tiles = true

        ChunkLab(surface)
        tiles = {}
        for i = -LabRadius*32, LabRadius*32 - 1 do
            for j = -LabRadius*32, LabRadius*32 - 1 do
                if (i + j) % 2 == 0 then
                    table.insert(tiles, {name = "lab-dark-1", position = {i, j}})
                else
                    table.insert(tiles, {name = "lab-dark-2", position = {i, j}})
                end
            end
        end
        surface.set_tiles(tiles)
        EquipLab(surface, force)
        -- surface.map_gen_settings = {
    --     default_enable_all_autoplace_controls = false,
    --     cliff_settings = {
    --         cliff_elevation_0 = 1024,
    --     },
    -- }
    -- surface.generate_with_lab_tiles = true
    end
end
