--[[---------------------------------------------------------------------------
        Settings
--]]---------------------------------------------------------------------------
local MINIMAP_SETTINGS = PnkUISettings.minimap;

MINIMAP_SETTINGS.sidebar = MINIMAP_SETTINGS.sidebar or {
        dimensions = {
                width  = 24,
                height = 120,
        },
        padding = {
                top    = 2,
                right  = 2,
                bottom = 2,
                left   = 2,
        },
        anchor = {
                point         = "TOPRIGHT",
                relativePoint = "TOPLEFT",
                offset_x = PnkUISettings.minimap.backdrop.edgeSize,
        },
        backdrop = {
                bgFile   = PnkUISettings.bg_path .. "Solid.tga",
                edgeFile = PnkUISettings.edge_path .. "MinimapEdge.tga",
                edgeSize = 2,
                insets =
                {
                        top    = 2,
                        right  = 2,
                        bottom = 2,
                        left   = 2,
                },

                bgColor   = PnkUISettings.colors.UI,
                edgeColor = PnkUISettings.colors.UI,
        },
        buttons = {
                size    = 24,
                spacing = 1,
        },
};

--[[---------------------------------------------------------------------------
        Adding component
--]]---------------------------------------------------------------------------
local sidebar = PnkUI.AddComponent({
        widget_type = "Frame",
        global_name = "PnkUI_Minimap_Sidebar",
        parent      = PnkUI_Minimap,
        settings    = PnkUISettings.minimap.sidebar,
});

if sidebar then
        PnkUI.minimap.sidebar = sidebar;
else
        return;
end

--[[---------------------------------------------------------------------------
        Methods
--]]---------------------------------------------------------------------------
function sidebar.AddButton(self, button, index)
        local buttons = MINIMAP_SETTINGS.sidebar.buttons;

        button:SetSize(buttons.size, buttons.size);
        button:SetParent(self);

        if index then
                table.insert(self.buttons, index, button);
        else
                table.insert(self.buttons, button);
        end

        button:Show();
        self:Update();
end

function sidebar.RemoveButton(self, index)
        local button;

        if index then
                button = table.remove(self.buttons, index);
        else
                button = table.remove(self.buttons);
        end

        buttton:Hide();
        self:Update();
end

------------------------------ 「 Update method 」 ------------------------------
function sidebar.Update(self)
        local padding = MINIMAP_SETTINGS.sidebar.padding;
        local buttons = MINIMAP_SETTINGS.sidebar.buttons;

        if #self.buttons == 0 then
                self:SetHeight(0);
        else
                self:SetHeight(
                        buttons.size * #self.buttons
                        + buttons.spacing * (#self.buttons - 1)
                        + padding.top
                        + padding.bottom
                );
        end

        for i, button in ipairs(self.buttons) do
                local size    = buttons.size;
                local spacing = buttons.spacing;

                local y = (1 - i) * (size + spacing) - padding.top;

                button:SetPoint("TOP", 0, y);
        end
end

---------------------------------- 「 Setup 」 ----------------------------------
sidebar.buttons = {};
