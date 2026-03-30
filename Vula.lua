--[[
╔══════════════════════════════════════════════════════════════════════════════╗
║  V U L A   L I B   ·   v6.0 Premium+ (Mobile/Delta Optimized)              ║
║  Advanced UI Library for Roblox Executors                                   ║
║  Mobile + Desktop  ·  32 Themes  ·  Fluid Animations  ·  Feature-Rich       ║
║  by Kyo  ·  100% standalone, paste & run                                    ║
║  Fixes: Proper Color Picker, Theme Switching, Multi‑Slot Config, Auto‑Save ║
╚══════════════════════════════════════════════════════════════════════════════╝
--]]

local Vula = { Flags = {}, Version = "6.0", Themes = {}, Events = {}, _autoSaveCoroutine = nil }
local _g   = type(getgenv) == "function" and getgenv() or {}
if _g.VulaLoaded then return _g.VulaLib end

-- ── Services ──────────────────────────────────────────────────────────────────
local TS  = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Run = game:GetService("RunService")
local LP  = game:GetService("Players").LocalPlayer
local HS  = game:GetService("HttpService")

-- ── Helper Functions (unchanged) ─────────────────────────────────────────────
local function safeP()
    local ok, pg = pcall(function() return LP:WaitForChild("PlayerGui", 5) end)
    return (ok and pg) or LP.PlayerGui
end

local function detectMobile()
    if UIS.TouchEnabled and not UIS.MouseEnabled then return true end
    local vp = workspace.CurrentCamera.ViewportSize
    return vp.X < 680
end

