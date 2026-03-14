--[[
╔══════════════════════════════════════════════════════════╗
║  V U L A  ·  v4.1                                       ║
║  + 5 light themes  + rounder corners                    ║
║  + vertical side tab  + proper arrow icons              ║
╚══════════════════════════════════════════════════════════╝
]]

local Vula = { Flags = {}, Version = "4.1" }
local _g = type(getgenv) == "function" and getgenv() or {}
if _g.VulaLoaded then return _g.VulaLib end

local TS  = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Run = game:GetService("RunService")
local LP  = game:GetService("Players").LocalPlayer
local HS  = game:GetService("HttpService")

local function safeP()
    local ok, pg = pcall(function() return LP:WaitForChild("PlayerGui", 5) end)
    return (ok and pg) or LP.PlayerGui
end

-- ── Helpers ───────────────────────────────────────────────────────────────────
local function tw(o, p, d, s, dr)
    if not o or not o.Parent then return end
    TS:Create(o, TweenInfo.new(d or .26, s or Enum.EasingStyle.Quint, dr or Enum.EasingDirection.Out), p):Play()
end
local function ni(cls, par, props)
    local i = Instance.new(cls)
    if props then for k,v in pairs(props) do pcall(function() i[k]=v end) end end
    if par then i.Parent = par end
    return i
end
local function C(p,r)   ni("UICorner",p,{CornerRadius=UDim.new(0,r or 8)}) end
local function St(p,c,t,tr) return ni("UIStroke",p,{Color=c,Thickness=t or 1,Transparency=tr or 0,ApplyStrokeMode=Enum.ApplyStrokeMode.Border}) end
local function Pd(p,l,r,t,b) ni("UIPadding",p,{PaddingLeft=UDim.new(0,l),PaddingRight=UDim.new(0,r),PaddingTop=UDim.new(0,t),PaddingBottom=UDim.new(0,b)}) end
local function LL(p,g,align) ni("UIListLayout",p,{FillDirection=Enum.FillDirection.Vertical,HorizontalAlignment=align or Enum.HorizontalAlignment.Left,Padding=UDim.new(0,g or 0),SortOrder=Enum.SortOrder.LayoutOrder}) end
local function hex(s) s=s:gsub("#",""); return Color3.fromRGB(tonumber(s:sub(1,2),16),tonumber(s:sub(3,4),16),tonumber(s:sub(5,6),16)) end
local function rt(t) local o={} for k,v in pairs(t) do o[k]=type(v)=="string" and hex(v) or v end return o end
local function clamp(v,mn,mx) return math.max(mn,math.min(mx,v)) end
local function round(v,inc) return math.floor(v/inc+.5)*inc end

