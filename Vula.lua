--[[
╔══════════════════════════════════════════════════════════╗
║  V U L A  ·  v4.0  —  "Void Cursed II"                 ║
║  New: Slider · Input · Config · Typed Notify · Themes   ║
╚══════════════════════════════════════════════════════════╝

  CHANGELOG v4.0
  ──────────────
  + CreateSlider    — draggable value slider with snap
  + CreateInput     — text input / number only mode
  + Notify types    — info / success / warn / error icons
  + SaveConfig      — persist all flags to file
  + LoadConfig      — restore flags on next run
  + SetTheme        — live theme switch (no reload needed)
  + Win:Destroy     — clean teardown
  + Status dots     — pulsing dot on active toggles
  + Collapsible sections
  + Mobile auto-scale (viewport-aware sizing)
  + Smoother spring animations throughout
]]

local Vula = { Flags = {}, Version = "4.0" }
local _g = type(getgenv) == "function" and getgenv() or {}
if _g.VulaLoaded then return _g.VulaLib end

-- ── Services ──────────────────────────────────────────────────────────────────
local TS  = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Run = game:GetService("RunService")
local LP  = game:GetService("Players").LocalPlayer
local HS  = pcall(function() return game:GetService("HttpService") end)
      HS  = game:GetService("HttpService")

-- ── Safe parent ───────────────────────────────────────────────────────────────
local function safeP()
    local ok, pg = pcall(function() return LP:WaitForChild("PlayerGui", 5) end)
    return (ok and pg) or LP.PlayerGui
end

-- ── Core helpers ──────────────────────────────────────────────────────────────
local function tw(o, p, d, s, dr)
    if not o or not o.Parent then return end
    local ti = TweenInfo.new(d or .26, s or Enum.EasingStyle.Quint, dr or Enum.EasingDirection.Out)
    local t  = TS:Create(o, ti, p)
    if t then t:Play() end
end
local function ni(cls, par, props)
    local i = Instance.new(cls)
    if props then for k, v in pairs(props) do pcall(function() i[k] = v end) end end
    if par then i.Parent = par end
    return i
