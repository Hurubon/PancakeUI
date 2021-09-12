--[[---------------------------------------------------------------------------
        Settings
--]]---------------------------------------------------------------------------
local MINIMAP_SETTINGS = PnkUISettings.minimap;

MINIMAP_SETTINGS.zone_text_frame = MINIMAP_SETTINGS.zone_text_frame or {
        dimensions = {
                width  = 172,
                height = 18,
        },
        padding = {
                top    = 1,
                right  = 4,
                bottom = 1,
                left   = 4,
        },
        anchor = {
                point         = "TOP",
                relativePoint = "TOP",
        },

        backdrop = {
                bgFile  = PnkUISettings.bg_path .. "Solid.tga",
                bgColor = PnkUISettings.colors.UI,
        },

        colors = {
                default   = PnkUISettings.colors.textWhite,

                friendly  = PnkUISettings.colors.friendly,
                contested = PnkUISettings.colors.contested,
                hostile   = PnkUISettings.colors.hostile,
                sanctuary = PnkUISettings.colors.sanctuary,

                arena     = PnkUISettings.colors.hostile,
                combat    = PnkUISettings.colors.hostile,
        },
};

--[[---------------------------------------------------------------------------
        Adding component
--]]---------------------------------------------------------------------------
local zone_text_frame = PnkUI.AddComponent({
        widget_type = "Frame",
        global_name = "PnkUI_Minimap_ZoneTextFrame",
        parent      = PnkUI_Minimap,
        settings    = MINIMAP_SETTINGS.zone_text_frame,
});

if zone_text_frame then
        PnkUI.minimap.zone_text_frame = zone_text_frame;
else
        return;
end

--[[---------------------------------------------------------------------------
        Methods
--]]---------------------------------------------------------------------------
function zone_text_frame.AddZoneText(self)
        self.text = self:CreateFontString(nil, "ARTWORK");

        self.text:SetFontObject(PnkUISettings.fonts.normal);
        self.text:SetPoint("CENTER");
        self.text:SetJustifyH("CENTER");
        self.text:SetJustifyV("MIDDLE");
end

function zone_text_frame.HookZoneEvents(self)
        self:RegisterEvent("ZONE_CHANGED");
        self:RegisterEvent("ZONE_CHANGED_INDOORS");
        self:RegisterEvent("ZONE_CHANGED_NEW_AREA");

        self:SetScript("OnEvent", function(self)
                self:Update();
        end);
end

function zone_text_frame.Update(self)
        local padding  = MINIMAP_SETTINGS.zone_text_frame.padding;
        local backdrop = MINIMAP_SETTINGS.zone_text_frame.backdrop;
        local colors   = MINIMAP_SETTINGS.zone_text_frame.colors;

        local zone_text = GetMinimapZoneText();
        local zone_type = GetZonePVPInfo();

        local color = colors[zone_type] or colors.default;

        self.text:SetText(zone_text);
        self.text:SetTextColor(color());

        local width = self.text:GetStringWidth();
        self:SetWidth(width + (padding.left or 0) + (padding.right or 0));
end

zone_text_frame:AddZoneText();
zone_text_frame:HookZoneEvents();
zone_text_frame:Update();