-- ── Themes ────────────────────────────────────────────────────────────────────
Vula.Theme = {
    -- ── Dark ─────────────────────────────────────────────────────────────────
    JJK = {
        Bg="060610", Top="0c0b1a", Side="09091a",
        Card="0f0e1e", CardH="16132a", Stroke="2c1828",
        Text="dce0f8", Dim="4a526e", SecLbl="c01a2e",
        Acc="c81c30", AccD="7a0c1c",
        TOn="c81c30", TOff="1c0e18", Knob="f5f5ff",
        TBOn="c81c30", TBOff="0d0c1c", TxtOn="ffffff", TxtOff="3a4262",
        Div="241420", InBg="08080e", Ph="38405a",
        Pill="0c0b1a", NBg="09091a",
        NInfo="4a90d9", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="1c0e1c", SliderFill="c81c30",
    },
    Default = {
        Bg="101010", Top="181818", Side="141414",
        Card="1c1c1c", CardH="242424", Stroke="2c2c2c",
        Text="e8e8e8", Dim="666666", SecLbl="4a90d9",
        Acc="4a90d9", AccD="2260a8",
        TOn="4a90d9", TOff="282828", Knob="f8f8f8",
        TBOn="4a90d9", TBOff="1c1c1c", TxtOn="ffffff", TxtOff="565656",
        Div="282828", InBg="121212", Ph="484848",
        Pill="1a1a1a", NBg="181818",
        NInfo="4a90d9", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="242424", SliderFill="4a90d9",
    },
    Midnight = {
        Bg="05060e", Top="090b1c", Side="07091a",
        Card="0c1026", CardH="121630", Stroke="1c2450",
        Text="c8d0ff", Dim="3e4a88", SecLbl="5c7aff",
        Acc="5c7aff", AccD="2c48d0",
        TOn="5c7aff", TOff="121828", Knob="eef0ff",
        TBOn="5c7aff", TBOff="0c1026", TxtOn="ffffff", TxtOff="384270",
        Div="182050", InBg="080a18", Ph="343c72",
        Pill="090b1c", NBg="090b1c",
        NInfo="5c7aff", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="182050", SliderFill="5c7aff",
    },
    Amethyst = {
        Bg="080510", Top="100c20", Side="0c0818",
        Card="140e24", CardH="1a122c", Stroke="3a2058",
        Text="dcd4ff", Dim="5a4490", SecLbl="9a58e8",
        Acc="9a58e8", AccD="5820a0",
        TOn="9a58e8", TOff="221438", Knob="ede8ff",
        TBOn="9a58e8", TBOff="140e24", TxtOn="ffffff", TxtOff="583c80",
        Div="2e1a4e", InBg="0a0818", Ph="4c3270",
        Pill="100c20", NBg="100c20",
        NInfo="9a58e8", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="2e1a4e", SliderFill="9a58e8",
    },
    Ocean = {
        Bg="040e12", Top="081820", Side="07141c",
        Card="0a1c28", CardH="10222e", Stroke="164050",
        Text="b8f0f2", Dim="387888", SecLbl="00b8c0",
        Acc="00b8c0", AccD="007080",
        TOn="00b8c0", TOff="0a2830", Knob="e0feff",
        TBOn="00b8c0", TBOff="0a1c28", TxtOn="ffffff", TxtOff="2c6880",
        Div="123650", InBg="060e14", Ph="285e6e",
        Pill="081820", NBg="081820",
        NInfo="00b8c0", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="123650", SliderFill="00b8c0",
    },
    Sakura = {
        Bg="0c0810", Top="1a1018", Side="140c14",
        Card="1e1420", CardH="261a28", Stroke="4c2040",
        Text="ffd8f0", Dim="784e68", SecLbl="e84890",
        Acc="e84890", AccD="882858",
        TOn="e84890", TOff="2e1422", Knob="fff0f5",
        TBOn="e84890", TBOff="1e1420", TxtOn="ffffff", TxtOff="6c385a",
        Div="461838", InBg="0c080e", Ph="5c2e4e",
        Pill="1a1018", NBg="1a1018",
        NInfo="e84890", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="461838", SliderFill="e84890",
    },
    Neon = {
        Bg="030303", Top="060606", Side="050505",
        Card="0a0a0a", CardH="101010", Stroke="1a3a1a",
        Text="ccffcc", Dim="3a7a3a", SecLbl="00ff88",
        Acc="00ff88", AccD="009950",
        TOn="00ff88", TOff="0a1a10", Knob="e0ffe8",
        TBOn="00ff88", TBOff="0a0a0a", TxtOn="000000", TxtOff="2a5a2a",
        Div="0a2a0a", InBg="060606", Ph="1a4a1a",
        Pill="060606", NBg="060606",
        NInfo="00ccff", NSucc="00ff88", NWarn="ffcc00", NErr="ff3344",
        SliderTrack="0a1a0a", SliderFill="00ff88",
    },
    Sunset = {
        Bg="0c0608", Top="180c10", Side="140a0c",
        Card="1c1010", CardH="241414", Stroke="4a2020",
        Text="ffd8c0", Dim="7a5040", SecLbl="ff7040",
        Acc="ff6030", AccD="c03010",
        TOn="ff6030", TOff="2a1010", Knob="fff0e8",
        TBOn="ff6030", TBOff="1c1010", TxtOn="ffffff", TxtOff="6a3828",
        Div="3a1c14", InBg="0e0a08", Ph="5a3020",
        Pill="180c10", NBg="180c10",
        NInfo="ff9050", NSucc="50d080", NWarn="ffcc30", NErr="ff3344",
        SliderTrack="3a1c14", SliderFill="ff6030",
    },
    -- ── Light collection ──────────────────────────────────────────────────────
    Light = {
        Bg="f2f2f6", Top="e6e6ec", Side="ebebf0",
        Card="fafafa", CardH="f0f0f8", Stroke="d0d0da",
        Text="18181e", Dim="8888a0", SecLbl="2870d8",
        Acc="2870d8", AccD="184fa0",
        TOn="2870d8", TOff="c4c4d4", Knob="ffffff",
        TBOn="2870d8", TBOff="f2f2f6", TxtOn="ffffff", TxtOff="9090a8",
        Div="d0d0da", InBg="e8e8ee", Ph="9898b0",
        Pill="e6e6ec", NBg="fafafa",
        NInfo="2870d8", NSucc="18a050", NWarn="d08010", NErr="d83020",
        SliderTrack="d0d0da", SliderFill="2870d8",
    },
    -- Warm white with honey accents
    Cream = {
        Bg="fdf8f0", Top="f5ede0", Side="f0e8d8",
        Card="ffffff", CardH="fdf4e8", Stroke="e8d8c0",
        Text="2c2018", Dim="9a8070", SecLbl="b86020",
        Acc="d47820", AccD="9a5010",
        TOn="d47820", TOff="e8d0b0", Knob="ffffff",
        TBOn="d47820", TBOff="fdf8f0", TxtOn="ffffff", TxtOff="a89080",
        Div="e8d8c0", InBg="f5ede0", Ph="b09880",
        Pill="f5ede0", NBg="ffffff",
        NInfo="5890d8", NSucc="28a858", NWarn="d47820", NErr="c83030",
        SliderTrack="e8d8c0", SliderFill="d47820",
    },
    -- Soft lavender
    Lavender = {
        Bg="f4f0fa", Top="ebe4f8", Side="ede6f8",
        Card="ffffff", CardH="f0eaff", Stroke="d8ceee",
        Text="201838", Dim="8878b0", SecLbl="7050d8",
        Acc="7050d8", AccD="4828a8",
        TOn="7050d8", TOff="d0c8ec", Knob="ffffff",
        TBOn="7050d8", TBOff="f4f0fa", TxtOn="ffffff", TxtOff="9888c0",
        Div="d8ceee", InBg="ebe4f8", Ph="a898c8",
        Pill="ebe4f8", NBg="ffffff",
        NInfo="5080e0", NSucc="28a858", NWarn="c88020", NErr="d03030",
        SliderTrack="d8ceee", SliderFill="7050d8",
    },
    -- Cool minty
    Mint = {
        Bg="f0faf6", Top="e0f4ec", Side="e4f6ee",
        Card="ffffff", CardH="e8fff4", Stroke="c0e8d4",
        Text="102820", Dim="6a9880", SecLbl="189868",
        Acc="189868", AccD="0c7048",
        TOn="189868", TOff="b8e0d0", Knob="ffffff",
        TBOn="189868", TBOff="f0faf6", TxtOn="ffffff", TxtOff="7aaa90",
        Div="c0e8d4", InBg="e0f4ec", Ph="90c0a8",
        Pill="e0f4ec", NBg="ffffff",
        NInfo="2890d8", NSucc="189868", NWarn="c88020", NErr="d03030",
        SliderTrack="c0e8d4", SliderFill="189868",
    },
    -- Warm peachy pink
    Peach = {
        Bg="fff4f0", Top="ffe8e0", Side="fdeae2",
        Card="ffffff", CardH="fff0ea", Stroke="f0cfc4",
        Text="301810", Dim="b08878", SecLbl="e05838",
        Acc="e05838", AccD="a83018",
        TOn="e05838", TOff="f0c8bc", Knob="ffffff",
        TBOn="e05838", TBOff="fff4f0", TxtOn="ffffff", TxtOff="c09888",
        Div="f0cfc4", InBg="ffe8e0", Ph="c0a898",
        Pill="ffe8e0", NBg="ffffff",
        NInfo="4888d8", NSucc="28a858", NWarn="d48018", NErr="e03030",
        SliderTrack="f0cfc4", SliderFill="e05838",
    },
    -- Cool blue-grey
    Slate = {
        Bg="f0f4f8", Top="e4eaf0", Side="e8eef4",
        Card="ffffff", CardH="edf2f8", Stroke="c8d4e0",
        Text="182030", Dim="7888a0", SecLbl="3868b8",
        Acc="3868b8", AccD="1c4888",
        TOn="3868b8", TOff="c0cedd", Knob="ffffff",
        TBOn="3868b8", TBOff="f0f4f8", TxtOn="ffffff", TxtOff="8898b0",
        Div="c8d4e0", InBg="e4eaf0", Ph="9aaabb",
        Pill="e4eaf0", NBg="ffffff",
        NInfo="3868b8", NSucc="28a858", NWarn="c88020", NErr="d03030",
        SliderTrack="c8d4e0", SliderFill="3868b8",
    },
    -- Rose gold
    RoseGold = {
        Bg="fdf0f0", Top="f8e4e4", Side="f5e6e6",
        Card="ffffff", CardH="fdeaea", Stroke="ecc8c8",
        Text="300c0c", Dim="b08888", SecLbl="c84860",
        Acc="c84860", AccD="902030",
        TOn="c84860", TOff="ecc0c8", Knob="ffffff",
        TBOn="c84860", TBOff="fdf0f0", TxtOn="ffffff", TxtOff="c09898",
        Div="ecc8c8", InBg="f8e4e4", Ph="c0a0a0",
        Pill="f8e4e4", NBg="ffffff",
        NInfo="5080c8", NSucc="289858", NWarn="c88028", NErr="d03030",
        SliderTrack="ecc8c8", SliderFill="c84860",
    },
}

-- ── Notify ────────────────────────────────────────────────────────────────────
local _nsg, _nst = nil, {}
local NW, NH, NG = 230, 48, 4
-- Better arrow/icon chars
local NOTIFY_ICON = { info="•", success="✓", warn="!", error="✕" }
local NOTIFY_COL  = { info="NInfo", success="NSucc", warn="NWarn", error="NErr" }

local function getNSG()
    if _nsg and _nsg.Parent then return _nsg end
    _nsg = ni("ScreenGui", safeP(), {Name="VulaNotifs",DisplayOrder=200,ResetOnSpawn=false})
    return _nsg
end
local function repack()
    local vpH = workspace.CurrentCamera.ViewportSize.Y
    for i,f in ipairs(_nst) do
        if f and f.Parent then tw(f,{Position=UDim2.new(1,-6,1-(i*(NH+NG)/vpH),0)},.35,Enum.EasingStyle.Back) end
    end
end

