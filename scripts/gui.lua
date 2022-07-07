require "logic"
require "init-lab"
local mod_gui = require("mod-gui")

function get_le_flow(player)
    local button_flow = mod_gui.get_button_flow(player)
    local flow = button_flow.le_flow
    if not flow then
        flow = button_flow.add {
            type = "flow",
            name = "le_flow",
            direction = "horizontal"
        }
    end
    return flow
end

function CreateGui(player_index)
    local player = game.players[player_index]
    local playerData = global[player_index]
    if player.gui.left["BPL_Flow"] then
        player.gui.left["BPL_Flow"].destroy()
    end
    playerData.flow = get_le_flow(player)
    if not playerData.flow.BPL_LabButton then
        playerData.button = playerData.flow.add {
            type = "sprite-button",
            name = "BPL_LabButton",
            sprite = "item/lab",
            tooltip = {"bpl.LabButtonTooltip"},
            style = mod_gui.button_style}
    end
    if not playerData.flow.BPL_ClearButton then
        playerData.clearButton = playerData.flow.add {
            type = "sprite-button",
            name = "BPL_ClearButton",
            caption = "×",
            sprite = "item/lab",
            tooltip = {"bpl.ClearButtonTooltip"},
            style = mod_gui.button_style}
        playerData.clearButton.style.font_color = {.5,0,0}
        playerData.clearButton.style.hovered_font_color = playerData.clearButton.style.font_color
        playerData.clearButton.style.font = "bluprintlab_cross"
    end
    UpdateGui(player_index)
end

function UpdateGui(player_index)
    local playerData = global[player_index]

    if playerData.inTheLab then
        playerData.button.visible = true
        playerData.clearButton.visible = true
    else
        if playerData.isUnlocked then
            playerData.button.visible = true
            playerData.clearButton.visible = false
        else
            playerData.button.visible = false
            playerData.clearButton.visible = false
        end
    end
end

function OnGuiClick(event)
    if event.element.name == "BPL_LabButton" then
        OnLabButton(event.player_index)
    elseif event.element.name == "BPL_StateButton" then
        WhereAmI(event.player_index)
    elseif event.element.name == "BPL_ClearButton" then
        ClearLab(event.player_index)
    end
end

function OnLabButtonHotkey(event)
    OnLabButton(event.player_index)
end