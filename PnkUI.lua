local TEXTURE_PATH = "Interface\\AddOns\\PancakeUI\\Textures\\";

PnkUISettings = PnkUISettings or {
        bg_path   = TEXTURE_PATH .. "Background\\",
        edge_path = TEXTURE_PATH .. "Edge\\",
        icon_path = TEXTURE_PATH .. "Icons\\",

        colors = {
                UI        = WowColor.FromHex("090909"),
                textWhite = WowColor.FromHex("FFFFFF"),

                friendly  = WowColor.FromHex("29CC3C"),
                contested = WowColor.FromHex("E65010"),
                hostile   = WowColor.FromHex("E6222F"),
                sanctuary = WowColor.FromHex("00E8FC"),
        },

        fonts = {
                normal = GameFontNormal,
        },
};

function PnkUI.AddComponent(component_data)
        if component_data.settings.is_disabled or not component_data.parent
        then
                return nil;
        end

        local component = CreateFrame(
                component_data.widget_type,
                component_data.global_name,
                component_data.parent,
                component_data.inherits
        );

        local dimensions = component_data.settings.dimensions;
        local padding    = component_data.settings.padding;
        local anchor     = component_data.settings.anchor;
        local backdrop   = component_data.settings.backdrop;

        component:SetSize(
                dimensions.width  + padding.left + padding.right,
                dimensions.height + padding.top  + padding.bottom
        );

        component:SetPoint(
                anchor.point,
                anchor.relativeTo or component:GetParent(),
                anchor.relativePoint,
                anchor.offset_x or 0,
                anchor.offset_y or 0
        );

        component:SetBackdrop(backdrop);

        if backdrop and backdrop.bgColor then
                component:SetBackdropColor(backdrop.bgColor());
        end

        if backdrop and backdrop.edgeColor then
                component:SetBackdropBorderColor(backdrop.edgeColor());
        end

        return component;
end
