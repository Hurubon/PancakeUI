--[[---------------------------------------------------------------------------
        Settings
--]]---------------------------------------------------------------------------
PnkUISettings.minimap = PnkUISettings.minimap or {
        dimensions = {
                width  = 200,
                height = 200,
        },
        padding = {
                top    = 0,
                right  = 0,
                bottom = 0,
                left   = 0,
        },
        anchor = {
                point         = "TOPRIGHT",
                relativePoint = "TOPRIGHT",
        },
        backdrop = {
                edgeFile = PnkUISettings.edge_path .. "MinimapEdge.tga",
                edgeSize = 4,
                insets =
                {
                        top    = 4,
                        right  = 4,
                        bottom = 4,
                        left   = 4,
                },

                edgeColor = PnkUISettings.colors.UI,
        },

        sounds = {
                is_zoom_sound_enabled = true,
                zoom_in  = "igMiniMapZoomIn",
                zoom_out = "igMiniMapZoomOut",
        },

        enable_mouse_wheel = true,
};

--[[---------------------------------------------------------------------------
        Adding component
--]]---------------------------------------------------------------------------
local minimap = PnkUI.AddComponent({
        widget_type = "Frame",
        global_name = "PnkUI_Minimap",
        parent      = PnkUI,
        settings    = PnkUISettings.minimap,
});

if minimap then
        PnkUI.minimap = minimap;
else
        return;
end

--[[---------------------------------------------------------------------------
        Methods
--]]---------------------------------------------------------------------------
function minimap.HideBlizzardWidgets(self, settings)
        local widgets = {
                MinimapCluster,
                MinimapBackdrop,
                GameTimeFrame,
                TimeManagerClockButton,
        };

        for i, widget in ipairs(widgets) do
                widget.Show = function() end;
                widget:Hide();
        end

        Minimap:SetMaskTexture("Interface\\ChatFrame\\ChatFrameBackground");
end

function minimap.EmbedBlizzardMinimap(self)
        local dimensions = PnkUISettings.minimap.dimensions;
        local backdrop   = PnkUISettings.minimap.backdrop;

        Minimap:SetParent(self);
        Minimap:SetSize(
                dimensions.width  - 2 * backdrop.edgeSize,
                dimensions.height - 2 * backdrop.edgeSize
        );
        Minimap:SetPoint("CENTER");

        -- This is so that PnkUI_Minimap's children appear above the minimap.
        Minimap:SetFrameLevel(0);
end

function minimap.EnableScrollWheelZoom(self)
        local sounds = PnkUISettings.minimap.sounds;

        self:EnableMouseWheel(PnkUISettings.minimap.enable_mouse_wheel);
        self:SetScript("OnMouseWheel", function(self, direction)
                local zoom = Minimap:GetZoom();

                if zoom < Minimap:GetZoomLevels() and direction > 0 then
                        if sounds.is_zoom_sound_enabled then
                                PlaySound(sounds.zoom_in);
                        end
                        Minimap:SetZoom(zoom + 1)
                elseif zoom > 0 and direction < 0 then
                        if sounds.is_zoom_sound_enabled then
                                PlaySound(sounds.zoom_out);
                        end
                        Minimap:SetZoom(zoom - 1);
                end
        end)
end

---------------------------------- 「 Setup 」 ----------------------------------
minimap:HideBlizzardWidgets();
minimap:EmbedBlizzardMinimap();
minimap:EnableScrollWheelZoom();