function Vula:Notify(o)
    local T=o.Title or "Vula"; local C2=o.Content or ""
    local D=o.Duration or 4;   local typ=o.Type or "info"
    local th=self._theme or rt(Vula.Theme.Default)
    local nCol=th[NOTIFY_COL[typ] or "NInfo"] or th.Acc
    if #_nst>=4 then local x=table.remove(_nst,1); if x and x.Parent then x:Destroy() end end
    local idx=#_nst+1
    local vpH=workspace.CurrentCamera.ViewportSize.Y
    local sy=1-idx*(NH+NG)/vpH
    local f=ni("Frame",getNSG(),{Size=UDim2.new(0,NW,0,NH),AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1.08,0,sy,0),BackgroundColor3=th.NBg,ZIndex=10})
    C(f,12); St(f,th.Stroke,1,.1)
    ni("Frame",f,{Size=UDim2.new(1,0,0,2),BackgroundColor3=nCol,BackgroundTransparency=.0,ZIndex=12}); C(ni("Frame",f,{Size=UDim2.new(1,0,0,2),BackgroundColor3=nCol,ZIndex=12}),12)
    local lb=ni("Frame",f,{Size=UDim2.new(0,3,.5,0),Position=UDim2.new(0,8,.25,0),BackgroundColor3=nCol,ZIndex=12}); C(lb,2)
    local ic=ni("Frame",f,{Size=UDim2.new(0,18,0,18),Position=UDim2.new(0,14,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=nCol,BackgroundTransparency=.82,ZIndex=12}); C(ic,9)
    ni("TextLabel",ic,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=NOTIFY_ICON[typ] or "•",TextColor3=nCol,Font=Enum.Font.GothamBold,TextSize=10,ZIndex=13})
    local tl=ni("TextLabel",f,{Size=UDim2.new(1,-46,0,15),Position=UDim2.new(0,38,0,7),BackgroundTransparency=1,Text=T,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=1,ZIndex=12})
    local bl=ni("TextLabel",f,{Size=UDim2.new(1,-46,0,13),Position=UDim2.new(0,38,0,24),BackgroundTransparency=1,Text=C2,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,TextTransparency=1,ZIndex=12})
    local bg=ni("Frame",f,{Size=UDim2.new(1,-16,0,2),Position=UDim2.new(0,8,1,-2),AnchorPoint=Vector2.new(0,1),BackgroundColor3=th.Div,ZIndex=12}); C(bg,1)
    local bf=ni("Frame",bg,{Size=UDim2.new(1,0,1,0),BackgroundColor3=nCol,ZIndex=13}); C(bf,1)
    _nst[idx]=f
    tw(f,{Position=UDim2.new(1,-6,sy,0)},.4,Enum.EasingStyle.Back)
    task.delay(.06,function() tw(tl,{TextTransparency=0},.18); tw(bl,{TextTransparency=.22},.18) end)
    task.delay(.12,function() if bf.Parent then tw(bf,{Size=UDim2.new(0,0,1,0)},D-.12,Enum.EasingStyle.Linear) end end)
    local done=false
    local function dis()
        if done then return end; done=true
        tw(tl,{TextTransparency=1},.14); tw(bl,{TextTransparency=1},.14)
        tw(f,{BackgroundTransparency=1,Position=UDim2.new(1.07,0,sy,0)},.22,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
        task.delay(.25,function() for i,n in ipairs(_nst) do if n==f then table.remove(_nst,i);break end end; if f.Parent then f:Destroy() end; repack() end)
    end
    f.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dis() end end)
    task.delay(D,dis); repack()
end

-- ── Config ────────────────────────────────────────────────────────────────────
local CFG_FILE = "vula_config.json"
function Vula:SaveConfig()
    local data={}
    for k,v in pairs(self.Flags) do
        if type(v)=="table" then
            if     v.Type=="Toggle"   then data[k]=v.CurrentValue
            elseif v.Type=="Dropdown" then data[k]=v:GetSelected()
            elseif v.Type=="Keybind"  then data[k]=v.CurrentKeybind
            elseif v.Type=="Slider"   then data[k]=v:Get()
            elseif v.Type=="Input"    then data[k]=v:Get()
            end
        end
    end
    local ok,enc=pcall(function() return HS:JSONEncode(data) end)
    if ok then pcall(writefile,CFG_FILE,enc); self:Notify({Title="Config",Content="Saved ✓",Duration=2.5,Type="success"})
    else self:Notify({Title="Config",Content="Save failed.",Duration=2.5,Type="error"}) end
end
function Vula:LoadConfig()
    local ok,raw=pcall(readfile,CFG_FILE)
    if not ok or not raw then self:Notify({Title="Config",Content="No save found.",Duration=2.5,Type="warn"}); return end
    local ok2,data=pcall(function() return HS:JSONDecode(raw) end)
    if not ok2 or type(data)~="table" then return end
    for k,v in pairs(data) do
        local flag=self.Flags[k]
        if flag and type(flag)=="table" then
            if     flag.Type=="Toggle"   then flag:Set(v)
            elseif flag.Type=="Dropdown" then flag:SetSelected(type(v)=="table" and v or {v})
            elseif flag.Type=="Keybind"  then flag:Set(v)
            elseif flag.Type=="Slider"   then flag:Set(v)
            elseif flag.Type=="Input"    then flag:Set(v)
            end
        end
    end
    self:Notify({Title="Config",Content="Loaded ✓",Duration=2.5,Type="success"})
end