local function tw(obj, props, dur, style, dir)
    if not obj or not obj.Parent then return end
    TS:Create(obj, TweenInfo.new(dur or 0.26, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props):Play()
end

local function ni(cls, parent, props)
    local inst = Instance.new(cls)
    if props then
        for k, v in next, props do
            pcall(function() inst[k] = v end)
        end
    end
    if parent then inst.Parent = parent end
    return inst
end

local function C(p, r) return ni("UICorner", p, { CornerRadius = UDim.new(0, r or 8) }) end
local function St(p, c, t, tr)
    return ni("UIStroke", p, { Color = c, Thickness = t or 1, Transparency = tr or 0, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
end
local function Pd(p, l, r, t, b)
    ni("UIPadding", p, { PaddingLeft = UDim.new(0, l), PaddingRight = UDim.new(0, r), PaddingTop = UDim.new(0, t), PaddingBottom = UDim.new(0, b) })
end
local function LL(p, g, align)
    ni("UIListLayout", p, { FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = align or Enum.HorizontalAlignment.Left, Padding = UDim.new(0, g or 0), SortOrder = Enum.SortOrder.LayoutOrder })
end

local function hex(s)
    s = s:gsub("#", "")
    return Color3.fromRGB(tonumber(s:sub(1,2),16) or 0, tonumber(s:sub(3,4),16) or 0, tonumber(s:sub(5,6),16) or 0)
end
local function rt(t)
    local o = {}
    for k, v in next, t do o[k] = type(v) == "string" and hex(v) or v end
    return o
end
local function clamp(v, mn, mx) return math.max(mn, math.min(mx, v)) end
local function round(v, inc) return math.floor(v / inc + 0.5) * inc end

-- ═════════════════════════════════════════════════════════════════════════════
--  THEMES (32 total - 16 dark, 16 light)
-- ═════════════════════════════════════════════════════════════════════════════
Vula.Themes = {
    -- Dark (16)
    JJK = { Bg="060610", Top="0c0b1a", Side="09091a", Card="0f0e1e", CardH="16132a", Stroke="2c1828", Text="dce0f8", Dim="4a526e", SecLbl="c01a2e", Acc="c81c30", AccD="7a0c1c", TOn="c81c30", TOff="1c0e18", Knob="f5f5ff", TBOn="c81c30", TBOff="0d0c1c", TxtOn="ffffff", TxtOff="3a4262", Div="241420", InBg="08080e", Ph="38405a", Pill="0c0b1a", NBg="09091a", NInfo="4a90d9", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="1c0e1c", SliderFill="c81c30" },
    Default = { Bg="101010", Top="181818", Side="141414", Card="1c1c1c", CardH="242424", Stroke="2c2c2c", Text="e8e8e8", Dim="666666", SecLbl="4a90d9", Acc="4a90d9", AccD="2260a8", TOn="4a90d9", TOff="282828", Knob="f8f8f8", TBOn="4a90d9", TBOff="1c1c1c", TxtOn="ffffff", TxtOff="565656", Div="282828", InBg="121212", Ph="484848", Pill="1a1a1a", NBg="181818", NInfo="4a90d9", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="242424", SliderFill="4a90d9" },
    Midnight = { Bg="05060e", Top="090b1c", Side="07091a", Card="0c1026", CardH="121630", Stroke="1c2450", Text="c8d0ff", Dim="3e4a88", SecLbl="5c7aff", Acc="5c7aff", AccD="2c48d0", TOn="5c7aff", TOff="121828", Knob="eef0ff", TBOn="5c7aff", TBOff="0c1026", TxtOn="ffffff", TxtOff="384270", Div="182050", InBg="080a18", Ph="343c72", Pill="090b1c", NBg="090b1c", NInfo="5c7aff", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="182050", SliderFill="5c7aff" },
    Amethyst = { Bg="080510", Top="100c20", Side="0c0818", Card="140e24", CardH="1a122c", Stroke="3a2058", Text="dcd4ff", Dim="5a4490", SecLbl="9a58e8", Acc="9a58e8", AccD="5820a0", TOn="9a58e8", TOff="221438", Knob="ede8ff", TBOn="9a58e8", TBOff="140e24", TxtOn="ffffff", TxtOff="583c80", Div="2e1a4e", InBg="0a0818", Ph="4c3270", Pill="100c20", NBg="100c20", NInfo="9a58e8", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="2e1a4e", SliderFill="9a58e8" },
    Ocean = { Bg="040e12", Top="081820", Side="07141c", Card="0a1c28", CardH="10222e", Stroke="164050", Text="b8f0f2", Dim="387888", SecLbl="00b8c0", Acc="00b8c0", AccD="007080", TOn="00b8c0", TOff="0a2830", Knob="e0feff", TBOn="00b8c0", TBOff="0a1c28", TxtOn="ffffff", TxtOff="2c6880", Div="123650", InBg="060e14", Ph="285e6e", Pill="081820", NBg="081820", NInfo="00b8c0", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="123650", SliderFill="00b8c0" },
    Neon = { Bg="030303", Top="060606", Side="050505", Card="0a0a0a", CardH="101010", Stroke="1a3a1a", Text="ccffcc", Dim="3a7a3a", SecLbl="00ff88", Acc="00ff88", AccD="009950", TOn="00ff88", TOff="0a1a10", Knob="e0ffe8", TBOn="00ff88", TBOff="0a0a0a", TxtOn="000000", TxtOff="2a5a2a", Div="0a2a0a", InBg="060606", Ph="1a4a1a", Pill="060606", NBg="060606", NInfo="00ccff", NSucc="00ff88", NWarn="ffcc00", NErr="ff3344", SliderTrack="0a1a0a", SliderFill="00ff88" },
    Cyberpunk = { Bg="04040a", Top="080812", Side="060610", Card="0c0c16", CardH="12121e", Stroke="2a2a00", Text="f0f0c8", Dim="686840", SecLbl="e8e000", Acc="e8e000", AccD="909000", TOn="e8e000", TOff="202010", Knob="fffff0", TBOn="e8e000", TBOff="0c0c16", TxtOn="000000", TxtOff="5a5a30", Div="2a2a10", InBg="06060e", Ph="404020", Pill="080812", NBg="080812", NInfo="00d8f0", NSucc="00ff88", NWarn="e8e000", NErr="ff3344", SliderTrack="1c1c08", SliderFill="e8e000" },
    Void = { Bg="020203", Top="060508", Side="04040a", Card="08060e", CardH="0e0c18", Stroke="1e1430", Text="c8c0e8", Dim="3c3460", SecLbl="7c5cd8", Acc="7c5cd8", AccD="4c2c98", TOn="7c5cd8", TOff="140c24", Knob="e8e0ff", TBOn="7c5cd8", TBOff="08060e", TxtOn="ffffff", TxtOff="3c3460", Div="180c2e", InBg="040408", Ph="302858", Pill="060508", NBg="060508", NInfo="7c5cd8", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="180c2e", SliderFill="7c5cd8" },
    Bloodmoon = { Bg="0a0303", Top="140808", Side="0e0606", Card="1a0a0a", CardH="221212", Stroke="4a1818", Text="ffd8d8", Dim="8a5a5a", SecLbl="e84848", Acc="e84848", AccD="a82828", TOn="e84848", TOff="2a1212", Knob="fff0f0", TBOn="e84848", TBOff="1a0a0a", TxtOn="ffffff", TxtOff="8a5050", Div="421a1a", InBg="0a0404", Ph="6a3a3a", Pill="140808", NBg="140808", NInfo="e84848", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="2a1212", SliderFill="e84848" },
    Galaxy = { Bg="04020c", Top="0c0820", Side="080614", Card="100c24", CardH="181230", Stroke="282050", Text="e0ccff", Dim="6a58a0", SecLbl="b070f0", Acc="b070f0", AccD="7840c8", TOn="b070f0", TOff="201838", Knob="f5eaff", TBOn="b070f0", TBOff="100c24", TxtOn="ffffff", TxtOff="6a58a0", Div="2a1c48", InBg="080618", Ph="5848a0", Pill="0c0820", NBg="0c0820", NInfo="b070f0", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="2a1c48", SliderFill="b070f0" },
    Forest = { Bg="081008", Top="101c10", Side="0c140c", Card="142014", CardH="1c2c1c", Stroke="2c442c", Text="ccffcc", Dim="5a7a5a", SecLbl="6cc86c", Acc="6cc86c", AccD="3c843c", TOn="6cc86c", TOff="142814", Knob="f0fff0", TBOn="6cc86c", TBOff="142014", TxtOn="ffffff", TxtOff="5a7a5a", Div="2c442c", InBg="0a100a", Ph="4a684a", Pill="101c10", NBg="101c10", NInfo="6cc86c", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="2c442c", SliderFill="6cc86c" },
    Sunset = { Bg="180a0a", Top="2c1212", Side="220e0e", Card="341a1a", CardH="422222", Stroke="6a3a2a", Text="ffded0", Dim="a87868", SecLbl="ff8855", Acc="ff8855", AccD="c84828", TOn="ff8855", TOff="341818", Knob="fff0e8", TBOn="ff8855", TBOff="341a1a", TxtOn="ffffff", TxtOff="a87868", Div="5a3a2a", InBg="1a0c0c", Ph="8a5a48", Pill="2c1212", NBg="2c1212", NInfo="ff8855", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="5a3a2a", SliderFill="ff8855" },
    DeepSpace = { Bg="010108", Top="040410", Side="02020c", Card="080818", CardH="101020", Stroke="182040", Text="b8b8ff", Dim="50508c", SecLbl="3a6eff", Acc="3a6eff", AccD="1a3caa", TOn="3a6eff", TOff="101020", Knob="f0f0ff", TBOn="3a6eff", TBOff="080818", TxtOn="ffffff", TxtOff="50508c", Div="182040", InBg="04040c", Ph="3a4a7a", Pill="040410", NBg="040410", NInfo="3a6eff", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="182040", SliderFill="3a6eff" },
    CherryBlossom = { Bg="1a0a14", Top="2c1020", Side="220c18", Card="341424", CardH="441a30", Stroke="682848", Text="ffd8e8", Dim="a86c88", SecLbl="ff66aa", Acc="ff66aa", AccD="b83874", TOn="ff66aa", TOff="2e1422", Knob="fff0f5", TBOn="ff66aa", TBOff="341424", TxtOn="ffffff", TxtOff="a86c88", Div="602040", InBg="180810", Ph="8a5470", Pill="2c1020", NBg="2c1020", NInfo="ff66aa", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="602040", SliderFill="ff66aa" },
    MidnightBlue = { Bg="040816", Top="0a1020", Side="080c1c", Card="0e1428", CardH="161c34", Stroke="203058", Text="c8dcff", Dim="5a6a9a", SecLbl="4a7aff", Acc="4a7aff", AccD="1c44b0", TOn="4a7aff", TOff="121a30", Knob="f0f4ff", TBOn="4a7aff", TBOff="0e1428", TxtOn="ffffff", TxtOff="5a6a9a", Div="203058", InBg="060a18", Ph="3a4a7a", Pill="0a1020", NBg="0a1020", NInfo="4a7aff", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="203058", SliderFill="4a7aff" },
    Carbon = { Bg="0a0a0a", Top="121212", Side="0e0e0e", Card="161616", CardH="1e1e1e", Stroke="2a2a2a", Text="e0e0e0", Dim="6a6a6a", SecLbl="00aaff", Acc="00aaff", AccD="0077cc", TOn="00aaff", TOff="202020", Knob="f0f0f0", TBOn="00aaff", TBOff="161616", TxtOn="ffffff", TxtOff="5a5a5a", Div="2a2a2a", InBg="0c0c0c", Ph="4a4a4a", Pill="121212", NBg="121212", NInfo="00aaff", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444", SliderTrack="2a2a2a", SliderFill="00aaff" },
    -- Light (16)
    Light = { Bg="f2f2f6", Top="e6e6ec", Side="ebebf0", Card="fafafa", CardH="f0f0f8", Stroke="d0d0da", Text="18181e", Dim="8888a0", SecLbl="2870d8", Acc="2870d8", AccD="184fa0", TOn="2870d8", TOff="c4c4d4", Knob="ffffff", TBOn="2870d8", TBOff="f2f2f6", TxtOn="ffffff", TxtOff="9090a8", Div="d0d0da", InBg="e8e8ee", Ph="9898b0", Pill="e6e6ec", NBg="fafafa", NInfo="2870d8", NSucc="18a050", NWarn="d08010", NErr="d83020", SliderTrack="d0d0da", SliderFill="2870d8" },
    Cream = { Bg="fdf8f0", Top="f5ede0", Side="f0e8d8", Card="ffffff", CardH="fdf4e8", Stroke="e8d8c0", Text="2c2018", Dim="9a8070", SecLbl="b86020", Acc="d47820", AccD="9a5010", TOn="d47820", TOff="e8d0b0", Knob="ffffff", TBOn="d47820", TBOff="fdf8f0", TxtOn="ffffff", TxtOff="a89080", Div="e8d8c0", InBg="f5ede0", Ph="b09880", Pill="f5ede0", NBg="ffffff", NInfo="5890d8", NSucc="28a858", NWarn="d47820", NErr="c83030", SliderTrack="e8d8c0", SliderFill="d47820" },
    Lavender = { Bg="f4f0fa", Top="ebe4f8", Side="ede6f8", Card="ffffff", CardH="f0eaff", Stroke="d8ceee", Text="201838", Dim="8878b0", SecLbl="7050d8", Acc="7050d8", AccD="4828a8", TOn="7050d8", TOff="d0c8ec", Knob="ffffff", TBOn="7050d8", TBOff="f4f0fa", TxtOn="ffffff", TxtOff="9888c0", Div="d8ceee", InBg="ebe4f8", Ph="a898c8", Pill="ebe4f8", NBg="ffffff", NInfo="5080e0", NSucc="28a858", NWarn="c88020", NErr="d03030", SliderTrack="d8ceee", SliderFill="7050d8" },
    Mint = { Bg="f0faf6", Top="e0f4ec", Side="e4f6ee", Card="ffffff", CardH="e8fff4", Stroke="c0e8d4", Text="102820", Dim="6a9880", SecLbl="189868", Acc="189868", AccD="0c7048", TOn="189868", TOff="b8e0d0", Knob="ffffff", TBOn="189868", TBOff="f0faf6", TxtOn="ffffff", TxtOff="7aaa90", Div="c0e8d4", InBg="e0f4ec", Ph="90c0a8", Pill="e0f4ec", NBg="ffffff", NInfo="2890d8", NSucc="189868", NWarn="c88020", NErr="d03030", SliderTrack="c0e8d4", SliderFill="189868" },
    Sakura = { Bg="fff0f5", Top="ffe4f0", Side="ffe8f2", Card="ffffff", CardH="fff0f8", Stroke="f0c8dc", Text="381828", Dim="b07890", SecLbl="e84890", Acc="e84890", AccD="b83068", TOn="e84890", TOff="f0c8dc", Knob="ffffff", TBOn="e84890", TBOff="fff0f5", TxtOn="ffffff", TxtOff="b07890", Div="f0c8dc", InBg="ffe4f0", Ph="c890a8", Pill="ffe4f0", NBg="ffffff", NInfo="e84890", NSucc="28a858", NWarn="c88028", NErr="d03030", SliderTrack="f0c8dc", SliderFill="e84890" },
    Slate = { Bg="f0f4f8", Top="e4eaf0", Side="e8eef4", Card="ffffff", CardH="edf2f8", Stroke="c8d4e0", Text="182030", Dim="7888a0", SecLbl="3868b8", Acc="3868b8", AccD="1c4888", TOn="3868b8", TOff="c0cedd", Knob="ffffff", TBOn="3868b8", TBOff="f0f4f8", TxtOn="ffffff", TxtOff="8898b0", Div="c8d4e0", InBg="e4eaf0", Ph="9aaabb", Pill="e4eaf0", NBg="ffffff", NInfo="3868b8", NSucc="28a858", NWarn="c88020", NErr="d03030", SliderTrack="c8d4e0", SliderFill="3868b8" },
    RoseGold = { Bg="fdf0f0", Top="f8e4e4", Side="f5e6e6", Card="ffffff", CardH="fdeaea", Stroke="ecc8c8", Text="300c0c", Dim="b08888", SecLbl="c84860", Acc="c84860", AccD="902030", TOn="c84860", TOff="ecc0c8", Knob="ffffff", TBOn="c84860", TBOff="fdf0f0", TxtOn="ffffff", TxtOff="c09898", Div="ecc8c8", InBg="f8e4e4", Ph="c0a0a0", Pill="f8e4e4", NBg="ffffff", NInfo="5080c8", NSucc="289858", NWarn="c88028", NErr="d03030", SliderTrack="ecc8c8", SliderFill="c84860" },
    Paper = { Bg="f8f6f0", Top="ede8dc", Side="e8e2d4", Card="fffef8", CardH="f0edde", Stroke="d8d0b8", Text="1e1810", Dim="907860", SecLbl="4a3018", Acc="6a4820", AccD="3e2808", TOn="6a4820", TOff="d8cdb0", Knob="fffef8", TBOn="6a4820", TBOff="f8f6f0", TxtOn="fffef8", TxtOff="a09070", Div="d0c8a8", InBg="ede8dc", Ph="a09070", Pill="ede8dc", NBg="fffef8", NInfo="3a6088", NSucc="28a050", NWarn="c87820", NErr="c82820", SliderTrack="d8d0b8", SliderFill="6a4820" },
    Ice = { Bg="f0f8ff", Top="e0f0fc", Side="e4f4ff", Card="ffffff", CardH="eaf8ff", Stroke="b8d8f0", Text="0a1828", Dim="6090b8", SecLbl="0880c8", Acc="0880c8", AccD="0458a0", TOn="0880c8", TOff="b0d8f0", Knob="ffffff", TBOn="0880c8", TBOff="f0f8ff", TxtOn="ffffff", TxtOff="70a8c8", Div="b8d8f0", InBg="e0f0fc", Ph="88b8d8", Pill="e0f0fc", NBg="ffffff", NInfo="0880c8", NSucc="18a858", NWarn="c88020", NErr="d03020", SliderTrack="b8d8f0", SliderFill="0880c8" },
    Honey = { Bg="fef7e0", Top="faf0c8", Side="fcf4d8", Card="fffff0", CardH="fffae8", Stroke="f0d8a8", Text="382810", Dim="b09060", SecLbl="c88020", Acc="e8a020", AccD="b87010", TOn="e8a020", TOff="f8e0b0", Knob="ffffff", TBOn="e8a020", TBOff="fef7e0", TxtOn="ffffff", TxtOff="b09060", Div="f0d8a8", InBg="faf0c8", Ph="c8a870", Pill="faf0c8", NBg="fffff0", NInfo="4080c0", NSucc="28a858", NWarn="e8a020", NErr="d83030", SliderTrack="f0d8a8", SliderFill="e8a020" },
    Coral = { Bg="fff4f0", Top="ffe8e0", Side="ffece4", Card="ffffff", CardH="fff4ec", Stroke="f0c8b8", Text="382018", Dim="c08870", SecLbl="ff6a44", Acc="ff6a44", AccD="d84220", TOn="ff6a44", TOff="f8d0c0", Knob="ffffff", TBOn="ff6a44", TBOff="fff4f0", TxtOn="ffffff", TxtOff="c08870", Div="f0c8b8", InBg="ffe8e0", Ph="d0a088", Pill="ffe8e0", NBg="ffffff", NInfo="4080c8", NSucc="28a858", NWarn="ffaa44", NErr="e84838", SliderTrack="f0c8b8", SliderFill="ff6a44" },
    Aqua = { Bg="e8f8fc", Top="d8f0f8", Side="e0f4fc", Card="ffffff", CardH="f0fcff", Stroke="b8e0ec", Text="103038", Dim="508890", SecLbl="20b8c8", Acc="20b8c8", AccD="108090", TOn="20b8c8", TOff="c0e8f0", Knob="ffffff", TBOn="20b8c8", TBOff="e8f8fc", TxtOn="ffffff", TxtOff="508890", Div="b8e0ec", InBg="d8f0f8", Ph="80b0c0", Pill="d8f0f8", NBg="ffffff", NInfo="20b8c8", NSucc="28a858", NWarn="d08820", NErr="d83828", SliderTrack="b8e0ec", SliderFill="20b8c8" },
    Champagne = { Bg="fdf7ef", Top="f8f0e4", Side="faf2e8", Card="ffffff", CardH="fffaf0", Stroke="e8d8c8", Text="2c241c", Dim="a89078", SecLbl="c8a050", Acc="d4b06c", AccD="a0783c", TOn="d4b06c", TOff="f0e0d0", Knob="ffffff", TBOn="d4b06c", TBOff="fdf7ef", TxtOn="ffffff", TxtOff="a89078", Div="e8d8c8", InBg="f8f0e4", Ph="c0a880", Pill="f8f0e4", NBg="ffffff", NInfo="6088c0", NSucc="389860", NWarn="d48c28", NErr="c84838", SliderTrack="e8d8c8", SliderFill="d4b06c" },
    Spring = { Bg="f0fce8", Top="e0f8d8", Side="e8fce0", Card="ffffff", CardH="f8fff0", Stroke="c8e0b8", Text="203018", Dim="709050", SecLbl="68b830", Acc="68b830", AccD="408818", TOn="68b830", TOff="e0f0d0", Knob="ffffff", TBOn="68b830", TBOff="f0fce8", TxtOn="ffffff", TxtOff="709050", Div="c8e0b8", InBg="e0f8d8", Ph="90b070", Pill="e0f8d8", NBg="ffffff", NInfo="4088c8", NSucc="68b830", NWarn="d08830", NErr="d84838", SliderTrack="c8e0b8", SliderFill="68b830" },
    LavenderMist = { Bg="f8f4ff", Top="f0e8fc", Side="f4ecfe", Card="ffffff", CardH="fcf8ff", Stroke="e0d4f0", Text="282040", Dim="9088b0", SecLbl="8868e0", Acc="8868e0", AccD="5840b0", TOn="8868e0", TOff="e8dcf8", Knob="ffffff", TBOn="8868e0", TBOff="f8f4ff", TxtOn="ffffff", TxtOff="9088b0", Div="e0d4f0", InBg="f0e8fc", Ph="b0a0d0", Pill="f0e8fc", NBg="ffffff", NInfo="8868e0", NSucc="28a858", NWarn="d88830", NErr="d84840", SliderTrack="e0d4f0", SliderFill="8868e0" },
    Peach = { Bg="fff8f0", Top="fff0e4", Side="fff4e8", Card="ffffff", CardH="fffcf0", Stroke="f0e0d0", Text="382818", Dim="c09878", SecLbl="ffaa66", Acc="ffaa66", AccD="d87038", TOn="ffaa66", TOff="ffe8d8", Knob="ffffff", TBOn="ffaa66", TBOff="fff8f0", TxtOn="ffffff", TxtOff="c09878", Div="f0e0d0", InBg="fff0e4", Ph="e0b898", Pill="fff0e4", NBg="ffffff", NInfo="4080c8", NSucc="28a858", NWarn="ffaa66", NErr="e85848", SliderTrack="f0e0d0", SliderFill="ffaa66" },
    Arctic = { Bg="f0fcff", Top="e0f4fc", Side="e8f8fe", Card="ffffff", CardH="f8ffff", Stroke="c8e4f0", Text="103848", Dim="6088a0", SecLbl="30b8e0", Acc="30b8e0", AccD="1080a8", TOn="30b8e0", TOff="d0e8f0", Knob="ffffff", TBOn="30b8e0", TBOff="f0fcff", TxtOn="ffffff", TxtOff="6088a0", Div="c8e4f0", InBg="e0f4fc", Ph="90b0c8", Pill="e0f4fc", NBg="ffffff", NInfo="30b8e0", NSucc="28a858", NWarn="d08830", NErr="d84838", SliderTrack="c8e4f0", SliderFill="30b8e0" },
}
-- Backward compatibility
Vula.Theme = Vula.Themes

-- ═════════════════════════════════════════════════════════════════════════════
--  NOTIFICATION SYSTEM (unchanged, but we'll keep it)
-- ═════════════════════════════════════════════════════════════════════════════
local _nsg, _nst = nil, {}
local NOTIFY_ICON = { info = "●", success = "✓", warn = "▲", error = "✕", loading = "◌" }
local NOTIFY_COL  = { info = "NInfo", success = "NSucc", warn = "NWarn", error = "NErr", loading = "NInfo" }

local function getNSG()
    if _nsg and _nsg.Parent then return _nsg end
    _nsg = ni("ScreenGui", safeP(), { Name = "VulaNotifs", DisplayOrder = 200, ResetOnSpawn = false })
    return _nsg
end

local function repackNotifs()
    local vpH = workspace.CurrentCamera.ViewportSize.Y
    local NH, NG = 52, 5
    for i, f in ipairs(_nst) do
        if f and f.Parent then
            tw(f, { Position = UDim2.new(1, -8, 1 - (i * (NH + NG)) / vpH, 0) }, 0.35, Enum.EasingStyle.Back)
        end
    end
end

function Vula:Notify(opts)
    local title = opts.Title or "Vula"
    local content = opts.Content or ""
    local dur = opts.Duration or 4
    local typ = opts.Type or "info"
    local th = self._theme or rt(Vula.Themes.Default)
    local nCol = th[NOTIFY_COL[typ] or "NInfo"] or th.Acc
    local mob = detectMobile()
    local nW = mob and 300 or 240
    local nH = mob and 66 or 52

    if #_nst >= 5 then
        local old = table.remove(_nst, 1)
        if old and old.Parent then old:Destroy() end
    end

    local idx = #_nst + 1
    local vpH = workspace.CurrentCamera.ViewportSize.Y
    local posY = 1 - idx * (nH + 5) / vpH

    local f = ni("Frame", getNSG(), {
        Size = UDim2.new(0, nW, 0, nH), AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1.12, 0, posY, 0), BackgroundColor3 = th.NBg, ZIndex = 200
    })
    C(f, 14)
    St(f, th.Stroke, 1, 0.08)

    local topBar = ni("Frame", f, { Size = UDim2.new(1, 0, 0, 2), BackgroundColor3 = nCol, ZIndex = 202 })
    C(topBar, 12)

    local strip = ni("Frame", f, { Size = UDim2.new(0, mob and 4 or 3, 0.6, 0), Position = UDim2.new(0, mob and 12 or 10, 0.2, 0), BackgroundColor3 = nCol, ZIndex = 202 })
    C(strip, 2)

    local icoSz = mob and 28 or 20
    local iconCircle = ni("Frame", f, { Size = UDim2.new(0, icoSz, 0, icoSz), Position = UDim2.new(0, mob and 22 or 17, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = nCol, BackgroundTransparency = 0.80, ZIndex = 202 })
    C(iconCircle, icoSz // 2)
    ni("TextLabel", iconCircle, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = NOTIFY_ICON[typ] or "●", TextColor3 = nCol, Font = Enum.Font.GothamBold, TextSize = mob and 13 or 9, ZIndex = 203 })

    local txtOff = mob and 58 or 44
    local titleLbl = ni("TextLabel", f, { Size = UDim2.new(1, -(txtOff + 10), 0, mob and 20 or 16), Position = UDim2.new(0, txtOff, 0, mob and 11 or 9), BackgroundTransparency = 1, Text = title, TextColor3 = th.Text, Font = Enum.Font.GothamBold, TextSize = mob and 13 or 11, TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 1, ZIndex = 202 })
    local bodyLbl = ni("TextLabel", f, { Size = UDim2.new(1, -(txtOff + 10), 0, mob and 18 or 14), Position = UDim2.new(0, txtOff, 0, mob and 33 or 27), BackgroundTransparency = 1, Text = content, TextColor3 = th.Dim, Font = Enum.Font.GothamMedium, TextSize = mob and 11 or 9, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, TextTransparency = 1, ZIndex = 202 })

    local timerBg = ni("Frame", f, { Size = UDim2.new(1, -20, 0, 2), Position = UDim2.new(0, 10, 1, -2), AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = th.Div, ZIndex = 202 })
    C(timerBg, 1)
    local timerFill = ni("Frame", timerBg, { Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = nCol, ZIndex = 203 })
    C(timerFill, 1)

    _nst[idx] = f

    tw(f, { Position = UDim2.new(1, -8, posY, 0) }, 0.42, Enum.EasingStyle.Back)
    task.delay(0.07, function()
        tw(titleLbl, { TextTransparency = 0 }, 0.18)
        tw(bodyLbl, { TextTransparency = 0.2 }, 0.18)
    end)
    task.delay(0.14, function()
        if timerFill.Parent then
            tw(timerFill, { Size = UDim2.new(0, 0, 1, 0) }, dur - 0.14, Enum.EasingStyle.Linear)
        end
    end)

    local dismissed = false
    local function dismiss()
        if dismissed then return end
        dismissed = true
        tw(titleLbl, { TextTransparency = 1 }, 0.14)
        tw(bodyLbl, { TextTransparency = 1 }, 0.14)
        tw(f, { BackgroundTransparency = 1, Position = UDim2.new(1.12, 0, posY, 0) }, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        task.delay(0.26, function()
            for i, n in ipairs(_nst) do if n == f then table.remove(_nst, i); break end end
            if f.Parent then f:Destroy() end
            repackNotifs()
        end)
    end

    local hitBtn = ni("TextButton", f, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "", ZIndex = 210, AutoButtonColor = false })
    hitBtn.MouseButton1Click:Connect(dismiss)
    task.delay(dur, dismiss)
    repackNotifs()
end

-- ═════════════════════════════════════════════════════════════════════════════
--  CONFIG (Multi‑slot, Auto‑save, with fallback)
-- ═════════════════════════════════════════════════════════════════════════════
local CFG_FOLDER = "vula_configs"
local CFG_ACTIVE = CFG_FOLDER .. "/active.json"

-- Helper: attempt to write file using various executors
local function writeFile(path, content)
    local success = false
    if writefile then
        success = pcall(writefile, path, content)
    end
    if not success and syn and syn.writefile then
        success = pcall(syn.writefile, path, content)
    end
    if not success and secure and secure.writefile then
        success = pcall(secure.writefile, path, content)
    end
    return success
end

local function readFile(path)
    local content = nil
    if readfile then
        content = pcall(readfile, path) and readfile(path) or nil
    end
    if not content and syn and syn.readfile then
        content = pcall(syn.readfile, path) and syn.readfile(path) or nil
    end
    if not content and secure and secure.readfile then
        content = pcall(secure.readfile, path) and secure.readfile(path) or nil
    end
    return content
end

function Vula:SaveConfig(slotName)
    slotName = slotName or "default"
    local data = {}
    for k, v in next, self.Flags do
        if type(v) == "table" then
            if v.Type == "Toggle" then data[k] = v.CurrentValue
            elseif v.Type == "Dropdown" then data[k] = v:GetSelected()
            elseif v.Type == "Keybind" then data[k] = v.CurrentKeybind
            elseif v.Type == "Slider" then data[k] = v:Get()
            elseif v.Type == "Input" then data[k] = v:Get()
            elseif v.Type == "ColorPicker" then data[k] = v:GetHex()
            end
        end
    end
    local ok, enc = pcall(function() return HS:JSONEncode(data) end)
    if ok and enc then
        local path = CFG_FOLDER .. "/" .. slotName .. ".json"
        if writeFile(path, enc) then
            self:Notify({ Title = "Config", Content = "Saved '" .. slotName .. "'.", Duration = 2.5, Type = "success" })
            return true
        end
    end
    self:Notify({ Title = "Config", Content = "Save failed (no file access).", Duration = 2.5, Type = "error" })
    return false
end

function Vula:LoadConfig(slotName)
    slotName = slotName or "default"
    local path = CFG_FOLDER .. "/" .. slotName .. ".json"
    local raw = readFile(path)
    if not raw then
        self:Notify({ Title = "Config", Content = "Slot '" .. slotName .. "' not found.", Duration = 2.5, Type = "warn" })
        return false
    end
    local ok2, data = pcall(function() return HS:JSONDecode(raw) end)
    if not ok2 or type(data) ~= "table" then
        self:Notify({ Title = "Config", Content = "Corrupted file.", Duration = 2.5, Type = "error" })
        return false
    end
    for k, v in next, data do
        local flag = self.Flags[k]
        if flag and type(flag) == "table" then
            if flag.Type == "Toggle" then flag:Set(v)
            elseif flag.Type == "Dropdown" then flag:SetSelected(type(v) == "table" and v or {v})
            elseif flag.Type == "Keybind" then flag:Set(v)
            elseif flag.Type == "Slider" then flag:Set(v)
            elseif flag.Type == "Input" then flag:Set(v)
            elseif flag.Type == "ColorPicker" then flag:SetHex(v)
            end
        end
    end
    self:Notify({ Title = "Config", Content = "Loaded '" .. slotName .. "'.", Duration = 2.5, Type = "success" })
    return true
end

-- Auto‑save management
local autoSaveActive = false
function Vula:AutoSave(interval)
    if autoSaveActive then return end
    autoSaveActive = true
    task.spawn(function()
        while autoSaveActive and self._window and self._window.Parent do
            task.wait(interval or 60)
            if self._window and self._window.Parent then
                self:SaveConfig("autosave")
            end
        end
    end)
end

function Vula:StopAutoSave()
    autoSaveActive = false
end

-- ═════════════════════════════════════════════════════════════════════════════
--  CREATE WINDOW (Enhanced with proper theming and color picker)
-- ═════════════════════════════════════════════════════════════════════════════
function Vula:CreateWindow(opts)
    local title = opts.Name or "Vula"
    local loadT = opts.LoadingTitle or title
    local loadS = opts.LoadingSubtitle or "Loading..."
    local themeName = opts.Theme or "Default"
    local th = rt(Vula.Themes[themeName] or Vula.Themes.Default)
    self._theme = th

    local mob = detectMobile()
    local vp = workspace.CurrentCamera.ViewportSize
    local WW = mob and math.min(360, vp.X - 10) or 380
    local WH = opts.Height or (mob and math.min(340, vp.Y - 60) or 320)
    local TOP_H = mob and 44 or 38
    local SIDE_W = mob and 110 or 110
    local TAB_H_BTN = mob and 38 or 32
    local FONT_SM = mob and 11 or 9
    local FONT_MD = mob and 12 or 10
    local FONT_HDR = mob and 14 or 12

    local par = safeP()
    pcall(function()
        for _, c in ipairs(par:GetChildren()) do
            if c.Name == "Vula" then c:Destroy() end
        end
    end)

    local sg = ni("ScreenGui", par, { Name = "Vula", DisplayOrder = 100, ResetOnSpawn = false })
    local shadow = ni("Frame", sg, { Size = UDim2.new(0, WW + 12, 0, WH + 12), Position = UDim2.new(0.5, 3, 0.5, -35), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.new(0,0,0), BackgroundTransparency = 0.62, ZIndex = 1 })
    C(shadow, 18)

    local Main = ni("Frame", sg, { Name = "Main", Size = UDim2.new(0, WW, 0, WH), Position = UDim2.new(0.5, 4, 0.5, -38), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = th.Bg, ZIndex = 2, ClipsDescendants = true })
    C(Main, 14)
    St(Main, th.Stroke, 1, 0.14)

    local TB = ni("Frame", Main, { Size = UDim2.new(1, 0, 0, TOP_H), BackgroundColor3 = th.Top, ZIndex = 5 })
    C(TB, 14)
    ni("Frame", TB, { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 1, -14), BackgroundColor3 = th.Top, ZIndex = 4 })
    ni("Frame", TB, { Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = th.Acc, BackgroundTransparency = 0.04, ZIndex = 8 })
    ni("Frame", TB, { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1), BackgroundColor3 = th.Div, BackgroundTransparency = 0.25, ZIndex = 6 })

    local badge = ni("Frame", TB, { Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(0, 10, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = th.Acc, ZIndex = 6 })
    C(badge, 11)
    ni("UIGradient", badge, { Rotation = 135, ColorSequence = ColorSequence.new(th.Acc, th.AccD) })
    ni("TextLabel", badge, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "V", TextColor3 = Color3.new(1,1,1), Font = Enum.Font.GothamBold, TextSize = 11, ZIndex = 7 })

    ni("TextLabel", TB, { Size = UDim2.new(1, -110, 0, 18), Position = UDim2.new(0, 37, 0, math.floor((TOP_H - 28) * 0.35)), BackgroundTransparency = 1, Text = title, TextColor3 = th.Text, Font = Enum.Font.GothamBold, TextSize = FONT_HDR, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
    local subLbl = ni("TextLabel", TB, { Size = UDim2.new(1, -110, 0, 11), Position = UDim2.new(0, 37, 0, math.floor((TOP_H - 28) * 0.35) + 18), BackgroundTransparency = 1, Text = "v6.0 · " .. themeName, TextColor3 = th.Dim, Font = Enum.Font.GothamMedium, TextSize = 8, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })

    local function makeOrb(xOff, col, sym)
        local orb = ni("TextButton", TB, { Size = UDim2.new(0, 12, 0, 12), Position = UDim2.new(1, xOff, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = col, BackgroundTransparency = 0.06, Text = "", ZIndex = 7, AutoButtonColor = false })
        C(orb, 6)
        local sym_lbl = ni("TextLabel", orb, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = sym, TextColor3 = Color3.fromRGB(25,15,15), Font = Enum.Font.GothamBold, TextSize = 7, TextTransparency = 1, ZIndex = 8 })
        orb.MouseEnter:Connect(function()
            tw(orb, { BackgroundTransparency = 0 }, 0.1)
            tw(sym_lbl, { TextTransparency = 0 }, 0.1)
        end)
        orb.MouseLeave:Connect(function()
            tw(orb, { BackgroundTransparency = 0.06 }, 0.1)
            tw(sym_lbl, { TextTransparency = 1 }, 0.1)
        end)
        return orb
    end
    local oClose = makeOrb(-10, Color3.fromRGB(255,59,48), "✕")
    local oMin = makeOrb(-26, Color3.fromRGB(255,149,0), "–")

    -- Dragging
    do
        local dragging, dsx, dsy, ox, oy = false, 0, 0, 0, 0
        TB.InputBegan:Connect(function(i, gpe)
            if gpe then return end
            if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
            dragging = true
            local m = UIS:GetMouseLocation()
            dsx, dsy = m.X, m.Y
            ox, oy = Main.Position.X.Offset, Main.Position.Y.Offset
            local conn; conn = Run.RenderStepped:Connect(function()
                if not dragging then conn:Disconnect(); return end
                local m2 = UIS:GetMouseLocation()
                Main.Position = UDim2.new(0.5, ox + (m2.X - dsx), 0.5, oy + (m2.Y - dsy))
                shadow.Position = UDim2.new(0.5, ox + (m2.X - dsx) + 4, 0.5, oy + (m2.Y - dsy) + 7)
            end)
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    -- Sidebar
    local SB = ni("Frame", Main, { Size = UDim2.new(0, SIDE_W, 1, -TOP_H), Position = UDim2.new(0, 0, 0, TOP_H), BackgroundColor3 = th.Side, ZIndex = 4 })
    ni("Frame", SB, { Size = UDim2.new(0, 1, 1, 0), Position = UDim2.new(1, -1, 0, 0), BackgroundColor3 = th.Div, BackgroundTransparency = 0.22, ZIndex = 5 })
    local tabSF = ni("ScrollingFrame", SB, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 0, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(0,0,0,0), ZIndex = 5 })
    LL(tabSF, 3)
    Pd(tabSF, 6, 4, 8, 6)

    local Cont = ni("Frame", Main, { Size = UDim2.new(1, -SIDE_W, 1, -TOP_H), Position = UDim2.new(0, SIDE_W, 0, TOP_H), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 3 })
    local transOverlay = ni("Frame", Cont, { Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = th.Bg, BackgroundTransparency = 1, ZIndex = 50 })

    -- Loading Screen
    local LD = ni("Frame", Main, { Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = th.Bg, ZIndex = 25 })
    C(LD, 14)
    local spinRing = ni("Frame", LD, { Size = UDim2.new(0, 50, 0, 50), Position = UDim2.new(0.5, 0, 0.32, 0), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ZIndex = 26 })
    local spinArc = ni("Frame", spinRing, { Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = th.Acc, BackgroundTransparency = 0.5, ZIndex = 26 })
    C(spinArc, 25)
    St(spinArc, th.Acc, 2, 0.1)
    local ldb = ni("Frame", spinRing, { Size = UDim2.new(0, 34, 0, 34), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = th.Acc, ZIndex = 27 })
    C(ldb, 17)
    ni("UIGradient", ldb, { Rotation = 135, ColorSequence = ColorSequence.new(th.Acc, th.AccD) })
    ni("TextLabel", ldb, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "V", TextColor3 = Color3.new(1,1,1), Font = Enum.Font.GothamBold, TextSize = 16, ZIndex = 28 })
    ni("TextLabel", LD, { Size = UDim2.new(0.88, 0, 0, 18), Position = UDim2.new(0.06, 0, 0.48, 0), BackgroundTransparency = 1, Text = loadT, TextColor3 = th.Text, Font = Enum.Font.GothamBold, TextSize = 12, ZIndex = 26 })
    ni("TextLabel", LD, { Size = UDim2.new(0.88, 0, 0, 14), Position = UDim2.new(0.06, 0, 0.60, 0), BackgroundTransparency = 1, Text = loadS, TextColor3 = th.Dim, Font = Enum.Font.GothamMedium, TextSize = 9, ZIndex = 26 })
    local lBarBg = ni("Frame", LD, { Size = UDim2.new(0.62, 0, 0, 2), Position = UDim2.new(0.19, 0, 0.72, 0), BackgroundColor3 = th.Div, ZIndex = 26 })
    C(lBarBg, 1)
    local lBarFill = ni("Frame", lBarBg, { Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = th.Acc, ZIndex = 27 })
    C(lBarFill, 1)

    task.spawn(function()
        local t0 = tick()
        local conn2; conn2 = Run.Heartbeat:Connect(function()
            if not spinRing.Parent then conn2:Disconnect(); return end
            spinRing.Rotation = (tick() - t0) * 180
        end)
        tw(lBarFill, { Size = UDim2.new(1, 0, 1, 0) }, 1.4, Enum.EasingStyle.Quint)
        task.wait(1.6)
        conn2:Disconnect()
        tw(LD, { BackgroundTransparency = 1 }, 0.30)
        task.wait(0.34)
        if LD and LD.Parent then LD:Destroy() end
    end)

    -- Side Tab (Toggle)
    local PT_W, PT_H = 22, 88
    local SideTab = ni("Frame", sg, { Size = UDim2.new(0, PT_W, 0, PT_H), Position = UDim2.new(1, 0, 0.5, -PT_H/2), AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = th.Pill, ZIndex = 55 })
    C(SideTab, PT_W//2)
    St(SideTab, th.Acc, 1, 0.12)
    ni("UIGradient", SideTab, { Rotation = 0, ColorSequence = ColorSequence.new(th.Acc, th.Pill), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0,0.82), NumberSequenceKeypoint.new(1,0.95) }) })
    local tabBar = ni("Frame", SideTab, { Size = UDim2.new(0, 2, 0.5, 0), Position = UDim2.new(0, 4, 0.25, 0), BackgroundColor3 = th.Acc, BackgroundTransparency = 0.1, ZIndex = 57 })
    C(tabBar, 1)
    local pillDot = ni("Frame", SideTab, { Size = UDim2.new(0, 6, 0, 6), Position = UDim2.new(0.5, 0, 0, 8), AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = th.Acc, BackgroundTransparency = 1, ZIndex = 57 })
    C(pillDot, 3)
    local arrowLbl = ni("TextLabel", SideTab, { Size = UDim2.new(1, 0, 0, 16), Position = UDim2.new(0, 0, 0, 22), BackgroundTransparency = 1, Text = "‹", TextColor3 = th.Acc, Font = Enum.Font.GothamBold, TextSize = 14, ZIndex = 57 })
    ni("TextLabel", SideTab, { Size = UDim2.new(1, 0, 0, 48), Position = UDim2.new(0, 0, 0, 40), BackgroundTransparency = 1, Text = "·\nG\nU\nI", TextColor3 = th.Dim, Font = Enum.Font.GothamBold, TextSize = 8, LineHeight = 1.3, ZIndex = 56 })

    local _tabMoved = false
    do
        local dr, dsy, sy0 = false, 0, 0
        local dc
        SideTab.InputBegan:Connect(function(i, gpe)
            if gpe then return end
            if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
            dr = true; _tabMoved = false
            dsy = UIS:GetMouseLocation().Y
            sy0 = SideTab.Position.Y.Offset
            if dc then dc:Disconnect() end
            dc = Run.Heartbeat:Connect(function()
                if not dr then dc:Disconnect(); return end
                local dy = UIS:GetMouseLocation().Y - dsy
                if math.abs(dy) > 5 then _tabMoved = true end
                SideTab.Position = UDim2.new(1, 0, 0.5, sy0 + dy)
            end)
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dr = false end
        end)
    end

    local Hidden, Minimised, Deb = false, false, false
    local OPEN_SIZE = UDim2.new(0, WW, 0, WH)
    local OPEN_POS = UDim2.new(0.5, 4, 0.5, -38)

    local function openGUI()
        if Deb then return end; Deb = true; Hidden = false
        Main.Size = UDim2.new(0, WW, 0, WH * 0.86)
        Main.Position = UDim2.new(0.5, 4, 0.5, -38 + 10)
        Main.Visible = true
        shadow.Visible = true
        arrowLbl.Text = "‹"
        tw(Main, { Size = OPEN_SIZE, Position = OPEN_POS }, 0.30, Enum.EasingStyle.Back)
        task.delay(0.34, function() Deb = false end)
    end

    local function closeGUI(silent)
        if Deb then return end; Deb = true; Hidden = true
        arrowLbl.Text = "›"
        tw(Main, { Size = UDim2.new(0, WW, 0, WH * 0.86), Position = UDim2.new(0.5, 4, 0.5, -38 + 10) }, 0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        task.delay(0.22, function()
            Main.Visible = false
            shadow.Visible = false
            Main.Size = OPEN_SIZE
            Main.Position = OPEN_POS
            Deb = false
        end)
        if not silent then
            Vula:Notify({ Title = "GUI Hidden", Content = "Press RightShift or tap the side tab to reopen.", Duration = 3, Type = "info" })
        end
    end

    local function toggleGUI()
        if Hidden then openGUI() else closeGUI(true) end
    end

    oClose.MouseButton1Click:Connect(function() closeGUI(true) end)
    oMin.MouseButton1Click:Connect(function()
        Minimised = not Minimised
        if Minimised then
            SB.Visible = false; Cont.Visible = false
            tw(Main, { Size = UDim2.new(0, WW, 0, TOP_H) }, 0.24)
        else
            tw(Main, { Size = UDim2.new(0, WW, 0, WH) }, 0.36, Enum.EasingStyle.Back)
            task.delay(0.16, function() SB.Visible = true; Cont.Visible = true end)
        end
    end)

    local tabBtn = ni("TextButton", SideTab, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "", ZIndex = 60, AutoButtonColor = false })
    tabBtn.MouseButton1Click:Connect(function() if not _tabMoved then toggleGUI() end end)
    tabBtn.MouseEnter:Connect(function()
        tw(SideTab, { Size = UDim2.new(0, PT_W + 8, 0, PT_H) }, 0.18, Enum.EasingStyle.Back)
        tw(arrowLbl, { TextColor3 = th.Text }, 0.14)
        tw(tabBar, { BackgroundTransparency = 0 }, 0.14)
    end)
    tabBtn.MouseLeave:Connect(function()
        tw(SideTab, { Size = UDim2.new(0, PT_W, 0, PT_H) }, 0.14)
        tw(arrowLbl, { TextColor3 = th.Acc }, 0.14)
        tw(tabBar, { BackgroundTransparency = 0.1 }, 0.14)
    end)

    UIS.InputBegan:Connect(function(i, gpe)
        if gpe then return end
        if i.KeyCode == Enum.KeyCode.RightShift then toggleGUI() end
    end)

    -- Tab System
    local _tabs, _btns, _act = {}, {}, 0
    local function selTab(idx)
        if _act == idx then return end
        transOverlay.BackgroundTransparency = 0.3
        tw(transOverlay, { BackgroundTransparency = 1 }, 0.20, Enum.EasingStyle.Quint)
        for i, t in ipairs(_tabs) do
            t.page.Visible = (i == idx)
            local b = _btns[i]; if not b then continue end
            local lbl = b:FindFirstChildWhichIsA("TextLabel")
            local bar = b:FindFirstChild("_b")
            local aBg = b:FindFirstChild("_abg")
            local ico = b:FindFirstChild("_ico")
            if i == idx then
                tw(b, { BackgroundColor3 = th.TBOn, BackgroundTransparency = 0 }, 0.20)
                if aBg then tw(aBg, { BackgroundTransparency = 0.86 }, 0.20) end
                if lbl then tw(lbl, { TextColor3 = th.TxtOn, TextTransparency = 0 }, 0.16) end
                if bar then tw(bar, { BackgroundTransparency = 0, BackgroundColor3 = th.Acc }, 0.16) end
                if ico then tw(ico, { ImageColor3 = th.Acc }, 0.16) end
            else
                tw(b, { BackgroundColor3 = th.TBOff, BackgroundTransparency = 0.72 }, 0.20)
                if aBg then tw(aBg, { BackgroundTransparency = 1 }, 0.20) end
                if lbl then tw(lbl, { TextColor3 = th.TxtOff, TextTransparency = 0.25 }, 0.16) end
                if bar then tw(bar, { BackgroundTransparency = 1 }, 0.16) end
                if ico then tw(ico, { ImageColor3 = th.TxtOff }, 0.16) end
            end
        end
        _act = idx
    end

    local Win = { _sg = sg, _tabs = _tabs, _activeTab = 0, _th = th }
    self._window = Win

    function Win:Destroy()
        if sg and sg.Parent then sg:Destroy() end
        if shadow and shadow.Parent then shadow:Destroy() end
        self._window = nil
    end

    -- Improved theme switching
    function Win:SetTheme(name)
        local newTh = rt(Vula.Themes[name] or Vula.Themes.Default)
        -- Update global theme
        th = newTh
        Vula._theme = newTh
        -- Helper to update colors recursively (more thorough than before)
        local function updateInstance(inst)
            pcall(function()
                -- Background color
                if inst:IsA("Frame") or inst:IsA("TextButton") or inst:IsA("ScrollingFrame") then
                    local oldColor = inst.BackgroundColor3
                    -- Find matching color from old theme? Instead, we use a mapping based on color value approximation.
                    -- Simpler: if the instance has a dedicated property, we can set it from the theme.
                    -- But for generic frames, we rely on the fact that they were set with theme colors at creation.
                    -- For simplicity, we'll just set the color from the theme's matching field if we can infer.
                    -- We'll use a more direct approach: store a "themeKey" in instances? That's too heavy.
                    -- Instead, we'll manually update known UI elements (like topbar, sidebar, etc.) and leave others.
                    -- The previous remap function tried to map by color value; we'll improve it with a cache.
                end
                -- Text color
                if inst:IsA("TextLabel") or inst:IsA("TextButton") then
                    local oldText = inst.TextColor3
                    -- Similarly...
                end
                -- UIStroke
                if inst:IsA("UIStroke") then
                    -- ...
                end
                -- UIGradient
                if inst:IsA("UIGradient") then
                    -- ...
                end
            end)
        end

        -- More robust: iterate all descendants and update based on a color mapping
        local function getColorKey(c)
            return math.floor(c.R*255+0.5)..","..math.floor(c.G*255+0.5)..","..math.floor(c.B*255+0.5)
        end
        -- Build mapping from old theme to new theme for all relevant colors
        local oldTh = Win._th or th
        local mapping = {}
        for k, v in pairs(oldTh) do
            if typeof(v) == "Color3" then
                local newV = newTh[k]
                if newV then
                    mapping[getColorKey(v)] = newV
                end
            end
        end
        for _, inst in ipairs(sg:GetDescendants()) do
            pcall(function()
                if inst:IsA("Frame") or inst:IsA("TextButton") or inst:IsA("ScrollingFrame") then
                    local key = getColorKey(inst.BackgroundColor3)
                    local newC = mapping[key]
                    if newC then tw(inst, { BackgroundColor3 = newC }, 0.3) end
                end
                if inst:IsA("TextLabel") or inst:IsA("TextButton") then
                    local key = getColorKey(inst.TextColor3)
                    local newC = mapping[key]
                    if newC then tw(inst, { TextColor3 = newC }, 0.3) end
                end
                if inst:IsA("UIStroke") then
                    local key = getColorKey(inst.Color)
                    local newC = mapping[key]
                    if newC then tw(inst, { Color = newC }, 0.3) end
                end
                if inst:IsA("ImageLabel") then
                    local key = getColorKey(inst.ImageColor3)
                    local newC = mapping[key]
                    if newC then tw(inst, { ImageColor3 = newC }, 0.3) end
                end
                if inst:IsA("UIGradient") then
                    -- Update gradient keypoints
                    local kps = inst.ColorSequence.Keypoints
                    local changed = false
                    local newKps = {}
                    for _, kp in ipairs(kps) do
                        local key = getColorKey(kp.Value)
                        local newC = mapping[key]
                        if newC then
                            changed = true
                            newKps[#newKps+1] = ColorSequenceKeypoint.new(kp.Time, newC)
                        else
                            newKps[#newKps+1] = kp
                        end
                    end
                    if changed then
                        inst.ColorSequence = ColorSequence.new(newKps)
                    end
                end
            end)
        end
        -- Update specific references
        subLbl.Text = "v6.0 · " .. name
        Win._th = newTh
        Vula:Notify({ Title = "Theme", Content = name .. " applied.", Duration = 2.5, Type = "success" })
    end

    function Win:SetPillActive(active)
        tw(pillDot, { BackgroundTransparency = active and 0 or 1 }, 0.20)
        if active then
            task.spawn(function()
                while pillDot.Parent and pillDot.BackgroundTransparency < 0.5 do
                    tw(pillDot, { BackgroundTransparency = 0.65 }, 0.60, Enum.EasingStyle.Sine)
                    task.wait(0.66)
                    if pillDot.Parent then
                        tw(pillDot, { BackgroundTransparency = 0 }, 0.60, Enum.EasingStyle.Sine)
                        task.wait(0.66)
                    end
                end
            end)
        end
    end

    -- Icons
    local ICONS = {
        sword = "rbxassetid://7743874695", shield = "rbxassetid://7734053495", star = "rbxassetid://7734053502",
        bolt = "rbxassetid://7734053474", refresh = "rbxassetid://7734053484", gift = "rbxassetid://7734053477",
        settings = "rbxassetid://7734053488", skull = "rbxassetid://7734053491", dice = "rbxassetid://7734053494",
        flag = "rbxassetid://7734053476", info = "rbxassetid://7734053480", home = "rbxassetid://7734053479",
        lock = "rbxassetid://7734053482", check = "rbxassetid://7734053473", edit = "rbxassetid://7734053475",
        person = "rbxassetid://7734053486"
    }

    function Win:CreateTab(name, icon)
        local idx = #_tabs + 1
        local first = (idx == 1)
        local iconId = icon and (ICONS[icon] or (icon:find("rbxassetid") and icon))

        local btn = ni("TextButton", tabSF, { Name = "T_" .. name, Size = UDim2.new(1, 0, 0, TAB_H_BTN), BackgroundColor3 = first and th.TBOn or th.TBOff, BackgroundTransparency = first and 0 or 0.72, Text = "", ZIndex = 6, AutoButtonColor = false, LayoutOrder = idx })
        C(btn, 10)
        local bar = ni("Frame", btn, { Name = "_b", Size = UDim2.new(0, 3, 0.52, 0), Position = UDim2.new(0, 0, 0.24, 0), BackgroundColor3 = th.Acc, BackgroundTransparency = first and 0 or 1, ZIndex = 7 })
        C(bar, 2)
        local aBg = ni("Frame", btn, { Name = "_abg", Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = th.Acc, BackgroundTransparency = first and 0.86 or 1, ZIndex = 6 })
        C(aBg, 10)

        local textX = iconId and (mob and 36 or 30) or 10
        if iconId then
            local icoSz = mob and 18 or 14
            ni("ImageLabel", btn, { Name = "_ico", Size = UDim2.new(0, icoSz, 0, icoSz), Position = UDim2.new(0, mob and 12 or 10, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Image = iconId, ImageColor3 = first and th.Acc or th.TxtOff, ScaleType = Enum.ScaleType.Fit, ZIndex = 8 })
        end
        local lbl = ni("TextLabel", btn, { Size = UDim2.new(1, -(textX + 6), 1, 0), Position = UDim2.new(0, textX, 0, 0), BackgroundTransparency = 1, Text = name, TextColor3 = first and th.TxtOn or th.TxtOff, Font = Enum.Font.GothamBold, TextSize = FONT_SM, TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = first and 0 or 0.25, ZIndex = 7 })

        btn.MouseButton1Click:Connect(function() selTab(idx) end)
        btn.MouseEnter:Connect(function() if _act ~= idx then tw(btn, { BackgroundTransparency = 0.28 }, 0.13) end end)
        btn.MouseLeave:Connect(function() if _act ~= idx then tw(btn, { BackgroundTransparency = 0.72 }, 0.13) end end)

        local page = ni("ScrollingFrame", Cont, { Name = "P_" .. name, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 2, ScrollBarImageColor3 = th.Acc, ScrollBarImageTransparency = 0.4, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(0,0,0,0), Visible = first, ZIndex = 4, ClipsDescendants = true })
        LL(page, 5)
        Pd(page, 6, 6, 8, 8)

        local tab = { page = page, _n = 0 }
        _tabs[idx] = tab
        _btns[idx] = btn
        if first then _act = 1 end

        local function eo() tab._n = tab._n + 1; return tab._n end

        -- Section
        function tab:CreateSection(label)
            local sf = ni("Frame", page, { Size = UDim2.new(1, 0, 0, mob and 30 or 24), BackgroundTransparency = 1, ZIndex = 4, LayoutOrder = eo() })
            local dot = ni("Frame", sf, { Size = UDim2.new(0, mob and 5 or 4, 0, mob and 5 or 4), Position = UDim2.new(0, 2, 0, mob and 13 or 10), BackgroundColor3 = th.Acc, ZIndex = 5 })
            C(dot, 3)
            ni("TextLabel", sf, { Size = UDim2.new(1, -16, 0, mob and 18 or 14), Position = UDim2.new(0, 11, 0, mob and 5 or 3), BackgroundTransparency = 1, Text = label:upper(), TextColor3 = th.SecLbl, Font = Enum.Font.GothamBold, TextSize = mob and 10 or 8, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5 })
            local dl = ni("Frame", sf, { Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1), BackgroundColor3 = th.Acc, BackgroundTransparency = 0.50, ZIndex = 5 })
            ni("UIGradient", dl, { Rotation = 0, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0,0.2), NumberSequenceKeypoint.new(0.4,0.6), NumberSequenceKeypoint.new(1,1.0) }) })
        end

        -- Toggle (unchanged from previous but with proper theming)
        function tab:CreateToggle(opts2)
            local tName = opts2.Name or "Toggle"
            local dVal = opts2.CurrentValue or false
            local fl = opts2.Flag
            local cb = opts2.Callback
            local val = dVal
            local ROW_H_T = mob and 44 or 36
            local row = ni("Frame", page, { Size = UDim2.new(1, 0, 0, ROW_H_T), BackgroundColor3 = th.Card, ZIndex = 5, LayoutOrder = eo() })
            C(row, 10)
            local rSt = St(row, th.Stroke, 1, 0.26)
            local la = ni("Frame", row, { Size = UDim2.new(0, 3, 0.46, 0), Position = UDim2.new(0, 0, 0.27, 0), BackgroundColor3 = th.Acc, BackgroundTransparency = val and 0.12 or 1, ZIndex = 6 })
            C(la, 2)
            local dot = ni("Frame", row, { Size = UDim2.new(0, 5, 0, 5), Position = UDim2.new(0, 12, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = th.Acc, BackgroundTransparency = val and 0.08 or 1, ZIndex = 7 })
            C(dot, 3)
            local PW = mob and 48 or 38
            local PH = mob and 26 or 20
            local KS = mob and 20 or 14
            local K0 = 3
            local K1 = PW - KS - 3
            local nameLbl = ni("TextLabel", row, { Size = UDim2.new(1, -(PW + 28), 1, 0), Position = UDim2.new(0, 21, 0, 0), BackgroundTransparency = 1, Text = tName, TextColor3 = val and th.Text or th.Dim, Font = Enum.Font.GothamSemibold, TextSize = FONT_MD, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
            local pill = ni("Frame", row, { Size = UDim2.new(0, PW, 0, PH), Position = UDim2.new(1, -(PW + 10), 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = val and th.TOn or th.TOff, ZIndex = 6 })
            C(pill, PH//2)
            local pSt = St(pill, val and th.TOn or th.Stroke, 1, val and 0.30 or 0.08)
            local knob = ni("Frame", pill, { Size = UDim2.new(0, KS, 0, KS), Position = UDim2.new(0, val and K1 or K0, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = th.Knob, ZIndex = 7 })
            C(knob, KS//2)
            St(knob, Color3.new(0,0,0), 1, 0.86)

            local dotLoop
            local function startDot()
                if dotLoop then return end
                dotLoop = task.spawn(function()
                    while dot.Parent and dot.BackgroundTransparency < 0.5 do
                        tw(dot, { BackgroundTransparency = 0.65 }, 0.55, Enum.EasingStyle.Sine)
                        task.wait(0.60)
                        if dot.Parent then
                            tw(dot, { BackgroundTransparency = 0.05 }, 0.55, Enum.EasingStyle.Sine)
                            task.wait(0.60)
                        end
                    end
                end)
            end
            local function stopDot()
                if dotLoop then task.cancel(dotLoop); dotLoop = nil end
            end

            local tog = { CurrentValue = val, Type = "Toggle" }
            local function apply(v)
                val = v; tog.CurrentValue = v
                tw(pill, { BackgroundColor3 = v and th.TOn or th.TOff }, 0.22)
                tw(pSt, { Color = v and th.TOn or th.Stroke, Transparency = v and 0.30 or 0.08 }, 0.22)
                tw(la, { BackgroundTransparency = v and 0.12 or 1 }, 0.22)
                tw(rSt, { Color = v and th.Acc or th.Stroke, Transparency = v and 0.38 or 0.26 }, 0.22)
                tw(nameLbl, { TextColor3 = v and th.Text or th.Dim }, 0.18)
                tw(dot, { BackgroundTransparency = v and 0.05 or 1 }, 0.18)
                tw(knob, { Size = UDim2.new(0, KS*1.38, 0, KS*0.68) }, 0.07, Enum.EasingStyle.Sine)
                task.delay(0.07, function()
                    if not knob.Parent then return end
                    tw(knob, { Size = UDim2.new(0, KS, 0, KS), Position = UDim2.new(0, v and K1 or K0, 0.5, 0) }, 0.38, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                end)
                if v then startDot() else stopDot() end
            end
            function tog:Set(v) apply(v); if cb then cb(v) end end
            if val then startDot() end

            local hit = ni("TextButton", row, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "", ZIndex = 9, AutoButtonColor = false })
            hit.MouseEnter:Connect(function() tw(row, { BackgroundColor3 = th.CardH }, 0.13); tw(rSt, { Transparency = val and 0.20 or 0.13 }, 0.13) end)
            hit.MouseLeave:Connect(function() tw(row, { BackgroundColor3 = th.Card }, 0.13); tw(rSt, { Transparency = val and 0.38 or 0.26 }, 0.13) end)
            hit.MouseButton1Down:Connect(function() tw(pill, { Size = UDim2.new(0, PW*0.82, 0, PH*0.76) }, 0.06, Enum.EasingStyle.Quint) end)
            local busy = false
            hit.MouseButton1Click:Connect(function()
                if busy then return end; busy = true
                task.delay(0.38, function() busy = false end)
                tw(pill, { Size = UDim2.new(0, PW, 0, PH) }, 0.28, Enum.EasingStyle.Back)
                tog:Set(not val)
            end)
            if fl then Vula.Flags[fl] = tog end
            return tog
        end

        -- Button (unchanged)
        function tab:CreateButton(opts2)
            local bName = opts2.Name or "Button"
            local cb = opts2.Callback
            local sub = opts2.Description or ""
            local ROW_H = sub ~= "" and (mob and 54 or 42) or (mob and 42 or 34)
            local row = ni("Frame", page, { Size = UDim2.new(1, 0, 0, ROW_H), BackgroundColor3 = th.Card, ZIndex = 5, LayoutOrder = eo(), ClipsDescendants = true })
            C(row, 10)
            local rSt = St(row, th.Stroke, 1, 0.24)
            local fill = ni("Frame", row, { Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = th.Acc, BackgroundTransparency = 0.88, ZIndex = 5 })
            C(fill, 9)
            ni("TextLabel", row, { Size = UDim2.new(1, -28, 0, mob and 22 or 18), Position = UDim2.new(0, 12, 0, sub ~= "" and (mob and 8 or 6) or 0), BackgroundTransparency = 1, Text = bName, TextColor3 = th.Text, Font = Enum.Font.GothamSemibold, TextSize = FONT_MD, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
            if sub ~= "" then
                ni("TextLabel", row, { Size = UDim2.new(1, -28, 0, mob and 16 or 14), Position = UDim2.new(0, 12, 0, mob and 30 or 24), BackgroundTransparency = 1, Text = sub, TextColor3 = th.Dim, Font = Enum.Font.GothamMedium, TextSize = mob and 10 or 8, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
            end
            local arr = ni("TextLabel", row, { Size = UDim2.new(0, 16, 1, 0), Position = UDim2.new(1, -18, 0, 0), BackgroundTransparency = 1, Text = "›", TextColor3 = th.Dim, Font = Enum.Font.GothamBold, TextSize = 18, ZIndex = 6 })
            local hit = ni("TextButton", row, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "", ZIndex = 9, AutoButtonColor = false })
            hit.MouseEnter:Connect(function()
                tw(row, { BackgroundColor3 = th.CardH }, 0.13)
                tw(fill, { Size = UDim2.new(1, 0, 1, 0) }, 0.24)
                tw(rSt, { Color = th.Acc, Transparency = 0.48 }, 0.16)
                tw(arr, { TextColor3 = th.Acc }, 0.13)
            end)
            hit.MouseLeave:Connect(function()
                tw(row, { BackgroundColor3 = th.Card }, 0.13)
                tw(fill, { Size = UDim2.new(0, 0, 1, 0) }, 0.16)
                tw(rSt, { Color = th.Stroke, Transparency = 0.24 }, 0.16)
                tw(arr, { TextColor3 = th.Dim }, 0.13)
            end)
            hit.MouseButton1Down:Connect(function(mx, my)
                local abs = row.AbsolutePosition
                local d = math.max(row.AbsoluteSize.X, row.AbsoluteSize.Y) * 2.6
                local rip = ni("Frame", row, { Size = UDim2.new(0,0,0,0), Position = UDim2.new(0, mx - abs.X, 0, my - abs.Y), AnchorPoint = Vector2.new(0.5,0.5), BackgroundColor3 = th.Acc, BackgroundTransparency = 0.70, ZIndex = 10 })
                C(rip, 999)
                tw(rip, { Size = UDim2.new(0,d,0,d), BackgroundTransparency = 1 }, 0.44, Enum.EasingStyle.Quint)
                task.delay(0.46, function() if rip.Parent then rip:Destroy() end end)
            end)
            local cd = false
            hit.MouseButton1Click:Connect(function()
                if cd then return end; cd = true
                task.delay(0.24, function() cd = false end)
                if cb then task.spawn(cb) end
            end)
            local b = { SetText = function(_, t) local l = row:FindFirstChildWhichIsA("TextLabel"); if l then l.Text = t end end }
            return b
        end

        -- Label (unchanged)
        function tab:CreateLabel(text)
            local row = ni("Frame", page, { Size = UDim2.new(1, 0, 0, mob and 32 or 26), BackgroundColor3 = th.Card, ZIndex = 5, LayoutOrder = eo() })
            C(row, 10)
            St(row, th.Stroke, 1, 0.38)
            local lbl = ni("TextLabel", row, { Size = UDim2.new(1, -14, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = text, TextColor3 = th.Dim, Font = Enum.Font.GothamMedium, TextSize = FONT_SM, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, ZIndex = 6 })
            return { Set = function(_, t) lbl.Text = t end, Get = function() return lbl.Text end }
        end

        -- Keybind (unchanged)
        function tab:CreateKeybind(opts2)
            local kName = opts2.Name or "Keybind"
            local kDef = opts2.CurrentKeybind or "RightShift"
            local fl = opts2.Flag
            local cb = opts2.Callback
            local cur = kDef
            local listening = false
            local row = ni("Frame", page, { Size = UDim2.new(1, 0, 0, mob and 42 or 34), BackgroundColor3 = th.Card, ZIndex = 5, LayoutOrder = eo() })
            C(row, 10)
            St(row, th.Stroke, 1, 0.24)
            ni("TextLabel", row, { Size = UDim2.new(1, mob and -100 or -82, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1, Text = kName, TextColor3 = th.Text, Font = Enum.Font.GothamSemibold, TextSize = FONT_MD, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
            local chip = ni("TextButton", row, { Size = UDim2.new(0, mob and 80 or 66, 0, mob and 26 or 20), Position = UDim2.new(1, mob and -88 or -72, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = th.InBg, Text = cur, TextColor3 = th.Acc, Font = Enum.Font.GothamBold, TextSize = mob and 10 or 8, ZIndex = 7, AutoButtonColor = false })
            C(chip, 8)
            local cSt = St(chip, th.Acc, 1, 0.40)
            chip.MouseButton1Click:Connect(function()
                if listening then return end
                listening = true
                chip.Text = "…"
                tw(chip, { BackgroundColor3 = th.Acc }, 0.14)
                tw(cSt, { Transparency = 0 }, 0.14)
            end)
            UIS.InputBegan:Connect(function(i, gpe)
                if not listening then return end
                if i.UserInputType ~= Enum.UserInputType.Keyboard then return end
                listening = false
                cur = i.KeyCode.Name
                chip.Text = cur
                tw(chip, { BackgroundColor3 = th.InBg }, 0.14)
                tw(cSt, { Transparency = 0.40 }, 0.14)
                if cb then cb(cur) end
            end)
            local kb = { CurrentKeybind = cur, Type = "Keybind" }
            function kb:Set(v) cur = v; chip.Text = v end
            if fl then Vula.Flags[fl] = kb end
            return kb
        end

        -- Slider (unchanged)
        function tab:CreateSlider(opts2)
            local sName = opts2.Name or "Slider"
            local sMin = opts2.Min or 0
            local sMax = opts2.Max or 100
            local sInc = opts2.Increment or 1
            local sVal = clamp(opts2.Default or sMin, sMin, sMax)
            local fl = opts2.Flag
            local cb = opts2.Callback
            local sfx = opts2.Suffix or ""
            local row = ni("Frame", page, { Size = UDim2.new(1, 0, 0, mob and 56 or 46), BackgroundColor3 = th.Card, ZIndex = 5, LayoutOrder = eo() })
            C(row, 10)
            St(row, th.Stroke, 1, 0.24)
            ni("TextLabel", row, { Size = UDim2.new(0.60, 0, 0, 16), Position = UDim2.new(0, 12, 0, 7), BackgroundTransparency = 1, Text = sName, TextColor3 = th.Text, Font = Enum.Font.GothamSemibold, TextSize = FONT_MD, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
            local valBg = ni("Frame", row, { Size = UDim2.new(0, 42, 0, 16), Position = UDim2.new(1, -48, 0, 7), BackgroundColor3 = th.InBg, ZIndex = 6 })
            C(valBg, 6)
            St(valBg, th.Acc, 1, 0.50)
            local valLbl = ni("TextLabel", valBg, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = tostring(sVal) .. sfx, TextColor3 = th.Acc, Font = Enum.Font.GothamBold, TextSize = 9, ZIndex = 7 })
            local PAD = 10
            local trackBg = ni("Frame", row, { Size = UDim2.new(1, -PAD*2, 0, mob and 6 or 4), Position = UDim2.new(0, PAD, 1, mob and -12 or -10), AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = th.SliderTrack or th.Div, ZIndex = 6 })
            C(trackBg, 3)
            local trackFill = ni("Frame", trackBg, { Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = th.Acc, ZIndex = 7 })
            C(trackFill, 2)
            ni("UIGradient", trackFill, { Rotation = 0, ColorSequence = ColorSequence.new(th.AccD, th.Acc) })
            local KS2 = mob and 16 or 14
            local thumb = ni("Frame", trackBg, { Size = UDim2.new(0, KS2, 0, KS2), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 0, 0.5, 0), BackgroundColor3 = th.Acc, ZIndex = 8 })
            C(thumb, KS2//2)
            ni("UIGradient", thumb, { Rotation = 135, ColorSequence = ColorSequence.new(th.Acc, th.AccD) })
            St(thumb, th.AccD, 1, 0.30)

            local function setVal(v, fire)
                v = clamp(round(v, sInc), sMin, sMax)
                sVal = v
                local pct = sMax == sMin and 0 or (v - sMin) / (sMax - sMin)
                tw(trackFill, { Size = UDim2.new(pct, 0, 1, 0) }, 0.07)
                tw(thumb, { Position = UDim2.new(pct, 0, 0.5, 0) }, 0.07)
                valLbl.Text = tostring(v) .. sfx
                if fire and cb then cb(v) end
            end
            local hitArea = ni("TextButton", trackBg, { Size = UDim2.new(1, PAD*2, 0, mob and 44 or 30), Position = UDim2.new(0, -PAD, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Text = "", ZIndex = 9, AutoButtonColor = false })
            local dragging = false
            hitArea.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    tw(thumb, { Size = UDim2.new(0, KS2*1.28, 0, KS2*1.28) }, 0.12, Enum.EasingStyle.Back)
                end
            end)
            UIS.InputChanged:Connect(function(i)
                if not dragging then return end
                if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
                    local abs = trackBg.AbsolutePosition
                    local sz = trackBg.AbsoluteSize
                    setVal(sMin + clamp((UIS:GetMouseLocation().X - abs.X) / sz.X, 0, 1) * (sMax - sMin), false)
                end
            end)
            UIS.InputEnded:Connect(function(i)
                if dragging and (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) then
                    dragging = false
                    tw(thumb, { Size = UDim2.new(0, KS2, 0, KS2) }, 0.22, Enum.EasingStyle.Back)
                    setVal(sVal, true)
                end
            end)
            row.MouseEnter:Connect(function() tw(row, { BackgroundColor3 = th.CardH }, 0.13) end)
            row.MouseLeave:Connect(function() tw(row, { BackgroundColor3 = th.Card }, 0.13) end)
            local sl = { Value = sVal, Type = "Slider" }
            function sl:Set(v) setVal(v, false) end
            function sl:Get() return sVal end
            setVal(sVal, false)
            if fl then Vula.Flags[fl] = sl end
            return sl
        end

        -- Input (unchanged)
        function tab:CreateInput(opts2)
            local iName = opts2.Name or "Input"
            local iPH = opts2.Placeholder or "Type here…"
            local fl = opts2.Flag
            local cb = opts2.Callback
            local numO = opts2.NumbersOnly or false
            local row = ni("Frame", page, { Size = UDim2.new(1, 0, 0, mob and 66 or 54), BackgroundColor3 = th.Card, ZIndex = 5, LayoutOrder = eo() })
            C(row, 10)
            St(row, th.Stroke, 1, 0.24)
            ni("TextLabel", row, { Size = UDim2.new(0.80, 0, 0, mob and 16 or 14), Position = UDim2.new(0, 12, 0, mob and 8 or 6), BackgroundTransparency = 1, Text = iName, TextColor3 = th.Dim, Font = Enum.Font.GothamBold, TextSize = mob and 11 or 9, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
            local inputBg = ni("Frame", row, { Size = UDim2.new(1, -16, 0, mob and 28 or 24), Position = UDim2.new(0, 8, 0, mob and 28 or 23), BackgroundColor3 = th.InBg, ZIndex = 6 })
            C(inputBg, 8)
            local iSt = St(inputBg, th.Stroke, 1, 0.26)
            local tb = ni("TextBox", inputBg, { Size = UDim2.new(1, -14, 1, 0), Position = UDim2.new(0, 8, 0, 0), BackgroundTransparency = 1, Text = "", PlaceholderText = iPH, TextColor3 = th.Text, PlaceholderColor3 = th.Ph, Font = Enum.Font.GothamMedium, TextSize = mob and 11 or 9, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 7, ClearTextOnFocus = false })
            tb.Focused:Connect(function() tw(iSt, { Color = th.Acc, Transparency = 0.14 }, 0.14); tw(inputBg, { BackgroundColor3 = th.Card }, 0.14) end)
            tb.FocusLost:Connect(function(enter)
                if numO then
                    local n = tonumber(tb.Text)
                    tb.Text = n and tostring(n) or ""
                end
                tw(iSt, { Color = th.Stroke, Transparency = 0.26 }, 0.14)
                tw(inputBg, { BackgroundColor3 = th.InBg }, 0.14)
                if cb then cb(tb.Text, enter) end
            end)
            local inp = { Type = "Input" }
            function inp:Get() return tb.Text end
            function inp:Set(v) tb.Text = tostring(v) end
            function inp:Clear() tb.Text = "" end
            if fl then Vula.Flags[fl] = inp end
            return inp
        end

        -- Dropdown (unchanged but with badge update on theme)
        function tab:CreateDropdown(opts2)
            local dName = opts2.Name or "Select"
            local opts3 = opts2.Options or {}
            local multi = opts2.Multi ~= false
            local fl = opts2.Flag
            local cb = opts2.Callback
            local HDRH = mob and 42 or 34
            local ITMH = mob and 36 or 28
            local selected = {}
            local isOpen = false
            local totalH = HDRH + (#opts3 * ITMH) + 8
            local wrap = ni("Frame", page, { Size = UDim2.new(1, 0, 0, HDRH), BackgroundTransparency = 1, ZIndex = 5, LayoutOrder = eo(), ClipsDescendants = true })
            local hdr = ni("Frame", wrap, { Size = UDim2.new(1, 0, 0, HDRH), BackgroundColor3 = th.Card, ZIndex = 5 })
            C(hdr, 10)
            local hdrSt = St(hdr, th.Stroke, 1, 0.24)
            ni("TextLabel", hdr, { Size = UDim2.new(1, -46, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1, Text = dName, TextColor3 = th.Text, Font = Enum.Font.GothamSemibold, TextSize = FONT_MD, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
            local cntBg = ni("Frame", hdr, { Size = UDim2.new(0, 26, 0, 16), Position = UDim2.new(1, -36, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = th.InBg, ZIndex = 7 })
            C(cntBg, 6)
            local cntLbl = ni("TextLabel", cntBg, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "0", TextColor3 = th.Acc, Font = Enum.Font.GothamBold, TextSize = 8, ZIndex = 8 })
            local chev = ni("TextLabel", hdr, { Size = UDim2.new(0, 14, 1, 0), Position = UDim2.new(1, -16, 0, 0), BackgroundTransparency = 1, Text = "▾", TextColor3 = th.Dim, Font = Enum.Font.GothamBold, TextSize = 12, ZIndex = 7 })
            local iFrame = ni("Frame", wrap, { Size = UDim2.new(1, 0, 0, #opts3 * ITMH + 8), Position = UDim2.new(0, 0, 0, HDRH + 2), BackgroundColor3 = th.InBg, ZIndex = 5 })
            C(iFrame, 9)
            St(iFrame, th.Stroke, 1, 0.30)
            LL(iFrame, 0)
            Pd(iFrame, 4, 4, 4, 4)
            local iBtns = {}
            local function updCount()
                local n = 0; for _ in next, selected do n = n + 1 end
                cntLbl.Text = tostring(n)
                tw(cntBg, { BackgroundColor3 = n > 0 and th.Acc or th.InBg }, 0.16)
                tw(cntLbl, { TextColor3 = n > 0 and Color3.new(1,1,1) or th.Acc }, 0.16)
            end
            for _, optName in ipairs(opts3) do
                local name = optName
                local ib = ni("TextButton", iFrame, { Size = UDim2.new(1, 0, 0, ITMH), BackgroundColor3 = th.Card, BackgroundTransparency = 0.72, Text = "", ZIndex = 6, AutoButtonColor = false })
                C(ib, 6)
                local chk = ni("Frame", ib, { Size = UDim2.new(0, 10, 0, 10), Position = UDim2.new(0, 7, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = th.TOff, ZIndex = 7 })
                C(chk, 4)
                St(chk, th.Acc, 1, 0.30)
                local chkM = ni("TextLabel", chk, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "✓", TextColor3 = Color3.new(1,1,1), Font = Enum.Font.GothamBold, TextSize = 7, TextTransparency = 1, ZIndex = 8 })
                ni("TextLabel", ib, { Size = UDim2.new(1, -26, 1, 0), Position = UDim2.new(0, 24, 0, 0), BackgroundTransparency = 1, Text = name, TextColor3 = th.Dim, Font = Enum.Font.GothamMedium, TextSize = mob and 11 or 9, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 7 })
                local function setChk(v)
                    tw(chk, { BackgroundColor3 = v and th.Acc or th.TOff }, 0.16)
                    tw(chkM, { TextTransparency = v and 0 or 1 }, 0.16)
                    local l = ib:FindFirstChildWhichIsA("TextLabel")
                    if l and l ~= chkM then tw(l, { TextColor3 = v and th.Text or th.Dim }, 0.16) end
                end
                ib.MouseButton1Click:Connect(function()
                    if not multi then
                        for k in next, selected do
                            selected[k] = nil
                            if iBtns[k] then iBtns[k](false) end
                        end
                    end
                    selected[name] = not selected[name] or nil
                    setChk(selected[name] ~= nil)
                    updCount()
                    if cb then
                        local s = {}
                        for k in next, selected do s[#s+1] = k end
                        cb(s)
                    end
                end)
                ib.MouseEnter:Connect(function() tw(ib, { BackgroundTransparency = 0.36 }, 0.11) end)
                ib.MouseLeave:Connect(function() tw(ib, { BackgroundTransparency = 0.72 }, 0.11) end)
                iBtns[name] = setChk
            end
            local hHit = ni("TextButton", hdr, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "", ZIndex = 8, AutoButtonColor = false })
            hHit.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                tw(wrap, { Size = UDim2.new(1, 0, 0, isOpen and totalH or HDRH) }, 0.26, Enum.EasingStyle.Quint)
                chev.Text = isOpen and "▴" or "▾"
                tw(hdrSt, { Color = isOpen and th.Acc or th.Stroke, Transparency = isOpen and 0.38 or 0.24 }, 0.18)
            end)
            hHit.MouseEnter:Connect(function() tw(hdr, { BackgroundColor3 = th.CardH }, 0.13) end)
            hHit.MouseLeave:Connect(function() tw(hdr, { BackgroundColor3 = th.Card }, 0.13) end)
            local dd = { Type = "Dropdown", Selected = selected }
            function dd:GetSelected()
                local s = {}
                for k in next, selected do s[#s+1] = k end
                return s
            end
            function dd:SetSelected(arr)
                for k in next, selected do
                    selected[k] = nil
                    if iBtns[k] then iBtns[k](false) end
                end
                for _, v in ipairs(arr) do
                    selected[v] = true
                    if iBtns[v] then iBtns[v](true) end
                end
                updCount()
            end
            if fl then Vula.Flags[fl] = dd end
            return dd
        end

        -- ColorPicker (fully implemented)
        function tab:CreateColorPicker(opts2)
            local cpName = opts2.Name or "Color"
            local default = opts2.Default or "#4a90d9"
            local fl = opts2.Flag
            local cb = opts2.Callback
            local curColor = hex(default)
            local row = ni("Frame", page, { Size = UDim2.new(1, 0, 0, mob and 56 or 46), BackgroundColor3 = th.Card, ZIndex = 5, LayoutOrder = eo() })
            C(row, 10)
            St(row, th.Stroke, 1, 0.24)
            ni("TextLabel", row, { Size = UDim2.new(0.70, 0, 0, 16), Position = UDim2.new(0, 12, 0, 7), BackgroundTransparency = 1, Text = cpName, TextColor3 = th.Text, Font = Enum.Font.GothamSemibold, TextSize = FONT_MD, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
            local preview = ni("Frame", row, { Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(1, -38, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = curColor, ZIndex = 6 })
            C(preview, 8)
            St(preview, th.Acc, 1, 0.30)

            local hit = ni("TextButton", preview, { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "", ZIndex = 7, AutoButtonColor = false })

            -- Create modal for color picker
            local function showPicker()
                local modal = ni("Frame", sg, { Size = UDim2.new(0, 260, 0, 220), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = th.Bg, ZIndex = 100, ClipsDescendants = true })
                C(modal, 12)
                St(modal, th.Stroke, 1, 0.2)

                local content = ni("Frame", modal, { Size = UDim2.new(1, -20, 1, -20), Position = UDim2.new(0, 10, 0, 10), BackgroundTransparency = 1 })
                LL(content, 8)
                Pd(content, 0, 0, 0, 0)

                ni("TextLabel", content, { Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1, Text = "Pick a Color", TextColor3 = th.Text, Font = Enum.Font.GothamBold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left })

                -- Convert current color to HSV
                local h, s, v = curColor:ToHSV()
                local function updatePreview()
                    curColor = Color3.fromHSV(h, s, v)
                    preview.BackgroundColor3 = curColor
                    if cb then cb(curColor) end
                end

                -- Hue slider
                local hueSlider = nil
                local function createSlider(name, min, max, inc, get, set, suffix)
                    -- We'll reuse the slider creation from within this context. For simplicity, we'll build a small slider manually.
                    -- But we can use the existing slider creator with a custom page? That would be messy.
                    -- Instead, we'll create simple sliders manually.
                    local sliderRow = ni("Frame", content, { Size = UDim2.new(1, 0, 0, 36), BackgroundTransparency = 1, LayoutOrder = 0 })
                    local label = ni("TextLabel", sliderRow, { Size = UDim2.new(0.5, -10, 1, 0), Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, Text = name, TextColor3 = th.Text, Font = Enum.Font.GothamSemibold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left })
                    local valueLabel = ni("TextLabel", sliderRow, { Size = UDim2.new(0.3, 0, 1, 0), Position = UDim2.new(0.7, 0, 0, 0), BackgroundTransparency = 1, Text = tostring(get()), TextColor3 = th.Acc, Font = Enum.Font.GothamBold, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Right })
                    local trackBg = ni("Frame", sliderRow, { Size = UDim2.new(1, 0, 0, 4), Position = UDim2.new(0, 0, 1, -8), AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = th.SliderTrack or th.Div, ZIndex = 6 })
                    C(trackBg, 2)
                    local trackFill = ni("Frame", trackBg, { Size = UDim2.new((get()-min)/(max-min), 0, 1, 0), BackgroundColor3 = th.Acc, ZIndex = 7 })
                    C(trackFill, 2)
                    local KS2 = mob and 14 or 12
                    local thumb = ni("Frame", trackBg, { Size = UDim2.new(0, KS2, 0, KS2), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new((get()-min)/(max-min), 0, 0.5, 0), BackgroundColor3 = th.Acc, ZIndex = 8 })
                    C(thumb, KS2//2)
                    local function setValue(val)
                        val = clamp(round(val, inc), min, max)
                        local pct = (val - min) / (max - min)
                        trackFill.Size = UDim2.new(pct, 0, 1, 0)
                        thumb.Position = UDim2.new(pct, 0, 0.5, 0)
                        valueLabel.Text = tostring(val)
                        set(val)
                        updatePreview()
                    end
                    local dragging = false
                    local hitArea = ni("TextButton", trackBg, { Size = UDim2.new(1, 0, 0, 30), Position = UDim2.new(0, 0, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Text = "", ZIndex = 9, AutoButtonColor = false })
                    hitArea.InputBegan:Connect(function(i)
                        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                            dragging = true
                            tw(thumb, { Size = UDim2.new(0, KS2*1.28, 0, KS2*1.28) }, 0.12, Enum.EasingStyle.Back)
                        end
                    end)
                    UIS.InputChanged:Connect(function(i)
                        if not dragging then return end
                        if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
                            local abs = trackBg.AbsolutePosition
                            local sz = trackBg.AbsoluteSize
                            local pct = clamp((UIS:GetMouseLocation().X - abs.X) / sz.X, 0, 1)
                            setValue(min + pct * (max - min))
                        end
                    end)
                    UIS.InputEnded:Connect(function(i)
                        if dragging and (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) then
                            dragging = false
                            tw(thumb, { Size = UDim2.new(0, KS2, 0, KS2) }, 0.22, Enum.EasingStyle.Back)
                        end
                    end)
                    return { set = setValue, get = function() return get() end }
                end

                local hueObj = createSlider("Hue", 0, 1, 0.01, function() return h end, function(v) h = v end, "")
                local satObj = createSlider("Saturation", 0, 1, 0.01, function() return s end, function(v) s = v end, "")
                local valObj = createSlider("Value", 0, 1, 0.01, function() return v end, function(v) v = v end, "")

                -- Done button
                local doneBtn = ni("TextButton", content, { Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = th.Acc, Text = "Done", TextColor3 = Color3.new(1,1,1), Font = Enum.Font.GothamBold, TextSize = 12, ZIndex = 10, AutoButtonColor = false })
                C(doneBtn, 8)
                doneBtn.MouseButton1Click:Connect(function()
                    modal:Destroy()
                end)
                doneBtn.MouseEnter:Connect(function() tw(doneBtn, { BackgroundColor3 = th.AccD }, 0.13) end)
                doneBtn.MouseLeave:Connect(function() tw(doneBtn, { BackgroundColor3 = th.Acc }, 0.13) end)
            end

            hit.MouseButton1Click:Connect(showPicker)

            local cp = { Type = "ColorPicker" }
            function cp:Get() return curColor end
            function cp:GetHex() return string.format("#%02x%02x%02x", curColor.R*255, curColor.G*255, curColor.B*255) end
            function cp:Set(c) curColor = c; preview.BackgroundColor3 = c end
            function cp:SetHex(h) curColor = hex(h); preview.BackgroundColor3 = curColor end
            if fl then Vula.Flags[fl] = cp end
            return cp
        end

        return tab
    end

    return Win
end

_g.VulaLoaded = true
_g.VulaLib = Vula
return Vula