end
local function C(p, r)        ni("UICorner",  p, { CornerRadius = UDim.new(0, r or 6) }) end
local function St(p, c, t, tr)
    return ni("UIStroke", p, { Color = c, Thickness = t or 1, Transparency = tr or 0,
                               ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
end
local function Pd(p, l, r, t, b)
    ni("UIPadding", p, { PaddingLeft = UDim.new(0,l), PaddingRight = UDim.new(0,r),
                         PaddingTop  = UDim.new(0,t), PaddingBottom = UDim.new(0,b) })
end
local function LL(p, g, align)
    ni("UIListLayout", p, {
        FillDirection      = Enum.FillDirection.Vertical,
        HorizontalAlignment= align or Enum.HorizontalAlignment.Left,
        Padding            = UDim.new(0, g or 0),
        SortOrder          = Enum.SortOrder.LayoutOrder,
    })
end
local function hex(s)
    s = s:gsub("#","")
    return Color3.fromRGB(tonumber(s:sub(1,2),16), tonumber(s:sub(3,4),16), tonumber(s:sub(5,6),16))
end
local function rt(t)
    local o = {}
    for k, v in pairs(t) do o[k] = type(v) == "string" and hex(v) or v end
    return o
end
local function lerp(a, b, t) return a + (b - a) * t end
local function lerpC(a, b, t)
    return Color3.new(lerp(a.R,b.R,t), lerp(a.G,b.G,t), lerp(a.B,b.B,t))
end
local function clamp(v, mn, mx) return math.max(mn, math.min(mx, v)) end
local function round(v, inc) return math.floor(v / inc + .5) * inc end

-- ── Themes ────────────────────────────────────────────────────────────────────
Vula.Theme = {
    JJK = {
        Bg="060610", Top="0a0a18", Side="080814",
        Card="0d0c1a", CardH="14112200", Stroke="2c1828",
        Text="dce0f8", Dim="48506e", SecLbl="c01a2e",
        Acc="c81c30", AccD="7a0c1c", AccG="c81c30",
        TOn="c81c30", TOff="1a0e16", Knob="f5f5ff",
        TBOn="c81c30", TBOff="0c0c1c", TxtOn="ffffff", TxtOff="3e4560",
        Div="22121c", InBg="09090f", Ph="383e58",
        Pill="0c0b18", NBg="090916",
        -- typed notify accent overrides
        NInfo="3d8fdc", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="1a0e1e", SliderFill="c81c30",
    },
    Default = {
        Bg="111111", Top="181818", Side="141414",
        Card="1a1a1a", CardH="222222", Stroke="2a2a2a",
        Text="e8e8e8", Dim="686868", SecLbl="3d8fdc",
        Acc="3d8fdc", AccD="1f5a9a", AccG="3d8fdc",
        TOn="3d8fdc", TOff="282828", Knob="f8f8f8",
        TBOn="3d8fdc", TBOff="1a1a1a", TxtOn="ffffff", TxtOff="585858",
        Div="252525", InBg="101010", Ph="484848",
        Pill="181818", NBg="161616",
        NInfo="3d8fdc", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="252525", SliderFill="3d8fdc",
    },
    Midnight = {
        Bg="060810", Top="0a0d1e", Side="080b18",
        Card="0e1228", CardH="141830", Stroke="1e2650",
        Text="ccd2ff", Dim="424e88", SecLbl="6080ff",
        Acc="6080ff", AccD="3248c0", AccG="6080ff",
        TOn="6080ff", TOff="141828", Knob="f0f0ff",
        TBOn="6080ff", TBOff="0e1228", TxtOn="ffffff", TxtOff="3a4470",
        Div="1a2048", InBg="080a16", Ph="363e70",
        Pill="0a0d1e", NBg="0a0d1e",
        NInfo="6080ff", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="1a2048", SliderFill="6080ff",
    },
    Amethyst = {
        Bg="090610", Top="110c20", Side="0d0818",
        Card="150f24", CardH="1c142c", Stroke="3c2258",
        Text="e0d8ff", Dim="5e4890", SecLbl="a060e8",
        Acc="a060e8", AccD="5c28a0", AccG="a060e8",
        TOn="a060e8", TOff="241438", Knob="f0e8ff",
        TBOn="a060e8", TBOff="150f24", TxtOn="ffffff", TxtOff="5a3e80",
        Div="301a4e", InBg="0b0816", Ph="4e3470",
        Pill="110c20", NBg="110c20",
        NInfo="a060e8", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="301a4e", SliderFill="a060e8",
    },
    Ocean = {
        Bg="060e12", Top="0a1820", Side="08141c",
        Card="0c1c26", CardH="12222e", Stroke="183a50",
        Text="c8f0f2", Dim="3c7888", SecLbl="00c0c0",
        Acc="00c0c0", AccD="007878", AccG="00c0c0",
        TOn="00c0c0", TOff="0c2830", Knob="e8feff",
        TBOn="00c0c0", TBOff="0c1c26", TxtOn="ffffff", TxtOff="2e6878",
        Div="143650", InBg="080e14", Ph="2a5e6e",
        Pill="0a1820", NBg="0a1820",
        NInfo="00c0c0", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="143650", SliderFill="00c0c0",
    },
    Sakura = {
        Bg="0e0810", Top="1c1018", Side="160c14",
        Card="201420", CardH="281a28", Stroke="4e2040",
        Text="ffe8f2", Dim="7a5068", SecLbl="f05090",
        Acc="f05090", AccD="902858", AccG="f05090",
        TOn="f05090", TOff="301420", Knob="fff0f5",
        TBOn="f05090", TBOff="201420", TxtOn="ffffff", TxtOff="6e3858",
        Div="481838", InBg="0e080e", Ph="5e2e4e",
        Pill="1c1018", NBg="1c1018",
        NInfo="f05090", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="481838", SliderFill="f05090",
    },
    Light = {
        Bg="f0f0f4", Top="e4e4ea", Side="eaeaee",
        Card="fafafa", CardH="f0f0f8", Stroke="d8d8de",
        Text="181820", Dim="8a8a98", SecLbl="2878d8",
        Acc="2878d8", AccD="185098", AccG="2878d8",
        TOn="2878d8", TOff="c8c8d0", Knob="ffffff",
        TBOn="2878d8", TBOff="fafafa", TxtOn="ffffff", TxtOff="8a8a98",
        Div="d4d4dc", InBg="ebebee", Ph="a8a8b4",
        Pill="e4e4ea", NBg="fafafa",
        NInfo="2878d8", NSucc="22c55e", NWarn="f59e0b", NErr="ef4444",
        SliderTrack="d4d4dc", SliderFill="2878d8",
    },
}

-- ── Notify ─────────────────────────────────────────────────────────────────────
local _nsg, _nst = nil, {}
local NW, NH, NG = 230, 48, 4
local NOTIFY_ICON  = { info="ℹ", success="✓", warn="⚠", error="✕" }
local NOTIFY_COL   = { info="NInfo", success="NSucc", warn="NWarn", error="NErr" }

local function getNSG()
    if _nsg and _nsg.Parent then return _nsg end
    _nsg = ni("ScreenGui", safeP(), { Name="VulaNotifs", DisplayOrder=200, ResetOnSpawn=false })
    return _nsg
end

local function repack()
    local vpH = workspace.CurrentCamera.ViewportSize.Y
    for i, f in ipairs(_nst) do
        if f and f.Parent then
            tw(f, { Position=UDim2.new(1,-6, 1-(i*(NH+NG)/vpH), 0) }, .35, Enum.EasingStyle.Back)
        end
    end
end

function Vula:Notify(o)
    local T   = o.Title    or "Vula"
    local C2  = o.Content  or ""
    local D   = o.Duration or 4
    local typ = o.Type     or "info"   -- info / success / warn / error
    local th  = self._theme or rt(Vula.Theme.Default)
    local nkey = NOTIFY_COL[typ] or "NInfo"
    local nCol = th[nkey] or th.Acc

    if #_nst >= 4 then
        local x = table.remove(_nst, 1)
        if x and x.Parent then x:Destroy() end
    end
    local idx = #_nst + 1
    local vpH = workspace.CurrentCamera.ViewportSize.Y
    local sy  = 1 - idx * (NH + NG) / vpH

    local f = ni("Frame", getNSG(), {
        Size=UDim2.new(0,NW,0,NH), AnchorPoint=Vector2.new(1,1),
        Position=UDim2.new(1.08,0,sy,0),
        BackgroundColor3=th.NBg, ZIndex=10,
    }); C(f,10); St(f, th.Stroke, 1, .12)

    -- Top accent glow
    local gt = ni("Frame", f, { Size=UDim2.new(1,0,0,1), BackgroundColor3=nCol, BackgroundTransparency=.06, ZIndex=12 }); C(gt,10)
    local lb = ni("Frame", f, { Size=UDim2.new(0,3,.5,0), Position=UDim2.new(0,8,.25,0), BackgroundColor3=nCol, ZIndex=12 }); C(lb,2)
    local ic = ni("Frame", f, { Size=UDim2.new(0,18,0,18), Position=UDim2.new(0,14,.5,0), AnchorPoint=Vector2.new(0,.5), BackgroundColor3=nCol, BackgroundTransparency=.8, ZIndex=12 }); C(ic,9)
    ni("TextLabel", ic, { Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text=NOTIFY_ICON[typ] or "i",
                           TextColor3=nCol, Font=Enum.Font.GothamBold, TextSize=9, ZIndex=13 })
    local tl = ni("TextLabel", f, { Size=UDim2.new(1,-46,0,15), Position=UDim2.new(0,38,0,6),
        BackgroundTransparency=1, Text=T, TextColor3=th.Text,
        Font=Enum.Font.GothamBold, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left,
        TextTransparency=1, ZIndex=12 })
    local bl = ni("TextLabel", f, { Size=UDim2.new(1,-46,0,13), Position=UDim2.new(0,38,0,23),
        BackgroundTransparency=1, Text=C2, TextColor3=th.Dim,
        Font=Enum.Font.GothamMedium, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left,
        TextTruncate=Enum.TextTruncate.AtEnd, TextTransparency=1, ZIndex=12 })
    -- Timer bar
    local bg = ni("Frame", f, { Size=UDim2.new(1,-16,0,1), Position=UDim2.new(0,8,1,-2), AnchorPoint=Vector2.new(0,1), BackgroundColor3=th.Div, ZIndex=12 }); C(bg,1)
    local bf = ni("Frame", bg, { Size=UDim2.new(1,0,1,0), BackgroundColor3=nCol, ZIndex=13 }); C(bf,1)

    _nst[idx] = f
    tw(f,  { Position=UDim2.new(1,-6,sy,0) }, .44, Enum.EasingStyle.Back)
    task.delay(.06, function() tw(tl,{TextTransparency=0},.2); tw(bl,{TextTransparency=.2},.2) end)
    task.delay(.14, function()
        if bf.Parent then tw(bf,{Size=UDim2.new(0,0,1,0)}, D-.14, Enum.EasingStyle.Linear) end
    end)

    local done = false
    local function dis()
        if done then return end; done = true
        tw(tl,{TextTransparency=1},.16); tw(bl,{TextTransparency=1},.16)
        tw(f, {BackgroundTransparency=1, Position=UDim2.new(1.07,0,sy,0)}, .24, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        task.delay(.28, function()
            for i,n in ipairs(_nst) do if n==f then table.remove(_nst,i); break end end
            if f.Parent then f:Destroy() end; repack()
        end)
    end
    f.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dis() end
    end)
    task.delay(D, dis); repack()
end

-- ── Config ────────────────────────────────────────────────────────────────────
local CFG_FILE = "vula_config.json"

function Vula:SaveConfig()
    local data = {}
    for k, v in pairs(self.Flags) do
        if type(v) == "table" then
            if     v.Type == "Toggle"   then data[k] = v.CurrentValue
            elseif v.Type == "Dropdown" then data[k] = v:GetSelected()
            elseif v.Type == "Keybind"  then data[k] = v.CurrentKeybind
            elseif v.Type == "Slider"   then data[k] = v:Get()
            elseif v.Type == "Input"    then data[k] = v:Get()
            end
        elseif type(v) ~= "userdata" then
            data[k] = v
        end
    end
    local ok, enc = pcall(function() return HS:JSONEncode(data) end)
    if ok then
        pcall(writefile, CFG_FILE, enc)
        self:Notify({ Title="Config", Content="Saved ✓", Duration=2.5, Type="success" })
    else
        self:Notify({ Title="Config", Content="Save failed.", Duration=2.5, Type="error" })
    end
end

function Vula:LoadConfig()
    local ok, raw = pcall(readfile, CFG_FILE)
    if not ok or not raw then
        self:Notify({ Title="Config", Content="No save found.", Duration=2.5, Type="warn" })
        return
    end
    local ok2, data = pcall(function() return HS:JSONDecode(raw) end)
    if not ok2 or type(data) ~= "table" then return end
    for k, v in pairs(data) do
        local flag = self.Flags[k]
        if flag and type(flag) == "table" then
            if     flag.Type == "Toggle"   then flag:Set(v)
            elseif flag.Type == "Dropdown" then flag:SetSelected(type(v)=="table" and v or {v})
            elseif flag.Type == "Keybind"  then flag:Set(v)
            elseif flag.Type == "Slider"   then flag:Set(v)
            elseif flag.Type == "Input"    then flag:Set(v)
            end
        end
    end
    self:Notify({ Title="Config", Content="Loaded ✓", Duration=2.5, Type="success" })
end

-- ── CreateWindow ──────────────────────────────────────────────────────────────
function Vula:CreateWindow(opts)
    local title  = opts.Name            or "Vula"
    local loadT  = opts.LoadingTitle    or title
    local loadS  = opts.LoadingSubtitle or "Loading..."
    local tname  = opts.Theme           or "Default"
    local th     = rt(Vula.Theme[tname] or Vula.Theme.Default)
    self._theme  = th

    -- ── Viewport-aware sizing ─────────────────────────────────────────────────
    local vp   = workspace.CurrentCamera.ViewportSize
    local mob  = vp.X < 700
    local WW   = mob and math.min(340, vp.X - 16) or 340
    local WH   = opts.Height or (mob and math.min(280, vp.Y - 80) or 265)
    local TOP_H  = 38
    local SIDE_W = 105
    local PILL_W = 148
    local PILL_H = 28

    local par = safeP()
    pcall(function()
        for _, c in ipairs(par:GetChildren()) do
            if c.Name == "Vula" then c:Destroy() end
        end
    end)

    local sg = ni("ScreenGui", par, { Name="Vula", DisplayOrder=100, ResetOnSpawn=false })

    -- ── Shadow glow ───────────────────────────────────────────────────────────
    local shadow = ni("Frame", sg, {
        Size=UDim2.new(0,WW+20,0,WH+20),
        Position=UDim2.new(.5,3,.5,-38+5),
        AnchorPoint=Vector2.new(.5,.5),
        BackgroundColor3=th.Acc, BackgroundTransparency=.94, ZIndex=1,
    }); C(shadow, 14)

    -- ── Main window ───────────────────────────────────────────────────────────
    local Main = ni("Frame", sg, {
        Name="Main",
        Size=UDim2.new(0,WW,0,WH),
        Position=UDim2.new(.5,3,.5,-38),
        AnchorPoint=Vector2.new(.5,.5),
        BackgroundColor3=th.Bg,
        ZIndex=2, ClipsDescendants=true,
    }); C(Main, 10)
    St(Main, th.Stroke, 1, .18)

    -- corner accent
    local ac = ni("Frame", Main, {
        Size=UDim2.new(0,55,0,55), Position=UDim2.new(0,-16,0,-16),
        BackgroundColor3=th.Acc, BackgroundTransparency=.92, ZIndex=2,
    }); C(ac,28)

    -- ── Topbar ────────────────────────────────────────────────────────────────
    local TB = ni("Frame", Main, {
        Size=UDim2.new(1,0,0,TOP_H), BackgroundColor3=th.Top, ZIndex=5,
    }); C(TB,10)
    ni("Frame",TB,{Size=UDim2.new(1,0,.5,0),Position=UDim2.new(0,0,.5,0),BackgroundColor3=th.Top,ZIndex=5})
    ni("Frame",TB,{Size=UDim2.new(1,0,0,1),BackgroundColor3=th.Acc,BackgroundTransparency=.04,ZIndex=8})
    ni("Frame",TB,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=th.Div,BackgroundTransparency=.28,ZIndex=6})

    -- Badge
    local bdg = ni("Frame",TB,{Size=UDim2.new(0,22,0,22),Position=UDim2.new(0,9,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.Acc,ZIndex=6}); C(bdg,11)
    ni("UIGradient",bdg,{Rotation=135,ColorSequence=ColorSequence.new(th.Acc,th.AccD)})
    ni("TextLabel",bdg,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="呪",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=11,ZIndex=7})

    ni("TextLabel",TB,{Size=UDim2.new(1,-108,0,18),Position=UDim2.new(0,36,0,4),BackgroundTransparency=1,Text=title,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
    ni("TextLabel",TB,{Size=UDim2.new(1,-108,0,11),Position=UDim2.new(0,36,0,23),BackgroundTransparency=1,Text="v4.0 · "..tname,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})

    -- macOS orbs
    local function mkOrb(xOff, col, sym)
        local o = ni("TextButton",TB,{Size=UDim2.new(0,11,0,11),Position=UDim2.new(1,xOff,.5,0),AnchorPoint=Vector2.new(1,.5),BackgroundColor3=col,BackgroundTransparency=.1,Text="",ZIndex=7,AutoButtonColor=false}); C(o,6)
        local l = ni("TextLabel",o,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=sym,TextColor3=Color3.fromRGB(20,10,10),Font=Enum.Font.GothamBold,TextSize=7,TextTransparency=1,ZIndex=8})
        o.MouseEnter:Connect(function() tw(o,{BackgroundTransparency=0},.1); tw(l,{TextTransparency=0},.1) end)
        o.MouseLeave:Connect(function() tw(o,{BackgroundTransparency=.1},.1); tw(l,{TextTransparency=1},.1) end)
        return o
    end
    local oClose = mkOrb(-9,  Color3.fromRGB(255,59,48),  "×")
    local oMin   = mkOrb(-24, Color3.fromRGB(255,149,0),  "–")

    -- Topbar drag
    do
        local dr,dsx,dsy,ox,oy = false,0,0,0,0
        TB.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then return end
            dr=true; local m=UIS:GetMouseLocation(); dsx,dsy=m.X,m.Y
            ox=Main.Position.X.Offset; oy=Main.Position.Y.Offset
            local c; c = Run.RenderStepped:Connect(function()
                if not dr then c:Disconnect(); return end
                local m2 = UIS:GetMouseLocation()
                Main.Position  = UDim2.new(.5, ox+(m2.X-dsx), .5, oy+(m2.Y-dsy))
                shadow.Position = UDim2.new(.5, ox+(m2.X-dsx)+3, .5, oy+(m2.Y-dsy)+5)
            end)
        end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
    end

    -- ── Sidebar ───────────────────────────────────────────────────────────────
    local SB = ni("Frame",Main,{
        Size=UDim2.new(0,SIDE_W,1,-TOP_H), Position=UDim2.new(0,0,0,TOP_H),
        BackgroundColor3=th.Side, ZIndex=4,
    })
    ni("Frame",SB,{Size=UDim2.new(0,8,1,0),Position=UDim2.new(1,-8,0,0),BackgroundColor3=th.Side,ZIndex=4})
    ni("Frame",SB,{Size=UDim2.new(0,1,1,0),Position=UDim2.new(1,-1,0,0),BackgroundColor3=th.Div,BackgroundTransparency=.22,ZIndex=5})

    local tabSF = ni("ScrollingFrame",SB,{
        Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, BorderSizePixel=0,
        ScrollBarThickness=2, ScrollBarImageColor3=th.Acc, ScrollBarImageTransparency=.55,
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
        CanvasSize=UDim2.new(0,0,0,0), ZIndex=5,
    }); LL(tabSF,3); Pd(tabSF,6,4,8,6)

    -- ── Content ───────────────────────────────────────────────────────────────
    local Cont = ni("Frame",Main,{
        Size=UDim2.new(1,-SIDE_W,1,-TOP_H), Position=UDim2.new(0,SIDE_W,0,TOP_H),
        BackgroundTransparency=1, ClipsDescendants=true, ZIndex=3,
    })

    -- ── Loading overlay ───────────────────────────────────────────────────────
    local LD = ni("Frame",Main,{Size=UDim2.new(1,0,1,0),BackgroundColor3=th.Bg,ZIndex=25}); C(LD,10)
    local ldb= ni("Frame",LD,{Size=UDim2.new(0,42,0,42),Position=UDim2.new(.5,0,.32,0),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Acc,ZIndex=26}); C(ldb,21)
    ni("UIGradient",ldb,{Rotation=135,ColorSequence=ColorSequence.new(th.Acc,th.AccD)})
    ni("TextLabel",ldb,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="呪",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=17,ZIndex=27})
    ni("TextLabel",LD,{Size=UDim2.new(.9,0,0,18),Position=UDim2.new(.05,0,.44,0),BackgroundTransparency=1,Text=loadT,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=12,ZIndex=26})
    ni("TextLabel",LD,{Size=UDim2.new(.9,0,0,14),Position=UDim2.new(.05,0,.56,0),BackgroundTransparency=1,Text=loadS,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=9,ZIndex=26})
    local lbg = ni("Frame",LD,{Size=UDim2.new(.65,0,0,2),Position=UDim2.new(.175,0,.67,0),BackgroundColor3=th.Div,ZIndex=26}); C(lbg,1)
    local lfl = ni("Frame",lbg,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Acc,ZIndex=27}); C(lfl,1)
    task.spawn(function()
        tw(lfl,{Size=UDim2.new(1,0,1,0)},1.3,Enum.EasingStyle.Quint)
        task.wait(1.6)
        tw(LD,{BackgroundTransparency=1},.35)
        for _,d in ipairs(LD:GetDescendants()) do
            if d:IsA("TextLabel") then tw(d,{TextTransparency=1},.25)
            elseif d:IsA("Frame") then tw(d,{BackgroundTransparency=1},.25) end
        end
        task.wait(.4); LD.Visible=false
    end)

    -- ── Pill ──────────────────────────────────────────────────────────────────
    local Pill = ni("Frame",sg,{
        Size=UDim2.new(0,PILL_W,0,PILL_H),
        Position=UDim2.new(1,-8,.5,0),
        AnchorPoint=Vector2.new(1,.5),
        BackgroundColor3=th.Pill, ZIndex=55,
    }); C(Pill, PILL_H//2)
    St(Pill, th.Acc, 1, .1)
    ni("UIGradient",Pill,{
        Rotation=90,
        ColorSequence=ColorSequence.new(th.Acc,th.Pill),
        Transparency=NumberSequence.new({
            NumberSequenceKeypoint.new(0,.86), NumberSequenceKeypoint.new(1,.95),
        }),
    })
    -- Status dot on pill (shows when any loop is active — set externally)
    local pillDot = ni("Frame",Pill,{Size=UDim2.new(0,6,0,6),Position=UDim2.new(0,10,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.Acc,BackgroundTransparency=1,ZIndex=57}); C(pillDot,3)
    local pillLbl = ni("TextLabel",Pill,{Size=UDim2.new(1,-6,1,0),Position=UDim2.new(0,3,0,0),BackgroundTransparency=1,Text="▲  "..title,TextColor3=th.Text,Font=Enum.Font.GothamBold,TextSize=9,ZIndex=56})

    -- Pill drag (Y axis, right side)
    do
        local dr,dsy,sy=false,0,0; local dc
        Pill.InputBegan:Connect(function(i,gpe)
            if gpe then return end
            if i.UserInputType~=Enum.UserInputType.MouseButton1 and i.UserInputType~=Enum.UserInputType.Touch then return end
            dr=true; dsy=UIS:GetMouseLocation().Y; sy=Pill.Position.Y.Offset
            if dc then dc:Disconnect() end
            dc = Run.Heartbeat:Connect(function()
                if not dr then dc:Disconnect(); return end
                Pill.Position = UDim2.new(1,-8, .5, sy+(UIS:GetMouseLocation().Y-dsy))
            end)
        end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
    end

    -- ── Open / Close / Minimize ───────────────────────────────────────────────
    local Hidden, Minimised, Deb = false, false, false
    local OPEN_POS  = UDim2.new(.5, 3, .5, -38)
    local CLOSE_POS = UDim2.new(.5, 3, .5, -38-18)   -- slides up slightly

    local function open()
        if Deb then return end; Deb=true; Hidden=false
        shadow.Visible=true; Main.Visible=true
        Main.BackgroundTransparency=1
        Main.Position = UDim2.new(.5, 3, .5, -38+14)  -- start below
        Main.Size     = UDim2.new(0,WW,0,WH)
        for _,d in ipairs(Main:GetDescendants()) do
            if d:IsA("TextLabel") or d:IsA("TextButton") then
                pcall(function() if d.TextTransparency < 1 then d.TextTransparency=1 end end)
            end
        end
        pillLbl.Text="▲  "..title
        tw(Main, {BackgroundTransparency=0, Position=OPEN_POS}, .36, Enum.EasingStyle.Back)
        task.delay(.18, function()
            for _,d in ipairs(Main:GetDescendants()) do
                if d:IsA("TextLabel") or d:IsA("TextButton") then
                    pcall(function()
                        if d ~= pillLbl then tw(d,{TextTransparency=0},.2) end
                    end)
                end
            end
        end)
        task.delay(.4, function() Deb=false end)
    end
    local function close(silent)
        if Deb then return end; Deb=true; Hidden=true
        pillLbl.Text="▼  "..title
        tw(Main, {BackgroundTransparency=1, Position=CLOSE_POS, Size=UDim2.new(0,WW,0,WH-8)},
            .22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        task.delay(.24, function()
            Main.Visible=false; shadow.Visible=false
            Main.Position=OPEN_POS; Main.Size=UDim2.new(0,WW,0,WH)
            Deb=false
        end)
        if not silent then Vula:Notify({Title="Hidden",Content="Pill or RightShift to reopen.",Duration=3,Type="info"}) end
    end
    local function toggle() if Hidden then open() else close(true) end end

    oClose.MouseButton1Click:Connect(function() close(true) end)
    oMin.MouseButton1Click:Connect(function()
        Minimised = not Minimised
        if Minimised then
            SB.Visible=false; Cont.Visible=false
            tw(Main,{Size=UDim2.new(0,WW,0,TOP_H)},.25)
        else
            tw(Main,{Size=UDim2.new(0,WW,0,WH)},.35,Enum.EasingStyle.Back)
            task.delay(.15,function() SB.Visible=true; Cont.Visible=true end)
        end    end)

    local pb = ni("TextButton",Pill,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=57,AutoButtonColor=false})
    pb.MouseButton1Click:Connect(toggle)
    pb.MouseEnter:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W+14,0,PILL_H+4)},.18,Enum.EasingStyle.Back) end)
    pb.MouseLeave:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W,0,PILL_H)},.16) end)
    pb.MouseButton1Down:Connect(function() tw(Pill,{Size=UDim2.new(0,PILL_W-8,0,PILL_H-4)},.07,Enum.EasingStyle.Quint) end)
    UIS.InputBegan:Connect(function(i,gpe) if gpe then return end; if i.KeyCode==Enum.KeyCode.RightShift then toggle() end end)

    -- ── Tab system ────────────────────────────────────────────────────────────
    local _tabs, _btns, _act = {}, {}, 0
    local function selTab(idx)
        if _act == idx then return end
        for i, t in ipairs(_tabs) do
            t.page.Visible = (i == idx)
            local b = _btns[i]; if not b then continue end
            local lbl = b:FindFirstChildWhichIsA("TextLabel")
            local bar = b:FindFirstChild("_b")
            if i == idx then
                tw(b,  {BackgroundColor3=th.TBOn,  BackgroundTransparency=0},   .22)
                if lbl then tw(lbl,{TextColor3=th.TxtOn,  TextTransparency=0},.18) end
                if bar then tw(bar,{BackgroundTransparency=0},.18) end
            else
                tw(b,  {BackgroundColor3=th.TBOff, BackgroundTransparency=.6}, .22)
                if lbl then tw(lbl,{TextColor3=th.TxtOff, TextTransparency=.2},.18) end
                if bar then tw(bar,{BackgroundTransparency=1},.18) end
            end
        end
        _act = idx
    end

    -- ── Win object ────────────────────────────────────────────────────────────
    local Win = { _sg=sg }

    function Win:Destroy()
        if sg and sg.Parent then sg:Destroy() end
        if shadow and shadow.Parent then shadow:Destroy() end
    end

    function Win:SetTheme(name)
        local newTh = rt(Vula.Theme[name] or Vula.Theme.Default)

        -- Build RGB-string keyed remap: old color → new color
        local function c3k(c)
            return math.floor(c.R*255+.5)..","..math.floor(c.G*255+.5)..","..math.floor(c.B*255+.5)
        end
        local remap = {}
        for k in pairs(Vula.Theme.Default) do   -- iterate common keys
            local ov = th[k]; local nv = newTh[k]
            if type(ov)=="userdata" and type(nv)=="userdata" then
                remap[c3k(ov)] = nv
            end
        end

        th = newTh; Vula._theme = newTh

        local D = .28
        for _, inst in ipairs(sg:GetDescendants()) do
            pcall(function()
                if inst:IsA("Frame") or inst:IsA("TextButton") or inst:IsA("ScrollingFrame") or inst:IsA("ImageLabel") then
                    local nc = remap[c3k(inst.BackgroundColor3)]
                    if nc then tw(inst,{BackgroundColor3=nc},D) end
                end
                if inst:IsA("TextLabel") or inst:IsA("TextButton") then
                    local nc = remap[c3k(inst.TextColor3)]
                    if nc then tw(inst,{TextColor3=nc},D) end
                end
                if inst:IsA("UIStroke") then
                    local nc = remap[c3k(inst.Color)]
                    if nc then tw(inst,{Color=nc},D) end
                end
            end)
        end

        Vula:Notify({Title="Theme",Content=name.." applied.",Duration=2.5,Type="success"})
    end

    function Win:SetPillActive(active)
        if active then
            tw(pillDot,{BackgroundTransparency=0},.2)
            -- pulse animation
            task.spawn(function()
                while pillDot.Parent and pillDot.BackgroundTransparency < .5 do
                    tw(pillDot,{BackgroundTransparency=.5},.6,Enum.EasingStyle.Sine)
                    task.wait(.65)
                    if pillDot.Parent and pillDot.BackgroundTransparency >= .4 then
                        tw(pillDot,{BackgroundTransparency=0},.6,Enum.EasingStyle.Sine)
                        task.wait(.65)
                    end
                end
            end)
        else
            tw(pillDot,{BackgroundTransparency=1},.2)
        end
    end

    function Win:CreateTab(name, icon)
        local idx   = #_tabs + 1
        local first = (idx == 1)
        local displayName = icon and (icon.."  "..name) or name

        local btn = ni("TextButton",tabSF,{
            Name="T_"..name, Size=UDim2.new(1,0,0,30),
            BackgroundColor3=first and th.TBOn or th.TBOff,
            BackgroundTransparency=first and 0 or .6,
            Text="", ZIndex=6, AutoButtonColor=false, LayoutOrder=idx,
        }); C(btn,7)

        local bar = ni("Frame",btn,{Name="_b",Size=UDim2.new(0,2,.55,0),Position=UDim2.new(0,0,.225,0),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=first and 0 or 1,ZIndex=7}); C(bar,1)
        ni("TextLabel",btn,{Size=UDim2.new(1,-12,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=displayName,TextColor3=first and th.TxtOn or th.TxtOff,Font=Enum.Font.GothamBold,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,TextTransparency=first and 0 or .2,ZIndex=7})

        btn.MouseButton1Click:Connect(function() selTab(idx) end)
        btn.MouseEnter:Connect(function() if _act~=idx then tw(btn,{BackgroundTransparency=.25},.14) end end)
        btn.MouseLeave:Connect(function() if _act~=idx then tw(btn,{BackgroundTransparency=.6},.14) end end)

        local page = ni("ScrollingFrame",Cont,{
            Name="P_"..name, Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, BorderSizePixel=0,
            ScrollBarThickness=2, ScrollBarImageColor3=th.Acc, ScrollBarImageTransparency=.4,
            AutomaticCanvasSize=Enum.AutomaticSize.Y, CanvasSize=UDim2.new(0,0,0,0),
            Visible=first, ZIndex=4, ClipsDescendants=true,
        }); LL(page,5); Pd(page,6,6,8,8)

        local tab = {page=page, _n=0}
        _tabs[idx]=tab; _btns[idx]=btn
        if first then _act=1 end
        local function eo() tab._n=tab._n+1; return tab._n end

        -- ── Section (collapsible) ─────────────────────────────────────────────
        function tab:CreateSection(s)
            local sf     = ni("Frame",page,{Size=UDim2.new(1,0,0,20),BackgroundTransparency=1,ZIndex=4,LayoutOrder=eo(),ClipsDescendants=false})
            local opened = true
            local children = {}   -- collected after creation

            local hdr = ni("TextButton",sf,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=5,AutoButtonColor=false})
            ni("TextLabel",sf,{Size=UDim2.new(1,-20,0,13),Position=UDim2.new(0,1,0,4),BackgroundTransparency=1,Text=s:upper(),TextColor3=th.SecLbl,Font=Enum.Font.GothamBold,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5})
            local chev = ni("TextLabel",sf,{Size=UDim2.new(0,14,0,13),Position=UDim2.new(1,-14,0,4),BackgroundTransparency=1,Text="▾",TextColor3=th.SecLbl,Font=Enum.Font.GothamBold,TextSize=8,ZIndex=5})
            local dl   = ni("Frame",sf,{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=th.Acc,BackgroundTransparency=.62,ZIndex=5})

            -- collapse / expand section items
            hdr.MouseButton1Click:Connect(function()
                opened = not opened
                tw(chev,{Rotation=opened and 0 or -90},.2)
                tw(dl,{BackgroundTransparency=opened and .62 or .85},.2)
                -- find items added after this section
                local inSection = false
                for _, child in ipairs(page:GetChildren()) do
                    if child == sf then inSection=true; continue end
                    if inSection then
                        if child:FindFirstChild("_sectionEnd") then break end
                        tw(child,{Size=UDim2.new(1,0,0, opened and child:GetAttribute("origH") or 0)},.2)
                        child.Visible = opened
                    end
                end
            end)
        end

        -- ── Toggle ────────────────────────────────────────────────────────────
        function tab:CreateToggle(o)
            local tN=o.Name or "Toggle"; local dV=o.CurrentValue or false
            local fl=o.Flag; local cb=o.Callback; local val=dV
            local ROW_H=36

            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,ROW_H),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()}); C(row,6)
            row:SetAttribute("origH",ROW_H)
            local rSt=St(row,th.Stroke,1,.28)

            -- Left accent stripe
            local la=ni("Frame",row,{Size=UDim2.new(0,2,.44,0),Position=UDim2.new(0,0,.28,0),BackgroundColor3=th.Acc,BackgroundTransparency=val and .15 or 1,ZIndex=6}); C(la,1)

            -- Status dot (pulsing when ON)
            local dot=ni("Frame",row,{Size=UDim2.new(0,5,0,5),Position=UDim2.new(0,11,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.Acc,BackgroundTransparency=val and .1 or 1,ZIndex=7}); C(dot,3)

            local nameLbl=ni("TextLabel",row,{Size=UDim2.new(1,-66,1,0),Position=UDim2.new(0,20,0,0),BackgroundTransparency=1,Text=tN,TextColor3=val and th.Text or th.Dim,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})

            local PW,PH,KS=38,20,14; local K0,K1=2,20
            local pill=ni("Frame",row,{Size=UDim2.new(0,PW,0,PH),Position=UDim2.new(1,-(PW+8),.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=val and th.TOn or th.TOff,ZIndex=6}); C(pill,PH//2)
            local pSt=St(pill,val and th.TOn or th.Stroke,1,val and .35 or .08)
            local knob=ni("Frame",pill,{Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,val and K1 or K0,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.Knob,ZIndex=7}); C(knob,KS//2)
            St(knob,Color3.new(0,0,0),1,.9)

            -- Dot pulse loop
            local dotLoop
            local function startDot()
                if dotLoop then return end
                dotLoop = task.spawn(function()
                    while dot.Parent and dot.BackgroundTransparency < .5 do
                        tw(dot,{BackgroundTransparency=.55},.55,Enum.EasingStyle.Sine)
                        task.wait(.6)
                        if dot.Parent then tw(dot,{BackgroundTransparency=.05},.55,Enum.EasingStyle.Sine) task.wait(.6) end
                    end
                end)
            end
            local function stopDot()
                if dotLoop then task.cancel(dotLoop); dotLoop=nil end
            end

            local tog={CurrentValue=val, Type="Toggle"}
            local function apply(v)
                val=v; tog.CurrentValue=v
                tw(pill,{BackgroundColor3=v and th.TOn or th.TOff},.24)
                tw(pSt, {Color=v and th.TOn or th.Stroke, Transparency=v and .35 or .08},.24)
                tw(la,  {BackgroundTransparency=v and .15 or 1},.24)
                tw(rSt, {Color=v and th.Acc or th.Stroke, Transparency=v and .42 or .28},.24)
                tw(nameLbl,{TextColor3=v and th.Text or th.Dim},.2)
                tw(dot, {BackgroundTransparency=v and .05 or 1},.2)
                -- Knob squish → spring
                tw(knob,{Size=UDim2.new(0,KS*1.35,0,KS*.7)},.07,Enum.EasingStyle.Sine)
                task.delay(.07,function()
                    if not knob.Parent then return end
                    tw(knob,{Size=UDim2.new(0,KS,0,KS),Position=UDim2.new(0,v and K1 or K0,.5,0)},.38,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                end)
                if v then startDot() else stopDot() end
                if fl then Vula.Flags[fl]=tog end
            end
            function tog:Set(v) apply(v); if cb then cb(v) end end

            if val then startDot() end

            local hit=ni("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            hit.MouseEnter:Connect(function() tw(row,{BackgroundColor3=th.CardH},.14) end)
            hit.MouseLeave:Connect(function() tw(row,{BackgroundColor3=th.Card},.14) end)
            hit.MouseButton1Down:Connect(function() tw(pill,{Size=UDim2.new(0,PW*.83,0,PH*.78)},.06,Enum.EasingStyle.Quint) end)
            local busy=false
            hit.MouseButton1Click:Connect(function()
                if busy then return end; busy=true; task.delay(.38,function() busy=false end)
                tw(pill,{Size=UDim2.new(0,PW,0,PH)},.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
                tog:Set(not val)
                if cb then cb(val) end
            end)
            if fl then Vula.Flags[fl]=tog end
            return tog
        end

        -- ── Button ────────────────────────────────────────────────────────────
        function tab:CreateButton(o)
            local bN=o.Name or "Button"; local cb=o.Callback; local sub=o.Description or ""
            local ROW_H = sub~="" and 40 or 32
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,ROW_H),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo(),ClipsDescendants=true}); C(row,6)
            row:SetAttribute("origH",ROW_H)
            local rSt=St(row,th.Stroke,1,.26)
            local fill=ni("Frame",row,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Acc,BackgroundTransparency=.88,ZIndex=5}); C(fill,6)
            ni("TextLabel",row,{Size=UDim2.new(1,-28,0,18),Position=UDim2.new(0,10,0,sub~="" and 5 or 0),BackgroundTransparency=1,Text=bN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            if sub~="" then ni("TextLabel",row,{Size=UDim2.new(1,-28,0,14),Position=UDim2.new(0,10,0,22),BackgroundTransparency=1,Text=sub,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=8,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6}) end
            local arr=ni("TextLabel",row,{Size=UDim2.new(0,18,1,0),Position=UDim2.new(1,-20,0,0),BackgroundTransparency=1,Text="›",TextColor3=th.Dim,Font=Enum.Font.GothamBold,TextSize=14,ZIndex=6})
            local hit=ni("TextButton",row,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})
            hit.MouseEnter:Connect(function()
                tw(row,{BackgroundColor3=th.CardH},.14); tw(fill,{Size=UDim2.new(1,0,1,0)},.26)
                tw(rSt,{Color=th.Acc,Transparency=.52},.18);  tw(arr,{TextColor3=th.Acc},.14)
            end)
            hit.MouseLeave:Connect(function()
                tw(row,{BackgroundColor3=th.Card},.14);  tw(fill,{Size=UDim2.new(0,0,1,0)},.18)
                tw(rSt,{Color=th.Stroke,Transparency=.26},.18); tw(arr,{TextColor3=th.Dim},.14)
            end)
            hit.MouseButton1Down:Connect(function(mx,my)
                local abs=row.AbsolutePosition
                local rip=ni("Frame",row,{Size=UDim2.new(0,0,0,0),Position=UDim2.new(0,mx-abs.X,0,my-abs.Y),AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=th.Acc,BackgroundTransparency=.72,ZIndex=10}); C(rip,999)
                local sz=math.max(row.AbsoluteSize.X,row.AbsoluteSize.Y)*2.4
                tw(rip,{Size=UDim2.new(0,sz,0,sz),BackgroundTransparency=1},.44,Enum.EasingStyle.Quint)
                task.delay(.46,function() if rip.Parent then rip:Destroy() end end)
            end)
            local cd=false
            hit.MouseButton1Click:Connect(function() if cd then return end; cd=true; task.delay(.24,function() cd=false end); if cb then task.spawn(cb) end end)
            local b={}; function b:SetText(t) local l=row:FindFirstChildWhichIsA("TextLabel"); if l then l.Text=t end end; return b
        end

        -- ── Label ─────────────────────────────────────────────────────────────
        function tab:CreateLabel(text)
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,26),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()}); C(row,6); St(row,th.Stroke,1,.4)
            row:SetAttribute("origH",26)
            local lbl=ni("TextLabel",row,{Size=UDim2.new(1,-10,1,0),Position=UDim2.new(0,8,0,0),BackgroundTransparency=1,Text=text,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            return { Set=function(_,t) lbl.Text=t end, Get=function() return lbl.Text end }
        end

        -- ── Keybind ───────────────────────────────────────────────────────────
        function tab:CreateKeybind(o)
            local kN=o.Name or "Keybind"; local kD=o.CurrentKeybind or "RightShift"
            local fl=o.Flag; local cb=o.Callback; local cur=kD; local lst=false
            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,34),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()}); C(row,6); St(row,th.Stroke,1,.26)
            row:SetAttribute("origH",34)
            ni("TextLabel",row,{Size=UDim2.new(1,-80,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=kN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local chip=ni("TextButton",row,{Size=UDim2.new(0,64,0,20),Position=UDim2.new(1,-70,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.InBg,Text=cur,TextColor3=th.Acc,Font=Enum.Font.GothamBold,TextSize=8,ZIndex=7,AutoButtonColor=false}); C(chip,4)
            local cSt=St(chip,th.Acc,1,.42)
            chip.MouseButton1Click:Connect(function()
                if lst then return end; lst=true; chip.Text="..."
                tw(chip,{BackgroundColor3=th.Acc},.14); tw(cSt,{Transparency=0},.14)
            end)
            UIS.InputBegan:Connect(function(i,gpe)
                if not lst then return end
                if i.UserInputType~=Enum.UserInputType.Keyboard then return end
                lst=false; cur=i.KeyCode.Name; chip.Text=cur
                tw(chip,{BackgroundColor3=th.InBg},.14); tw(cSt,{Transparency=.42},.14)
                if cb then cb(cur) end
            end)
            local kb={CurrentKeybind=cur, Type="Keybind"}
            function kb:Set(v) cur=v; chip.Text=v end
            if fl then Vula.Flags[fl]=kb end; return kb
        end

        -- ── Slider ────────────────────────────────────────────────────────────
        function tab:CreateSlider(o)
            local sN   = o.Name       or "Slider"
            local sMin = o.Min        or 0
            local sMax = o.Max        or 100
            local sInc = o.Increment  or 1
            local sDef = clamp(o.Default or sMin, sMin, sMax)
            local fl   = o.Flag
            local cb   = o.Callback
            local sfx  = o.Suffix or ""    -- e.g. "s", "ms", "%"
            local val  = sDef
            local ROW_H= 44

            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,ROW_H),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()}); C(row,6)
            row:SetAttribute("origH",ROW_H)
            St(row,th.Stroke,1,.26)

            ni("TextLabel",row,{Size=UDim2.new(.62,0,0,16),Position=UDim2.new(0,10,0,6),BackgroundTransparency=1,Text=sN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})

            local valBg=ni("Frame",row,{Size=UDim2.new(0,38,0,16),Position=UDim2.new(1,-44,0,6),AnchorPoint=Vector2.new(0,0),BackgroundColor3=th.InBg,ZIndex=6}); C(valBg,4)
            St(valBg,th.Acc,1,.55)
            local valLbl=ni("TextLabel",valBg,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text=tostring(val)..sfx,TextColor3=th.Acc,Font=Enum.Font.GothamBold,TextSize=9,ZIndex=7})

            local TRACK_SIDE=10
            local trackBg=ni("Frame",row,{Size=UDim2.new(1,-TRACK_SIDE*2,0,4),Position=UDim2.new(0,TRACK_SIDE,1,-10),AnchorPoint=Vector2.new(0,1),BackgroundColor3=th.SliderTrack or th.Div,ZIndex=6}); C(trackBg,2)
            local trackFill=ni("Frame",trackBg,{Size=UDim2.new(0,0,1,0),BackgroundColor3=th.Acc,ZIndex=7}); C(trackFill,2)
            local KS2=14
            local thumb=ni("Frame",trackBg,{Size=UDim2.new(0,KS2,0,KS2),AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(0,0,.5,0),BackgroundColor3=th.Acc,ZIndex=8}); C(thumb,KS2//2)
            ni("UIGradient",thumb,{Rotation=135,ColorSequence=ColorSequence.new(th.Acc,th.AccD)})
            St(thumb,th.AccD,1,.25)

            local function setVal(v, fire)
                v = clamp(round(v, sInc), sMin, sMax)
                val = v
                local pct = (sMax == sMin) and 0 or (v-sMin)/(sMax-sMin)
                tw(trackFill,{Size=UDim2.new(pct,0,1,0)},.08)
                tw(thumb,    {Position=UDim2.new(pct,0,.5,0)},.08)
                valLbl.Text = tostring(v)..sfx
                if fl then Vula.Flags[fl]=v end
                if fire and cb then cb(v) end
            end

            -- Hit area
            local hit=ni("TextButton",trackBg,{Size=UDim2.new(1,TRACK_SIDE*2,0,26),Position=UDim2.new(0,-TRACK_SIDE,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundTransparency=1,Text="",ZIndex=9,AutoButtonColor=false})

            local dragging=false
            hit.InputBegan:Connect(function(i)
                if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                    dragging=true
                    tw(thumb,{Size=UDim2.new(0,KS2*1.25,0,KS2*1.25)},.1,Enum.EasingStyle.Back)
                end
            end)
            UIS.InputChanged:Connect(function(i)
                if not dragging then return end
                if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then
                    local abs=trackBg.AbsolutePosition; local sz=trackBg.AbsoluteSize
                    local relX=clamp((UIS:GetMouseLocation().X-abs.X)/sz.X,0,1)
                    setVal(sMin+relX*(sMax-sMin), false)  -- visual only while dragging
                end
            end)
            UIS.InputEnded:Connect(function(i)
                if (i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch) and dragging then
                    dragging=false
                    tw(thumb,{Size=UDim2.new(0,KS2,0,KS2)},.2,Enum.EasingStyle.Back)
                    setVal(val, true)  -- fire callback once on release
                end
            end)

            row.MouseEnter:Connect(function() tw(row,{BackgroundColor3=th.CardH},.14) end)
            row.MouseLeave:Connect(function() tw(row,{BackgroundColor3=th.Card},.14) end)

            local sl={Value=val, Type="Slider"}
            function sl:Set(v) setVal(v,false) end
            function sl:Get() return val end
            if fl then Vula.Flags[fl]=val end
            setVal(val,false)
            return sl
        end

        -- ── Input ─────────────────────────────────────────────────────────────
        function tab:CreateInput(o)
            local iN   = o.Name          or "Input"
            local iPh  = o.Placeholder   or "Type here..."
            local fl   = o.Flag
            local cb   = o.Callback
            local numO = o.NumbersOnly   or false
            local ROW_H= 52

            local row=ni("Frame",page,{Size=UDim2.new(1,0,0,ROW_H),BackgroundColor3=th.Card,ZIndex=5,LayoutOrder=eo()}); C(row,6)
            row:SetAttribute("origH",ROW_H)
            St(row,th.Stroke,1,.26)

            ni("TextLabel",row,{Size=UDim2.new(.75,0,0,14),Position=UDim2.new(0,10,0,5),BackgroundTransparency=1,Text=iN,TextColor3=th.Dim,Font=Enum.Font.GothamBold,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})

            local inputBg=ni("Frame",row,{Size=UDim2.new(1,-16,0,24),Position=UDim2.new(0,8,0,22),BackgroundColor3=th.InBg,ZIndex=6}); C(inputBg,5)
            local iSt=St(inputBg,th.Stroke,1,.28)

            local tb=ni("TextBox",inputBg,{
                Size=UDim2.new(1,-12,1,0), Position=UDim2.new(0,7,0,0),
                BackgroundTransparency=1, Text="",
                PlaceholderText=iPh, TextColor3=th.Text, PlaceholderColor3=th.Ph,
                Font=Enum.Font.GothamMedium, TextSize=9,
                TextXAlignment=Enum.TextXAlignment.Left,
                ZIndex=7, ClearTextOnFocus=false,
            })

            tb.Focused:Connect(function()
                tw(iSt,{Color=th.Acc,Transparency=.18},.15)
                tw(inputBg,{BackgroundColor3=th.Card},.15)
            end)
            tb.FocusLost:Connect(function(enter)
                if numO then
                    local n=tonumber(tb.Text); if n then tb.Text=tostring(n) else tb.Text="" end
                end
                tw(iSt,{Color=th.Stroke,Transparency=.28},.15)
                tw(inputBg,{BackgroundColor3=th.InBg},.15)
                if fl then Vula.Flags[fl]=tb.Text end
                if cb then cb(tb.Text, enter) end
            end)

            local inp={Type="Input"}
            function inp:Get() return tb.Text end
            function inp:Set(v) tb.Text=tostring(v) end
            function inp:Clear() tb.Text="" end
            if fl then Vula.Flags[fl]="" end
            return inp
        end

        -- ── Dropdown ──────────────────────────────────────────────────────────
        function tab:CreateDropdown(o)
            local dN    = o.Name    or "Select"
            local opts2 = o.Options or {}
            local multi = o.Multi ~= false
            local fl    = o.Flag;  local cb=o.Callback

            local HDRH=32; local ITMH=26
            local selected={}; local isOpen=false
            local totalH=HDRH+(#opts2*ITMH)+6

            local wrap=ni("Frame",page,{Size=UDim2.new(1,0,0,HDRH),BackgroundTransparency=1,ZIndex=5,LayoutOrder=eo(),ClipsDescendants=true})
            wrap:SetAttribute("origH",HDRH)

            local hdr=ni("Frame",wrap,{Size=UDim2.new(1,0,0,HDRH),BackgroundColor3=th.Card,ZIndex=5}); C(hdr,6)
            local hdrSt=St(hdr,th.Stroke,1,.26)

            ni("TextLabel",hdr,{Size=UDim2.new(1,-42,1,0),Position=UDim2.new(0,10,0,0),BackgroundTransparency=1,Text=dN,TextColor3=th.Text,Font=Enum.Font.GothamSemibold,TextSize=10,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=6})
            local cntBg=ni("Frame",hdr,{Size=UDim2.new(0,26,0,16),Position=UDim2.new(1,-34,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.InBg,ZIndex=7}); C(cntBg,4)
            local cntLbl=ni("TextLabel",cntBg,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="0",TextColor3=th.Acc,Font=Enum.Font.GothamBold,TextSize=8,ZIndex=8})
            local chev=ni("TextLabel",hdr,{Size=UDim2.new(0,14,1,0),Position=UDim2.new(1,-16,0,0),BackgroundTransparency=1,Text="▾",TextColor3=th.Dim,Font=Enum.Font.GothamBold,TextSize=10,ZIndex=7})

            local iFrame=ni("Frame",wrap,{Size=UDim2.new(1,0,0,#opts2*ITMH+6),Position=UDim2.new(0,0,0,HDRH+1),BackgroundColor3=th.InBg,ZIndex=5}); C(iFrame,6)
            St(iFrame,th.Stroke,1,.32); LL(iFrame,0); Pd(iFrame,4,4,3,3)

            local iBtns={}

            local function updCount()
                local n=0; for _ in pairs(selected) do n=n+1 end
                cntLbl.Text=tostring(n)
                tw(cntBg,{BackgroundColor3=n>0 and th.Acc or th.InBg},.18)
                tw(cntLbl,{TextColor3=n>0 and Color3.new(1,1,1) or th.Acc},.18)
            end

            for _, optName in ipairs(opts2) do
                local name=optName
                local ib=ni("TextButton",iFrame,{Size=UDim2.new(1,0,0,ITMH),BackgroundColor3=th.Card,BackgroundTransparency=.7,Text="",ZIndex=6,AutoButtonColor=false}); C(ib,4)
                local chk=ni("Frame",ib,{Size=UDim2.new(0,10,0,10),Position=UDim2.new(0,6,.5,0),AnchorPoint=Vector2.new(0,.5),BackgroundColor3=th.TOff,ZIndex=7}); C(chk,3)
                St(chk,th.Acc,1,.32)
                local chkM=ni("TextLabel",chk,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="✓",TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamBold,TextSize=7,TextTransparency=1,ZIndex=8})
                ni("TextLabel",ib,{Size=UDim2.new(1,-24,1,0),Position=UDim2.new(0,22,0,0),BackgroundTransparency=1,Text=name,TextColor3=th.Dim,Font=Enum.Font.GothamMedium,TextSize=9,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=7})

                local function setChk(v)
                    tw(chk,{BackgroundColor3=v and th.Acc or th.TOff},.18)
                    tw(chkM,{TextTransparency=v and 0 or 1},.18)
                    local l=ib:FindFirstChildWhichIsA("TextLabel")
                    if l and l~=chkM then tw(l,{TextColor3=v and th.Text or th.Dim},.18) end
                end

                ib.MouseButton1Click:Connect(function()
                    if not multi then for k in pairs(selected) do selected[k]=nil; if iBtns[k] then iBtns[k](false) end end end
                    selected[name]=not selected[name] or nil
                    setChk(selected[name]~=nil)
                    updCount()
                    if cb then local s={}; for k in pairs(selected) do s[#s+1]=k end; cb(s) end
                end)
                ib.MouseEnter:Connect(function() tw(ib,{BackgroundTransparency=.38},.12) end)
                ib.MouseLeave:Connect(function() tw(ib,{BackgroundTransparency=.7},.12) end)
                iBtns[name]=setChk
            end

            local hHit=ni("TextButton",hdr,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=8,AutoButtonColor=false})
            hHit.MouseButton1Click:Connect(function()
                isOpen=not isOpen
                tw(wrap,{Size=UDim2.new(1,0,0,isOpen and totalH or HDRH)},.26,Enum.EasingStyle.Quint)
                tw(chev,{Rotation=isOpen and 180 or 0},.22)
                tw(hdrSt,{Color=isOpen and th.Acc or th.Stroke, Transparency=isOpen and .42 or .26},.2)
            end)
            hHit.MouseEnter:Connect(function() tw(hdr,{BackgroundColor3=th.CardH},.14) end)
            hHit.MouseLeave:Connect(function() tw(hdr,{BackgroundColor3=th.Card},.14) end)

            local dd={Type="Dropdown", Selected=selected}
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
    end -- Win:CreateTab

    return Win
end -- Vula:CreateWindow

_g.VulaLoaded=true; _g.VulaLib=Vula
return Vula