-- ── CreateWindow ──────────────────────────────────────────────────────────────
function Vula:CreateWindow(opts)
    local title  = opts.Name            or "Vula"
    local loadT  = opts.LoadingTitle    or title
    local loadS  = opts.LoadingSubtitle or "Loading..."
    local tname  = opts.Theme           or "Default"
    local th     = rt(Vula.Theme[tname] or Vula.Theme.Default)
    self._theme  = th

    local vp  = workspace.CurrentCamera.ViewportSize
    local mob = vp.X < 700
    local WW  = mob and math.min(340,vp.X-16) or 340
    local WH  = opts.Height or (mob and math.min(280,vp.Y-80) or 265)
    local TOP_H  = 38
    local SIDE_W = 108

    local par = safeP()
    pcall(function() for _,c in ipairs(par:GetChildren()) do if c.Name=="Vula" then c:Destroy() end end end)
    local sg = ni("ScreenGui",par,{Name="Vula",DisplayOrder=100,ResetOnSpawn=false})

    -- Shadow
    local shadow=ni("Frame",sg,{Size=UDim2.new(0,WW+24,0,WH+24),Position=UDim2.new(.5,3,.5,-38+6),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Acc,BackgroundTransparency=.92,ZIndex=1}); C(shadow,18)

    -- Main
    local Main=ni("Frame",sg,{Name="Main",Size=UDim2.new(0,WW,0,WH),Position=UDim2.new(.5,3,.5,-38),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Bg,ZIndex=2,ClipsDescendants=true})
    C(Main,14)   -- ← rounder main window
    St(Main,th.Stroke,1,.15)

    -- Corner glow accent
    local ac=ni("Frame",Main,{Size=UDim2.new(0,60,0,60),Position=UDim2.new(0,-18,0,-18),BackgroundColor3=th.Acc,BackgroundTransparency=.9,ZIndex=2}); C(ac,30)

    -- ── Topbar ────────────────────────────────────────────────────────────────
    local TB=ni("Frame",Main,{Size=UDim2.new(1,0,0,TOP_H),BackgroundColor3=th.Top,ZIndex=5})
    C(TB,14)
    ni("Frame",TB,{Size=UDim2.new(1,0,.5,0),Position=UDim2.new(0,0,.5,0),BackgroundColor3=th.Top,ZIndex=5})
    ni("Frame",TB,{Size=UDim2.new(1,0,0,1),BackgroundColor3=th.Acc,BackgroundTransparency=.05,ZIndex=8})
    ni("Frame",TB,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=th.Div,BackgroundTransparency=.3,ZIndex=6})

    -- Badge
    local bdg=ni("Frame",TB,{Size=UDim2.new(0,22,0,22),Position=UDim2.new(0,10,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.Acc,ZIndex=6}); C(bdg,11)
    ni("UIGradient",bdg,{Rotation=135,ColorSequence=ColorSequence.new(th.Acc,th.AccD)})
    ni("TextLabel",bdg,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="V",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=11,ZIndex=7})

    ni("TextLabel",TB,{Size=UDim2.new(1,-110,0,18),Position=UDim2.new(0,37,0,4),BackgroundTransparency=1,Text=title,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
    local subLbl=ni("TextLabel",TB,{Size=UDim2.new(1,-110,0,11),Position=UDim2.new(0,37,0,23),BackgroundTransparency=1,Text="v4.1 · "..tname,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})

    -- macOS orbs
    local function mkOrb(xOff,col,sym)
        local o=ni("TextButton",TB,{Size=UDim2.new(0,12,0,12),Position=UDim2.new(1,xOff,.5,0),AnchorPoint=Vector2.new(1,.5),BackgroundColor3=col,BackgroundTransparency=.08,Text="",ZIndex=7,AutoButtonColor=false}); C(o,6)
        local l=ni("TextLabel",o,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=sym,TextColor3=Color3.fromRGB(20,10,10),Font=Enum.Font.GothamBold,TextSize=7,TextTransparency=1,ZIndex=8})
        o.MouseEnter:Connect(function() tw(o,{BackgroundTransparency=0},.1); tw(l,{TextTransparency=0},.1) end)
        o.MouseLeave:Connect(function() tw(o,{BackgroundTransparency=.08},.1); tw(l,{TextTransparency=1},.1) end)
        return o
    end
    local oClose=mkOrb(-10,Color3.fromRGB(255,59,48),"✕")
    local oMin  =mkOrb(-26,Color3.fromRGB(255,149,0),"–")

    -- Topbar drag
    do
        local dr,dsx,dsy,ox,oy=false,0,0,0,0
        TB.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end
            dr=true; local m=UIS:GetMouseLocation(); dsx,dsy=m.X,m.Y
            ox=Main.Position.X.Offset; oy=Main.Position.Y.Offset
            local c; c=Run.RenderStepped:Connect(function()
                if not dr then c:Disconnect(); return end
                local m2=UIS:GetMouseLocation()
                Main.Position=UDim2.new(.5,ox+(m2.X-dsx),.5,oy+(m2.Y-dsy))
                shadow.Position=UDim2.new(.5,ox+(m2.X-dsx)+3,.5,oy+(m2.Y-dsy)+6)
            end)
        end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
    end

    -- ── Sidebar ───────────────────────────────────────────────────────────────
    local SB=ni("Frame",Main,{Size=UDim2.new(0,SIDE_W,1,-TOP_H),Position=UDim2.new(0,0,0,TOP_H),BackgroundColor3=th.Side,ZIndex=4})
    ni("Frame",SB,{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=th.Div,BackgroundTransparency=.25,ZIndex=5})
    local tabSF=ni("ScrollingFrame",SB,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(0,0,0,0),ZIndex=5})
    LL(tabSF,3); Pd(tabSF,6,4,8,6)

    -- ── Content ───────────────────────────────────────────────────────────────
    local Cont=ni("Frame",Main,{Size=UDim2.new(1,-SIDE_W,1,-TOP_H),Position=UDim2.new(0,SIDE_W,0,TOP_H),BackgroundTransparency=1,ClipsDescendants=true,ZIndex=3})

    -- ── Loading ───────────────────────────────────────────────────────────────
    local LD=ni("Frame",Main,{Size=UDim2.new(1,0,1,0),BackgroundColor3=th.Bg,ZIndex=25}); C(LD,14)
    local ldb=ni("Frame",LD,{Size=UDim2.new(0,44,0,44),Position=UDim2.new(.5,0,.32,0),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Acc,ZIndex=26}); C(ldb,22)
    ni("UIGradient",ldb,{Rotation=135,ColorSequence=ColorSequence.new(th.Acc,th.AccD)})
    ni("TextLabel",ldb,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="V",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=18,ZIndex=27})
    ni("TextLabel",LD,{Size=UDim2.new(.9,0,0,18),Position=UDim2.new(.05,0,.44,0),BackgroundTransparency=1,Text=loadT,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=12,ZIndex=26})
    ni("TextLabel",LD,{Size=UDim2.new(.9,0,0,14),Position=UDim2.new(.05,0,.56,0),BackgroundTransparency=1,Text=loadS,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=9,ZIndex=26})
    local lbg=ni("Frame",LD,{Size=UDim2.new(.65,0,0,2),Position=UDim2.new(.175,0,.67,0),BackgroundColor3=th.Div,ZIndex=26}); C(lbg,1)
    local lfl=ni("Frame",lbg,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Acc,ZIndex=27}); C(lfl,1)
    task.spawn(function()
        tw(lfl,{Size=UDim2.new(1,0,1,0)},1.3,Enum.EasingStyle.Quint); task.wait(1.6)
        tw(LD,{BackgroundTransparency=1},.3)
        for _,d in ipairs(LD:GetDescendants()) do
            if d:IsA("TextLabel") then tw(d,{TextTransparency=1},.22)
            elseif d:IsA("Frame") then tw(d,{BackgroundTransparency=1},.22) end
        end
        task.wait(.35); LD.Visible=false
    end)

    -- ── Vertical side opener ──────────────────────────────────────────────────
    -- A slim tab anchored to the right edge, draggable vertically
    local TAB_W, TAB_H = 22, 90
    local SideTab = ni("Frame", sg, {
        Size    = UDim2.new(0, TAB_W, 0, TAB_H),
        Position= UDim2.new(1, 0, .5, -TAB_H/2),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = th.Pill,
        ZIndex  = 55,
    })
    -- Round only the left side by using a large corner radius
    C(SideTab, TAB_W // 2)
    St(SideTab, th.Acc, 1, .1)
    ni("UIGradient", SideTab, {
        Rotation = 0,
        ColorSequence = ColorSequence.new(th.Acc, th.Pill),
        Transparency  = NumberSequence.new({NumberSequenceKeypoint.new(0,.84),NumberSequenceKeypoint.new(1,.96)}),
    })

    -- Pulsing dot (active loops indicator)
    local pillDot = ni("Frame", SideTab, {
        Size=UDim2.new(0,6,0,6), Position=UDim2.new(.5,0,0,8),
        AnchorPoint=Vector2.new(.5,0), BackgroundColor3=th.Acc,
        BackgroundTransparency=1, ZIndex=57,
    }); C(pillDot, 3)

    -- Vertical label: icon arrow + short title stacked
    -- Arrow indicator: ◀ when open (click to close), ▶ when hidden (click to open)
    local arrowLbl = ni("TextLabel", SideTab, {
        Size=UDim2.new(1,0,0,16), Position=UDim2.new(0,0,0,22),
        BackgroundTransparency=1, Text="◀",
        TextColor3=th.Acc, Font=Enum.Font.GothamBold, TextSize=11, ZIndex=57,
    })
    -- Vertical title (rotated via two-char lines)
    local vTitle = ni("TextLabel", SideTab, {
        Size=UDim2.new(1,0,0,50), Position=UDim2.new(0,0,0,40),
        BackgroundTransparency=1,
        Text="·\nG\nU\nI",
        TextColor3=th.Dim, Font=Enum.Font.GothamBold, TextSize=8,
        LineHeight=1.3, ZIndex=56,
    })

    -- Drag SideTab vertically
    do
        local dr,dsy,sy0=false,0,0; local dc
        SideTab.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end
            dr=true; dsy=UIS:GetMouseLocation().Y; sy0=SideTab.Position.Y.Offset
            if dc then dc:Disconnect() end
            dc=Run.Heartbeat:Connect(function()
                if not dr then dc:Disconnect(); return end
                SideTab.Position=UDim2.new(1,0,.5,(sy0+(UIS:GetMouseLocation().Y-dsy)))
            end)
        end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
    end

    -- ── Open / Close ──────────────────────────────────────────────────────────
    local Hidden, Minimised, Deb = false, false, false
    local OPEN_POS  = UDim2.new(.5, 3, .5, -38)

    local function open()
        if Deb then return end; Deb=true; Hidden=false
        shadow.Visible=true; Main.Visible=true
        Main.BackgroundTransparency=1
        Main.Position=UDim2.new(.5,3,.5,-38+12)
        -- fade + slide up into position
        tw(Main,{BackgroundTransparency=0,Position=OPEN_POS},.32,Enum.EasingStyle.Back)
        arrowLbl.Text="◀"
        task.delay(.36,function() Deb=false end)
    end
    local function close(silent)
        if Deb then return end; Deb=true; Hidden=true
        -- slide down + fade out
        tw(Main,{BackgroundTransparency=1,Position=UDim2.new(.5,3,.5,-38+10)},.2,Enum.EasingStyle.Quint,Enum.EasingDirection.In)
        arrowLbl.Text="▶"
        task.delay(.22,function() Main.Visible=false; shadow.Visible=false; Main.Position=OPEN_POS; Deb=false end)
        if not silent then Vula:Notify({Title="Hidden",Content="Side tab to reopen.",Duration=3,Type="info"}) end
    end
    local function toggle() if Hidden then open() else close(true) end end

    oClose.MouseButton1Click:Connect(function() close(true) end)
    oMin.MouseButton1Click:Connect(function()
        Minimised=not Minimised
        if Minimised then
            SB.Visible=false; Cont.Visible=false
            tw(Main,{Size=UDim2.new(0,WW,0,TOP_H)},.24)
        else
            tw(Main,{Size=UDim2.new(0,WW,0,WH)},.34,Enum.EasingStyle.Back)
            task.delay(.14,function() SB.Visible=true; Cont.Visible=true end)
        end
    end)

    -- SideTab click to toggle (only when not dragging)
    local tabDragMoved = false
    SideTab.InputBegan:Connect(function(i,gpe)
        if gpe then return end
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            tabDragMoved=false
        end
    end)
    SideTab.InputChanged:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
            tabDragMoved=true
        end
    end)
    SideTab.InputEnded:Connect(function(i,gpe)
        if gpe then return end
        if (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) and not tabDragMoved then
            toggle()
        end
    end)
    -- Hover expand
    SideTab.MouseEnter:Connect(function() tw(SideTab,{Size=UDim2.new(0,TAB_W+5,0,TAB_H)},.16,Enum.EasingStyle.Back) end)
    SideTab.MouseLeave:Connect(function() tw(SideTab,{Size=UDim2.new(0,TAB_W,0,TAB_H)},.14) end)

    UIS.InputBegan:Connect(function(i,gpe) if gpe then return end; if i.KeyCode==Enum.KeyCode.RightShift then toggle() end end)

    -- ── Tab system ────────────────────────────────────────────────────────────
    local _tabs, _btns, _act = {}, {}, 0
    local function selTab(idx)
        if _act==idx then return end
        for i,t in ipairs(_tabs) do
            t.page.Visible=(i==idx)
            local b=_btns[i]; if not b then continue end
            local lbl=b:FindFirstChildWhichIsA("TextLabel")
            local bar=b:FindFirstChild("_b")
            local aBg=b:FindFirstChild("_abg")
            local ico=b:FindFirstChild("_ico")
            if i==idx then
                tw(b,  {BackgroundColor3=th.TBOn, BackgroundTransparency=0},   .2)
                if aBg then tw(aBg,{BackgroundTransparency=.88},.2) end
                if lbl then tw(lbl,{TextColor3=th.TxtOn, TextTransparency=0},.16) end
                if bar then tw(bar,{BackgroundTransparency=0,BackgroundColor3=th.Acc},.16) end
                if ico then tw(ico,{ImageColor3=th.Acc},.16) end
            else
                tw(b,  {BackgroundColor3=th.TBOff, BackgroundTransparency=.72}, .2)
                if aBg then tw(aBg,{BackgroundTransparency=1},.2) end
                if lbl then tw(lbl,{TextColor3=th.TxtOff, TextTransparency=.25},.16) end
                if bar then tw(bar,{BackgroundTransparency=1},.16) end
                if ico then tw(ico,{ImageColor3=th.TxtOff},.16) end
            end
        end
        _act=idx
    end

    -- ── Win object ────────────────────────────────────────────────────────────
    local Win={_sg=sg}

    function Win:Destroy()
        if sg and sg.Parent then sg:Destroy() end
        if shadow and shadow.Parent then shadow:Destroy() end
    end

    function Win:SetTheme(name)
        local newTh=rt(Vula.Theme[name] or Vula.Theme.Default)
        local function c3k(c) return math.floor(c.R*255+.5)..","..math.floor(c.G*255+.5)..","..math.floor(c.B*255+.5) end
        local remap={}
        for k in pairs(th) do
            local ov=th[k]; local nv=newTh[k]
            if type(ov)=="userdata" and type(nv)=="userdata" then remap[c3k(ov)]=nv end
        end
        th=newTh; Vula._theme=newTh
        local D=.28
        for _,inst in ipairs(sg:GetDescendants()) do
            pcall(function()
                if inst:IsA("Frame") or inst:IsA("TextButton") or inst:IsA("ScrollingFrame") then
                    local nc=remap[c3k(inst.BackgroundColor3)]; if nc then tw(inst,{BackgroundColor3=nc},D) end
                end
                if inst:IsA("TextLabel") or inst:IsA("TextButton") then
                    local nc=remap[c3k(inst.TextColor3)]; if nc then tw(inst,{TextColor3=nc},D) end
                end
                if inst:IsA("UIStroke") then
                    local nc=remap[c3k(inst.Color)]; if nc then tw(inst,{Color=nc},D) end
                end
                if inst:IsA("ImageLabel") then
                    local nc=remap[c3k(inst.ImageColor3)]; if nc then tw(inst,{ImageColor3=nc},D) end
                end
            end)
        end
        subLbl.Text="v4.1 · "..name
        Vula:Notify({Title="Theme",Content=name.." applied.",Duration=2.5,Type="success"})
    end

    function Win:SetPillActive(active)
        tw(pillDot,{BackgroundTransparency=active and 0 or 1},.2)
        if active then
            task.spawn(function()
                while pillDot.Parent and pillDot.BackgroundTransparency < .5 do
                    tw(pillDot,{BackgroundTransparency=.6},.6,Enum.EasingStyle.Sine); task.wait(.65)
                    if pillDot.Parent then tw(pillDot,{BackgroundTransparency=0},.6,Enum.EasingStyle.Sine); task.wait(.65) end
                end
            end)
        end
    end

    function Win:CreateTab(name, icon)
        local idx=#_tabs+1; local first=(idx==1)
        local iconId=nil
        local ICONS={
            sword="rbxassetid://7743874695",shield="rbxassetid://7734053495",
            star="rbxassetid://7734053502",bolt="rbxassetid://7734053474",
            refresh="rbxassetid://7734053484",gift="rbxassetid://7734053477",
            settings="rbxassetid://7734053488",skull="rbxassetid://7734053491",
            dice="rbxassetid://7734053494",
        }
        if icon then iconId=ICONS[icon] or (icon:find("rbxassetid") and icon) end

        local btn=ni("TextButton",tabSF,{Name="T_"..name,Size=UDim2.new(1,0,0,32),BackgroundColor3=first and th.TBOn or th.TBOff,BackgroundTransparency=first and 0 or .72,Text="",ZIndex=6,AutoButtonColor=false,LayoutOrder=idx})
        C(btn, 10)  -- ← rounder tab buttons

        local bar=ni("Frame",btn,{Name="_b",Size=UDim2.new(0,3,.52,0),Position=UDim2.new(0,0,.24,0),BackgroundColor3=th.Acc,BackgroundTransparency=first and 0 or 1,ZIndex=7}); C(bar,2)
        local aBg=ni("Frame",btn,{Name="_abg",Size=UDim2.new(1,0,1,0),BackgroundColor3=th.Acc,BackgroundTransparency=first and .88 or 1,ZIndex=6}); C(aBg,10)

        local textX=iconId and 32 or 10
        if iconId then
            local ico=ni("ImageLabel",btn,{Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,10,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundTransparency=1,Image=iconId,ImageColor3=first and th.Acc or th.TxtOff,ZIndex=8})
            ico.Name="_ico"
        end
        local lbl=ni("TextLabel",btn,{Size=UDim2.new(1,-textX-6,1,0),Position=UDim2.new(0,textX,0,0),BackgroundTransparency=1,Text=name,TextColor3=first and th.TxtOn or th.TxtOff,Font=Enum.Font.GothamBold,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=first and 0 or .25,ZIndex=7})

        btn.MouseButton1Click:Connect(function() selTab(idx) end)
        btn.MouseEnter:Connect(function() if _act~=idx then tw(btn,{BackgroundTransparency=.28},.13) end end)
        btn.MouseLeave:Connect(function() if _act~=idx then tw(btn,{BackgroundTransparency=.72},.13) end end)

        local page=ni("ScrollingFrame",Cont,{Name="P_"..name,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=th.Acc,ScrollBarImageTransparency=.4,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(0,0,0,0),Visible=first,ZIndex=4,ClipsDescendants=true})
        LL(page,5); Pd(page,6,6,8,8)

        local tab={page=page,_n=0}; _tabs[idx]=tab; _btns[idx]=btn
        if first then _act=1 end
        local function eo() tab._n=tab._n+1; return tab._n end

        -- ── Section ──────────────────────────────────────────────────────────
        function tab:CreateSection(s)
            local sf=ni("Frame",page,{Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,ZIndex=4,LayoutOrder=eo()})
            local dot=ni("Frame",sf,{Size=UDim2.new(0,4,0,4),Position=UDim2.new(0,2,0,9),BackgroundColor3=th.Acc,ZIndex=5}); C(dot,2)
            ni("TextLabel",sf,{Size=UDim2.new(1,-14,0,14),Position=UDim2.new(0,10,0,4),BackgroundTransparency=1,Text=s:upper(),TextColor3=th.SecLbl,Font=Enum.Font.GothamBold,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5})
            local dl=ni("Frame",sf,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=th.Acc,BackgroundTransparency=.55,ZIndex=5})
            ni("UIGradient",dl,{Rotation=0,Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,.3),NumberSequenceKeypoint.new(.4,.6),NumberSequenceKeypoint.new(1,1)})})
        end

        -- ── Toggle ────────────────────────────────────────────────────────────
        function tab:CreateToggle(o)
            local tN=o.Name or "Toggle"; local dV=o.CurrentValue or false
            local fl=o.Flag; local cb=o.Callback; local val=dV
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,36),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            C(row,9); row:SetAttribute("origH",36)  -- ← rounder cards
            local rSt=St(row,th.Stroke,1,.26)
            local la=ni("Frame",row,{Size=UDim2.new(0,3,.46,0),Position=UDim2.new(0,0,.27,0),BackgroundColor3=th.Acc,BackgroundTransparency=val and .14 or 1,ZIndex=6}); C(la,2)
            local dot=ni("Frame",row,{Size=UDim2.new(0,5,0,5),Position=UDim2.new(0,12,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.Acc,BackgroundTransparency=val and .1 or 1,ZIndex=7}); C(dot,3)
            local nameLbl=ni("TextLabel",row,{Size=UDim2.new(1,-66,1,0),Position=UDim2.new(0,21,0,0),BackgroundTransparency=1,Text=tN,TextColor3=val and th.Text or th.Dim,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local PW,PH,KS=38,20,14; local K0,K1=2,20
            local pill=ni("Frame",row,{Size=UDim2.new(0,PW,0,PH),Position=UDim2.new(1,-(PW+8),.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=val and th.TOn or th.TOff,ZIndex=6}); C(pill,PH//2)
            local pSt=St(pill,val and th.TOn or th.Stroke,1,val and .32 or .08)
            local knob=ni("Frame",pill,{Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,val and K1 or K0,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.Knob,ZIndex=7}); C(knob,KS//2)
            St(knob,Color3.new(0,0,0),1,.88)
            local dotLoop
            local function startDot()
                if dotLoop then return end
                dotLoop=task.spawn(function()
                    while dot.Parent and dot.BackgroundTransparency<.5 do
                        tw(dot,{BackgroundTransparency=.6},.55,Enum.EasingStyle.Sine); task.wait(.6)
                        if dot.Parent then tw(dot,{BackgroundTransparency=.05},.55,Enum.EasingStyle.Sine); task.wait(.6) end
                    end
                end)
            end
            local function stopDot() if dotLoop then task.cancel(dotLoop); dotLoop=nil end end
            local tog={CurrentValue=val,Type="Toggle"}
            local function apply(v)
                val=v; tog.CurrentValue=v
                tw(pill,{BackgroundColor3=v and th.TOn or th.TOff},.22)
                tw(pSt, {Color=v and th.TOn or th.Stroke,Transparency=v and .32 or .08},.22)
                tw(la,  {BackgroundTransparency=v and .14 or 1},.22)
                tw(rSt, {Color=v and th.Acc or th.Stroke,Transparency=v and .4 or .26},.22)
                tw(nameLbl,{TextColor3=v and th.Text or th.Dim},.18)
                tw(dot, {BackgroundTransparency=v and .05 or 1},.18)
                tw(knob,{Size=UDim2.new(0,KS*1.35,0,KS*.7)},.07,Enum.EasingStyle.Sine)
                task.delay(.07,function()
                    if not knob.Parent then return end
                    tw(knob,{Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,v and K1 or K0,.5,0)},.36,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                end)
                if v then startDot() else stopDot() end
            end
            function tog:Set(v) apply(v); if cb then cb(v) end end
            if val then startDot() end
            local hit=ni("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            hit.MouseEnter:Connect(function() tw(row,{BackgroundColor3=th.CardH},.13); tw(rSt,{Transparency=.13},.13) end)
            hit.MouseLeave:Connect(function() tw(row,{BackgroundColor3=th.Card},.13); tw(rSt,{Transparency=val and .4 or .26},.13) end)
            hit.MouseButton1Down:Connect(function() tw(pill,{Size=UDim2.new(0,PW*.82,0,PH*.76)},.06,Enum.EasingStyle.Quint) end)
            local busy=false
            hit.MouseButton1Click:Connect(function()
                if busy then return end; busy=true; task.delay(.36,function() busy=false end)
                tw(pill,{Size=UDim2.new(0,PW,0,PH)},.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                tog:Set(not val)
            end)
            if fl then Vula.Flags[fl]=tog end
            return tog
        end

        -- ── Button ────────────────────────────────────────────────────────────
        function tab:CreateButton(o)
            local bN=o.Name or "Button"; local cb=o.Callback; local sub=o.Description or ""
            local ROW_H=sub~="" and 40 or 32
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,ROW_H),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo(),ClipsDescendants=true})
            C(row,9); row:SetAttribute("origH",ROW_H)  -- ← rounder
            local rSt=St(row,th.Stroke,1,.24)
            local fill=ni("Frame",row,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Acc,BackgroundTransparency=.88,ZIndex=5}); C(fill,9)
            ni("TextLabel",row,{Size=UDim2.new(1,-28,0,18),Position=UDim2.new(0,10,0,sub~="" and 5 or 0),BackgroundTransparency=1,Text=bN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            if sub~="" then ni("TextLabel",row,{Size=UDim2.new(1,-28,0,14),Position=UDim2.new(0,10,0,22),BackgroundTransparency=1,Text=sub,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6}) end
            -- Better arrow: › instead of >
            local arr=ni("TextLabel",row,{Size=UDim2.new(0,16,1,0),Position=UDim2.new(1,-18,0,0),BackgroundTransparency=1,Text="›",TextColor3=th.Dim,Font=Enum.Font.GothamBold,TextSize=16,ZIndex=6})
            local hit=ni("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            hit.MouseEnter:Connect(function() tw(row,{BackgroundColor3=th.CardH},.13); tw(fill,{Size=UDim2.new(1,0,1,0)},.24); tw(rSt,{Color=th.Acc,Transparency=.5},.16); tw(arr,{TextColor3=th.Acc},.13) end)
            hit.MouseLeave:Connect(function() tw(row,{BackgroundColor3=th.Card},.13); tw(fill,{Size=UDim2.new(0,0,1,0)},.16); tw(rSt,{Color=th.Stroke,Transparency=.24},.16); tw(arr,{TextColor3=th.Dim},.13) end)
            hit.MouseButton1Down:Connect(function(mx,my)
                local abs=row.AbsolutePosition
                local rip=ni("Frame",row,{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0,mx-abs.X,0,my-abs.Y),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Acc,BackgroundTransparency=.72,ZIndex=10}); C(rip,999)
                tw(rip,{Size=UDim2.new(0,math.max(row.AbsoluteSize.X,row.AbsoluteSize.Y)*2.4,0,math.max(row.AbsoluteSize.X,row.AbsoluteSize.Y)*2.4),BackgroundTransparency=1},.42,Enum.EasingStyle.Quint)
                task.delay(.44,function() if rip.Parent then rip:Destroy() end end)
            end)
            local cd=false
            hit.MouseButton1Click:Connect(function() if cd then return end; cd=true; task.delay(.22,function() cd=false end); if cb then task.spawn(cb) end end)
            local b={}; function b:SetText(t) local l=row:FindFirstChildWhichIsA("TextLabel"); if l then l.Text=t end end; return b
        end

        -- ── Label ─────────────────────────────────────────────────────────────
        function tab:CreateLabel(text)
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,26),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            C(row,9); St(row,th.Stroke,1,.38); row:SetAttribute("origH",26)
            local lbl=ni("TextLabel",row,{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,8,0,0),BackgroundTransparency=1,Text=text,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            return {Set=function(_,t) lbl.Text=t end,Get=function() return lbl.Text end}
        end

        -- ── Keybind ───────────────────────────────────────────────────────────
        function tab:CreateKeybind(o)
            local kN=o.Name or "Keybind"; local kD=o.CurrentKeybind or "RightShift"
            local fl=o.Flag; local cb=o.Callback; local cur=kD; local lst=false
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,34),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            C(row,9); St(row,th.Stroke,1,.24); row:SetAttribute("origH",34)
            ni("TextLabel",row,{Size=UDim2.new(1,-80,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=kN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local chip=ni("TextButton",row,{Size=UDim2.new(0,64,0,20),Position=UDim2.new(1,-70,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.InBg,Text=cur,TextColor3=th.Acc,Font=Enum.Font.GothamBold,TextSize=8,ZIndex=7,AutoButtonColor=false}); C(chip,6)
            local cSt=St(chip,th.Acc,1,.4)
            chip.MouseButton1Click:Connect(function()
                if lst then return end; lst=true; chip.Text="…"
                tw(chip,{BackgroundColor3=th.Acc},.14); tw(cSt,{Transparency=0},.14)
            end)
            UIS.InputBegan:Connect(function(i,gpe)
                if not lst then return end
                if i.UserInputType~=Enum.UserInputType.Keyboard then return end
                lst=false; cur=i.KeyCode.Name; chip.Text=cur
                tw(chip,{BackgroundColor3=th.InBg},.14); tw(cSt,{Transparency=.4},.14)
                if cb then cb(cur) end
            end)
            local kb={CurrentKeybind=cur,Type="Keybind"}
            function kb:Set(v) cur=v; chip.Text=v end
            if fl then Vula.Flags[fl]=kb end; return kb
        end

        -- ── Slider ────────────────────────────────────────────────────────────
        function tab:CreateSlider(o)
            local sN=o.Name or "Slider"; local sMin=o.Min or 0; local sMax=o.Max or 100
            local sInc=o.Increment or 1; local val=clamp(o.Default or sMin,sMin,sMax)
            local fl=o.Flag; local cb=o.Callback; local sfx=o.Suffix or ""
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,44),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            C(row,9); St(row,th.Stroke,1,.24); row:SetAttribute("origH",44)
            ni("TextLabel",row,{Size=UDim2.new(.62,0,0,16),Position=UDim2.new(0,10,0,6),BackgroundTransparency=1,Text=sN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local valBg=ni("Frame",row,{Size=UDim2.new(0,40,0,16),Position=UDim2.new(1,-46,0,6),BackgroundColor3=th.InBg,ZIndex=6}); C(valBg,6)
            St(valBg,th.Acc,1,.52)
            local valLbl=ni("TextLabel",valBg,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=tostring(val)..sfx,TextColor3=th.Acc,Font=Enum.Font.GothamBold,TextSize=9,ZIndex=7})
            local TS2=10
            local trackBg=ni("Frame",row,{Size=UDim2.new(1,-TS2*2,0,4),Position=UDim2.new(0,TS2,1,-10),AnchorPoint=Vector2.new(0,1),BackgroundColor3=th.SliderTrack or th.Div,ZIndex=6}); C(trackBg,2)
            local trackFill=ni("Frame",trackBg,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Acc,ZIndex=7}); C(trackFill,2)
            local KS2=14
            local thumb=ni("Frame",trackBg,{Size=UDim2.new(0,KS2,0,KS2),AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(0,0,.5,0),BackgroundColor3=th.Acc,ZIndex=8}); C(thumb,KS2//2)
            ni("UIGradient",thumb,{Rotation=135,ColorSequence=ColorSequence.new(th.Acc,th.AccD)})
            local function setVal(v,fire)
                v=clamp(round(v,sInc),sMin,sMax); val=v
                local pct=(sMax==sMin) and 0 or (v-sMin)/(sMax-sMin)
                tw(trackFill,{Size=UDim2.new(pct,0,1,0)},.07)
                tw(thumb,    {Position=UDim2.new(pct,0,.5,0)},.07)
                valLbl.Text=tostring(v)..sfx
                if fl then Vula.Flags[fl]=v end
                if fire and cb then cb(v) end
            end
            local hit=ni("TextButton",trackBg,{Size=UDim2.new(1,TS2*2,0,28),Position=UDim2.new(0,-TS2,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            local dragging=false
            hit.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    dragging=true; tw(thumb,{Size=UDim2.new(0,KS2*1.25,0,KS2*1.25)},.1,Enum.EasingStyle.Back)
                end
            end)
            UIS.InputChanged:Connect(function(i)
                if not dragging then return end
                if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
                    local abs=trackBg.AbsolutePosition; local sz=trackBg.AbsoluteSize
                    setVal(sMin+clamp((UIS:GetMouseLocation().X-abs.X)/sz.X,0,1)*(sMax-sMin),false)
                end
            end)
            UIS.InputEnded:Connect(function(i)
                if (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) and dragging then
                    dragging=false; tw(thumb,{Size=UDim2.new(0,KS2,0,KS2)},.2,Enum.EasingStyle.Back)
                    setVal(val,true)  -- fire callback once on release only
                end
            end)
            row.MouseEnter:Connect(function() tw(row,{BackgroundColor3=th.CardH},.13) end)
            row.MouseLeave:Connect(function() tw(row,{BackgroundColor3=th.Card},.13) end)
            local sl={Value=val,Type="Slider"}
            function sl:Set(v) setVal(v,false) end
            function sl:Get() return val end
            setVal(val,false); return sl
        end

        -- ── Input ─────────────────────────────────────────────────────────────
        function tab:CreateInput(o)
            local iN=o.Name or "Input"; local iPh=o.Placeholder or "Type here..."
            local fl=o.Flag; local cb=o.Callback; local numO=o.NumbersOnly or false
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,52),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()})
            C(row,9); St(row,th.Stroke,1,.24); row:SetAttribute("origH",52)
            ni("TextLabel",row,{Size=UDim2.new(.75,0,0,14),Position=UDim2.new(0,10,0,5),BackgroundTransparency=1,Text=iN,TextColor3=th.Dim,Font=Enum.Font.GothamBold,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local inputBg=ni("Frame",row,{Size=UDim2.new(1,-16,0,24),Position=UDim2.new(0,8,0,22),BackgroundColor3=th.InBg,ZIndex=6}); C(inputBg,7)
            local iSt=St(inputBg,th.Stroke,1,.26)
            local tb=ni("TextBox",inputBg,{Size=UDim2.new(1,-12,1,0),Position=UDim2.new(0,7,0,0),BackgroundTransparency=1,Text="",PlaceholderText=iPh,TextColor3=th.Text,PlaceholderColor3=th.Ph,Font=Enum.Font.GothamMedium,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=7,ClearTextOnFocus=false})
            tb.Focused:Connect(function() tw(iSt,{Color=th.Acc,Transparency=.16},.14); tw(inputBg,{BackgroundColor3=th.Card},.14) end)
            tb.FocusLost:Connect(function(enter)
                if numO then local n=tonumber(tb.Text); tb.Text=n and tostring(n) or "" end
                tw(iSt,{Color=th.Stroke,Transparency=.26},.14); tw(inputBg,{BackgroundColor3=th.InBg},.14)
                if fl then Vula.Flags[fl]=tb.Text end
                if cb then cb(tb.Text,enter) end
            end)
            local inp={Type="Input"}
            function inp:Get() return tb.Text end
            function inp:Set(v) tb.Text=tostring(v) end
            function inp:Clear() tb.Text="" end
            return inp
        end

        -- ── Dropdown ──────────────────────────────────────────────────────────
        function tab:CreateDropdown(o)
            local dN=o.Name or "Select"; local opts2=o.Options or {}
            local multi=o.Multi~=false; local fl=o.Flag; local cb=o.Callback
            local HDRH=32; local ITMH=26; local selected={}; local isOpen=false
            local totalH=HDRH+(#opts2*ITMH)+6
            local wrap=ni("Frame",page,{Size=UDim2.new(1,0,0,HDRH),BackgroundTransparency=1,ZIndex=5,LayoutOrder=eo(),ClipsDescendants=true})
            wrap:SetAttribute("origH",HDRH)
            local hdr=ni("Frame",wrap,{Size=UDim2.new(1,0,0,HDRH),BackgroundColor3=th.Card,ZIndex=5}); C(hdr,9)
            local hdrSt=St(hdr,th.Stroke,1,.24)
            ni("TextLabel",hdr,{Size=UDim2.new(1,-42,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=dN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local cntBg=ni("Frame",hdr,{Size=UDim2.new(0,26,0,16),Position=UDim2.new(1,-34,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.InBg,ZIndex=7}); C(cntBg,6)
            local cntLbl=ni("TextLabel",cntBg,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="0",TextColor3=th.Acc,Font=Enum.Font.GothamBold,TextSize=8,ZIndex=8})
            -- ▾ / ▴ instead of "v"
            local chev=ni("TextLabel",hdr,{Size=UDim2.new(0,14,1,0),Position=UDim2.new(1,-16,0,0),BackgroundTransparency=1,Text="▾",TextColor3=th.Dim,Font=Enum.Font.GothamBold,TextSize=12,ZIndex=7})
            local iFrame=ni("Frame",wrap,{Size=UDim2.new(1,0,0,#opts2*ITMH+6),Position=UDim2.new(0,0,0,HDRH+1),BackgroundColor3=th.InBg,ZIndex=5}); C(iFrame,9)
            St(iFrame,th.Stroke,1,.3); LL(iFrame,0); Pd(iFrame,4,4,3,3)
            local iBtns={}
            local function updCount()
                local n=0; for _ in pairs(selected) do n=n+1 end
                cntLbl.Text=tostring(n)
                tw(cntBg,{BackgroundColor3=n>0 and th.Acc or th.InBg},.16)
                tw(cntLbl,{TextColor3=n>0 and Color3.new(1,1,1) or th.Acc},.16)
            end
            for _,optName in ipairs(opts2) do
                local name=optName
                local ib=ni("TextButton",iFrame,{Size=UDim2.new(1,0,0,ITMH),BackgroundColor3=th.Card,BackgroundTransparency=.72,Text="",ZIndex=6,AutoButtonColor=false}); C(ib,6)
                local chk=ni("Frame",ib,{Size=UDim2.new(0,10,0,10),Position=UDim2.new(0,6,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.TOff,ZIndex=7}); C(chk,4)
                St(chk,th.Acc,1,.3)
                -- ✓ checkmark
                local chkM=ni("TextLabel",chk,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="✓",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=7,TextTransparency=1,ZIndex=8})
                ni("TextLabel",ib,{Size=UDim2.new(1,-24,1,0),Position=UDim2.new(0,22,0,0),BackgroundTransparency=1,Text=name,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=7})
                local function setChk(v)
                    tw(chk,{BackgroundColor3=v and th.Acc or th.TOff},.16)
                    tw(chkM,{TextTransparency=v and 0 or 1},.16)
                    local l=ib:FindFirstChildWhichIsA("TextLabel")
                    if l and l~=chkM then tw(l,{TextColor3=v and th.Text or th.Dim},.16) end
                end
                ib.MouseButton1Click:Connect(function()
                    if not multi then for k in pairs(selected) do selected[k]=nil; if iBtns[k] then iBtns[k](false) end end end
                    selected[name]=not selected[name] or nil
                    setChk(selected[name]~=nil); updCount()
                    if cb then local s={}; for k in pairs(selected) do s[#s+1]=k end; cb(s) end
                end)
                ib.MouseEnter:Connect(function() tw(ib,{BackgroundTransparency=.36},.11) end)
                ib.MouseLeave:Connect(function() tw(ib,{BackgroundTransparency=.72},.11) end)
                iBtns[name]=setChk
            end
            local hHit=ni("TextButton",hdr,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=8,AutoButtonColor=false})
            hHit.MouseButton1Click:Connect(function()
                isOpen=not isOpen
                tw(wrap,{Size=UDim2.new(1,0,0,isOpen and totalH or HDRH)},.24,Enum.EasingStyle.Quint)
                -- ▾ open → ▴ closed
                chev.Text=isOpen and "▴" or "▾"
                tw(hdrSt,{Color=isOpen and th.Acc or th.Stroke,Transparency=isOpen and .4 or .24},.18)
            end)
            hHit.MouseEnter:Connect(function() tw(hdr,{BackgroundColor3=th.CardH},.13) end)
            hHit.MouseLeave:Connect(function() tw(hdr,{BackgroundColor3=th.Card},.13) end)
            local dd={Type="Dropdown",Selected=selected}
            function dd:GetSelected() local s={}; for k in pairs(selected) do s[#s+1]=k end; return s end
            function dd:SetSelected(arr)
                for k in pairs(selected) do selected[k]=nil; if iBtns[k] then iBtns[k](false) end end
                for _,v in ipairs(arr) do selected[v]=true; if iBtns[v] then iBtns[v](true) end end
                updCount()
            end
            if fl then Vula.Flags[fl]=dd end
            return dd
        end

        return tab
    end

    return Win
end

_g.VulaLoaded=true; _g.VulaLib=Vula
return Vula
